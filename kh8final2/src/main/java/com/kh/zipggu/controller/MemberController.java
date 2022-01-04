package com.kh.zipggu.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kh.zipggu.repository.CertificationDao;
import com.kh.zipggu.service.EmailService;
import com.kh.zipggu.service.FollowService;
import com.kh.zipggu.entity.CertificationDto;
import com.kh.zipggu.entity.MemberDto;
import com.kh.zipggu.entity.MemberProfileDto;
import com.kh.zipggu.naver.NaverLoginBO;
import com.kh.zipggu.repository.MemberDao;
import com.kh.zipggu.repository.MemberProfileDao;
import com.kh.zipggu.service.MemberService;
import com.kh.zipggu.vo.MemberJoinVO;
import com.kh.zipggu.vo.MemberListVO;
import com.kh.zipggu.vo.NaverMemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private MemberService memberService;

	@Autowired
	private MemberProfileDao memberProfileDao;

	@Autowired
	private EmailService emailService;

	@Autowired
	private CertificationDao certificationDao;

	@Autowired
	JavaMailSenderImpl mailSender;

	@Autowired
	private FollowService followService;
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	@GetMapping("/login")
	public String login(Model model, HttpSession session) {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		System.out.println("네이버:" + naverAuthUrl);
		// 네이버
		model.addAttribute("naverAuthUrl", naverAuthUrl);
		return "member/login";
	}

	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto memberDto, // 회원정보
			@RequestParam(required = false) String saveId, // 아이디 저장(선택)
			HttpServletResponse response, // 쿠키 생성을 위한 응답객체
			HttpSession session) {// 세션객체
		// 회원정보 단일조회 및 비밀번호 일치판정
		MemberDto findDto = memberDao.login(memberDto);
		log.debug("{}", memberDto);
		if (findDto != null) {
			// 세션에 설정하고 root로 리다이렉트
			session.setAttribute("loginNo", findDto.getMemberNo());
			session.setAttribute("loginEmail", findDto.getMemberEmail());
			session.setAttribute("loginNick", findDto.getMemberNickname());
			session.setAttribute("loginGrade", findDto.getMemberGrade());	

			// 쿠키와 관련된 아이디 저장하기 처리
			if (saveId != null) {// 체크 했다면(saveId값이 전송되었다면)
				// 생성
				Cookie c = new Cookie("saveId", findDto.getMemberEmail());
				// c.setMaxAge(2 * 7 * 24 * 60 * 60);//2주
				c.setMaxAge(4 * 7 * 24 * 60 * 60);// 4주
				// c.setMaxAge(Integer.MAX_VALUE);//무한대
				response.addCookie(c);
			} else {// 체크 안했다면(saveId값이 전송되지 않았다면)
					// 삭제
				Cookie c = new Cookie("saveId", findDto.getMemberEmail());
				c.setMaxAge(0);
				response.addCookie(c);
			}

			return "redirect:/";
		} else {
			return "redirect:login?error";

		}
	}

	@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException {
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// 1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken); // String형식의 json데이터
		// 2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		// 3. 데이터 파싱
		// Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject) jsonObj.get("response");
		// response의 nickname값 파싱
		String id = (String) response_obj.get("id");
		String email = (String) response_obj.get("email");
		String nickname = (String) response_obj.get("nickname");
		String gender = (String) response_obj.get("gender");
		String birthyear = (String) response_obj.get("birthyear");
		String birthday = (String) response_obj.get("birthday");
		String profile_image = (String) response_obj.get("profile_image");

		NaverMemberVO naverMemverVO = new NaverMemberVO();
		naverMemverVO.setId(id);
		naverMemverVO.setEmail(email);
		naverMemverVO.setNickname(nickname);
		naverMemverVO.setGender(gender);
		naverMemverVO.setBirthyear(birthyear);
		naverMemverVO.setBirthday(birthday);
		naverMemverVO.setProfile_image(profile_image);
//	naverMemverVO.setNaver_login(true);

		System.out.println("response_obj= " + response_obj);
		System.out.println("apiResult= " + apiResult);

		// 4.파싱 닉네임 세션으로 저장

		MemberDto memberDto = memberDao.emailGet(email);
		System.out.println("check= " + memberDto);

		if (memberDto == null) { // 일치하는 이메일 없으면 가입

			model.addAttribute("email", email);
			model.addAttribute("password", id);
			model.addAttribute("nickname", nickname);
			model.addAttribute("gender", gender);
			model.addAttribute("birthyear", birthyear);
			model.addAttribute("birthday", birthday);
			model.addAttribute("birthyear", birthyear);
			model.addAttribute("profile_image", profile_image);

			System.out.println("loginEmail= " + email);
			System.out.println("email= " + email);
			System.out.println("id= " + id);
			System.out.println("nickname= " + nickname);
			System.out.println("gender= " + gender);
			System.out.println("birthyear= " + birthyear);
			System.out.println("birthday= " + birthday);
			System.out.println("birthyear= " + birthyear);
			System.out.println("profile_image= " + profile_image);
			return "member/callback";

		}

		session.setAttribute("naverMemverVO", naverMemverVO);
		session.setAttribute("loginEmail", email);
		model.addAttribute("result", apiResult);
		System.out.println("loginEmail= " + email);
		System.out.println("email= " + email);
		System.out.println("id= " + id);
		System.out.println("nickname= " + nickname);
		System.out.println("gender= " + gender);
		System.out.println("birthyear= " + birthyear);
		System.out.println("birthday= " + birthday);
		System.out.println("birthyear= " + birthyear);
		System.out.println("profile_image= " + profile_image);

		return "redirect:/";
	}

	@RequestMapping("/usepolicy")
	public String usepolicy() {
		return "member/usepolicy";
	}

	@RequestMapping("/privacy")
	public String privacy() {
		return "member/privacy";
	}

	@RequestMapping("/snsJoin")
	public String snsJoin() {
		return "member/snsJoin";
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginNo");
		session.removeAttribute("loginEmail");
		session.removeAttribute("loginNick");
		session.removeAttribute("loginGrade");
		
		return "redirect:/";
	}

	@GetMapping("/join")
	public String join(Model model, HttpSession session) {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		System.out.println("네이버:" + naverAuthUrl);
		// 네이버
		model.addAttribute("naverAuthUrl", naverAuthUrl);

		return "member/join";
	}

	@PostMapping("/join")
	public String join(@ModelAttribute MemberJoinVO memberJoinVO) throws IllegalStateException, IOException {
		memberService.join(memberJoinVO);
		return "redirect:join_success";
	}

	@RequestMapping("/join_success")
	public String joinSuccess() {
		return "member/join_success";
	}

	@PostMapping("/snsJoin")
	public String join2(@ModelAttribute MemberDto memberDto) throws IllegalStateException, IOException {
		memberDao.join(memberDto);

		return "redirect:join_success";
	}

	// 내정보
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		int memberNo = (int) session.getAttribute("loginNo");

		MemberDto memberDto = memberDao.noGet(memberNo);
		MemberProfileDto memberProfileDto = memberProfileDao.noGet(memberNo);

		model.addAttribute("memberDto", memberDto);
		model.addAttribute("memberProfileDto", memberProfileDto);

		return "member/mypage";
	}

//	비밀번호 변경
	@GetMapping("/password")
	public String password() {
		return "member/password";
	}

	@PostMapping("/password")
	public String password(@RequestParam String memberPw, @RequestParam String changePw, HttpSession session) {
		String memberEmail = (String) session.getAttribute("loginEmail");

		boolean result = memberDao.changePassword(memberEmail, memberPw, changePw);
		if (result) {
			return "redirect:password_success";
		} else {
			return "redirect:password?error";
		}
	}

	@RequestMapping("/password_success")
	public String passwordSuccess() {
		return "member/password_success";
	}

	@GetMapping("/edit")
	public String edit(HttpSession session, Model model) {
		String memberEmail = (String) session.getAttribute("loginEmail");
		MemberDto memberDto = memberDao.get(memberEmail);

		model.addAttribute("memberDto", memberDto);

		return "member/edit";
	}

	@PostMapping("/edit")
	public String edit(@ModelAttribute MemberDto memberDto, HttpSession session) {
		String memberEmail = (String) session.getAttribute("loginEmail");
		memberDto.setMemberEmail(memberEmail);

		boolean result = memberDao.changeInformation(memberDto);
		if (result) {
			return "redirect:edit_success";
		} else {
			return "redirect:edit?error";
		}
	}

	@RequestMapping("/edit_success")
	public String editSuccess() {
		return "member/edit_success";
	}

	@GetMapping("/quit")
	public String quit() {
		return "member/quit";
	}

	@PostMapping("/quit")
	public String quit(HttpSession session, @RequestParam String memberPw) {
		String memberEmail = (String) session.getAttribute("loginEmail");

		boolean result = memberDao.quit(memberEmail, memberPw);
		if (result) {
			session.removeAttribute("ses");
			session.removeAttribute("grade");

			return "redirect:quit_success";
		} else {
			return "redirect:quit?error";
		}
	}

	@RequestMapping("/quit_success")
	public String quitSuccess() {
		return "member/quit_success";
	}

//	프로필 다운로드에 대한 요청 처리
//	= (주의) 뷰 리졸버가 적용되면 안된다. @ResponseBody 를 사용하면 무시 처리된다
//	= 문자열이 아니라 파일 정보를 반환해서 스프링으로 하여금 다운로드 처리할 수 있도록 부탁
//	= ResponseEntity는 데이터와 정보(헤더)를 같이 설정할 수 있도록 만들어진 Spring 도구
//	= ByteArrayResource는 바이트 배열 형태의 자원을 담을 수 있는 Spring 도구
	@GetMapping("/profile")
	@ResponseBody // 이 메소드만큼은 뷰 리졸버를 쓰지 않겠다
	public ResponseEntity<ByteArrayResource> profile(@RequestParam int memberNo) throws IOException {

		// 프로필번호(memberProfileNo)로 프로필 이미지 파일정보를 구한다.
		MemberProfileDto memberProfileDto = memberProfileDao.noGet(memberNo);

		// 프로필번호(memberProfileNo)로 실제 파일 정보를 불러온다
		byte[] data = memberProfileDao.load(memberProfileDto.getMemberProfileNo());
		ByteArrayResource resource = new ByteArrayResource(data);

		String encodeName = URLEncoder.encode(memberProfileDto.getMemberProfileUploadname(), "UTF-8");
		encodeName = encodeName.replace("+", "%20");

		return ResponseEntity.ok().contentType(MediaType.APPLICATION_OCTET_STREAM)
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodeName + "\"")
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8").contentLength(memberProfileDto.getMemberProfileSize())
				.body(resource);
	}

	/**
	 * 현재 컨트롤러에서 발생하는 예외를 처리하는 핸들러 매핑 try { 현재 컨트롤러의 모든 메소드들 } catch(Exception e){
	 * 이곳의 내용을 작성하는 느낌... }
	 */
//	@ExceptionHandler(Exception.class)
//	public String handler(Exception e) {
//		//로그(logging) 생성 또는 기타 처리 추가
//		return "error/500";
//	}

//	@RequestMapping(value = "/mailCheck", method = { RequestMethod.GET })
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheck(@RequestParam String memberEmail) throws Exception {

		String num = "";
		try {
			emailService.sendCertificationNumber(memberEmail);
		} catch (Exception e) {
			num = "error";
			return num;
		}
		return num;
	}

//	@RequestMapping(value = "/serialCheck", method = { RequestMethod.GET })
	@GetMapping("/serialCheck")
	@ResponseBody
	public String serialCheck(@RequestParam String memberEmail, @RequestParam String serial) throws Exception {
		CertificationDto certificationDto = certificationDao.get(memberEmail, serial);

		String num2 = "";

		if (certificationDto != null) {

			boolean success = certificationDao.check(certificationDto);

			if (success) {
				num2 = certificationDto.getSerial();
				return num2;

			} else {
				num2 = "error";
				return num2;
			}
		}

		else {
			num2 = "error";
			return num2;
		}

	}

	// 프로필 이미지 삭제
	@GetMapping("/profileDelete")
	public String profileDelete(@RequestParam int memberNo) {

		memberProfileDao.delete(memberNo);
		
		return "redirect:profileEdit";
	}

//	@GetMapping("/profileEdit2")
//	public String profileEdit2(HttpSession session, Model model) {
//		int memberNo = (int) session.getAttribute("loginNo");
//		MemberProfileDto memberProfileDto = memberProfileDao.noGet(memberNo);
//
//		model.addAttribute("memberProfileDto", memberProfileDto);
//
//		return "member/profileEdit2";
//
//	}
//
//	@PostMapping("/profileEdit2")
//	public String profileEdit2(@ModelAttribute MemberJoinVO memberJoinVO, HttpSession session)
//			throws IllegalStateException, IOException {
//		return "redirect:profileEdit2";
//	}
	
	
	// 프로필 이미지 등록
//	@GetMapping("/upload")
//	public String upload(HttpSession session, Model model) {
//		String memberEmail = (String) session.getAttribute("loginEmail");
//		int memberNo = (int) session.getAttribute("loginNo");
//
//		MemberDto memberDto = memberDao.get(memberEmail);
//		MemberProfileDto memberProfileDto = memberProfileDao.noGet(memberNo);
//
//		model.addAttribute("memberDto", memberDto);
//		model.addAttribute("memberProfileDto", memberProfileDto);
//
//		return "member/upload";
//	}

	
//	@PostMapping("/upload")
//	public String upload(@ModelAttribute MemberUploadVO memberUploadVO, HttpSession session) throws IllegalStateException, IOException {
//		int memberNo = (int) session.getAttribute("loginNo");
//
//		memberService.upload(memberUploadVO, memberNo);
//		return "redirect:upload";
//	}

	// 프로필 수정
	@GetMapping("/profileEdit")
	public String profileEdit(Model model, HttpSession session) {
		
		int memberNo = (int)session.getAttribute("loginNo");
		MemberDto memberDto = memberDao.noGet(memberNo);
		MemberProfileDto memberProfileDto = memberProfileDao.noGet(memberNo);

		model.addAttribute("memberDto", memberDto);
		model.addAttribute("memberProfileDto", memberProfileDto);
		return "member/profileEdit";
	}

	@PostMapping("/profileEdit")
	public String profileEdit(@ModelAttribute MemberDto memberDto, MultipartFile attach) throws IllegalStateException, IOException {
		

		memberService.edit(memberDto, attach);
		
		return "redirect:profileEdit";
	}

	
	//임시 회원 리스트
	@RequestMapping("/memberList")
	public String memberList(Model model, @ModelAttribute MemberListVO memberListVO) throws Exception {
		
		model.addAttribute("memberListVO", memberService.VOlist(memberListVO));

		return "member/memberList";
	}
	

	// 개인 페이지
	@RequestMapping("/page")
	public String page(@RequestParam int memberNo ,HttpSession session, Model model) {
	
		MemberDto memberDto = memberDao.noGet(memberNo);
		MemberProfileDto memberProfileDto = memberProfileDao.noGet(memberNo);

		// 팔로워카운트
		int followerCount = followService.followerCount(memberNo);	
		
		// 팔로잉카운트
		int followingCount = followService.followingCount(memberNo);
	
		model.addAttribute("followerCount", followerCount);
		model.addAttribute("followingCount", followingCount);		

		model.addAttribute("followingCount", followingCount);	
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("memberProfileDto", memberProfileDto);

		return "member/page";
	}
	
}
