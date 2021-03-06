package com.kh.zipggu.controller;


import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException.Unauthorized;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kh.zipggu.repository.CertificationDao;
import com.kh.zipggu.service.EmailService;
import com.kh.zipggu.service.FollowService;
import com.kh.zipggu.service.KakaoPayService;
import com.kh.zipggu.entity.CertificationDto;
import com.kh.zipggu.entity.MemberDto;
import com.kh.zipggu.entity.MemberProfileDto;
import com.kh.zipggu.entity.OrdersDto;
import com.kh.zipggu.naver.NaverLoginBO;
import com.kh.zipggu.repository.MemberDao;
import com.kh.zipggu.repository.MemberProfileDao;
import com.kh.zipggu.repository.OrderDetailDao;
import com.kh.zipggu.repository.OrdersDao;
import com.kh.zipggu.service.MemberService;
import com.kh.zipggu.service.OrderService;
import com.kh.zipggu.vo.FollowVO;
import com.kh.zipggu.vo.MemberJoinVO;
import com.kh.zipggu.vo.MemberListVO;
import com.kh.zipggu.vo.OrderListVO;
import com.kh.zipggu.vo.OrderSearchVO;

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

	/* memberProfileImage */
	private File directory = new File("D:/upload/kh8b/member");
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	@GetMapping("/login")
	public String login(Model model, HttpSession session) {
		/* ????????????????????? ?????? URL??? ???????????? ????????? naverLoginBO???????????? getAuthorizationUrl????????? ?????? */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		System.out.println("?????????:" + naverAuthUrl);
		// ?????????
		model.addAttribute("naverAuthUrl", naverAuthUrl);
		return "member/login";
	}

	@PostMapping("/login")
	public String login(@ModelAttribute MemberListVO memberListVO, // ????????????
			@RequestParam(required = false) String saveId, // ????????? ??????(??????)
			HttpServletResponse response, // ?????? ????????? ?????? ????????????
			HttpSession session) {// ????????????
		// ???????????? ???????????? ??? ???????????? ????????????
		MemberListVO findDto = memberDao.login(memberListVO);
		log.debug("{}", memberListVO);
		if (findDto != null) {
			// ????????? ???????????? root??? ???????????????
			session.setAttribute("loginNo", findDto.getMemberNo());
			session.setAttribute("loginEmail", findDto.getMemberEmail());
			session.setAttribute("loginNick", findDto.getMemberNickname());
			session.setAttribute("loginGrade", findDto.getMemberGrade());	
			session.setAttribute("loginProfileNo", findDto.getMemberProfileNo());	

			// ????????? ????????? ????????? ???????????? ??????
			if (saveId != null) {// ?????? ?????????(saveId?????? ??????????????????)
				// ??????
				Cookie c = new Cookie("saveId", findDto.getMemberEmail());
				// c.setMaxAge(2 * 7 * 24 * 60 * 60);//2???
				c.setMaxAge(4 * 7 * 24 * 60 * 60);// 4???
				// c.setMaxAge(Integer.MAX_VALUE);//?????????
				response.addCookie(c);
			} else {// ?????? ????????????(saveId?????? ???????????? ????????????)
					// ??????
				Cookie c = new Cookie("saveId", findDto.getMemberEmail());
				c.setMaxAge(0);
				response.addCookie(c);
			}
			
			return "redirect:/";
		} else {
			return "redirect:login?error";

		}
	}

	
	@GetMapping("/naverJoin")
	public String naverJoin(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException {
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// 1. ????????? ????????? ????????? ????????????.
		apiResult = naverLoginBO.getUserProfile(oauthToken); // String????????? json?????????
		// 2. String????????? apiResult??? json????????? ??????
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		// 3. ????????? ??????
		// Top?????? ?????? _response ??????
		JSONObject response_obj = (JSONObject) jsonObj.get("response");
		// response??? nickname??? ??????
		String pw = (String) response_obj.get("id");
		String email = (String) response_obj.get("email");
		String nickname = (String) response_obj.get("nickname");
		String gender = (String) response_obj.get("gender");
		String birthyear = (String) response_obj.get("birthyear");
		String birthday = (String) response_obj.get("birthday");

		MemberListVO memberListVO = new MemberListVO();
		memberListVO.setMemberPw(pw);
		memberListVO.setMemberEmail(email);
		memberListVO.setMemberNickname(nickname);
		memberListVO.setMemberGender(gender);
		memberListVO.setMemberBirth(birthyear+birthday);
		


		System.out.println("response_obj= " + response_obj);
		System.out.println("apiResult= " + apiResult);

		// 4.?????? ????????? ???????????? ??????

		MemberListVO findVO = memberDao.emailGet(email);
		System.out.println("check= " + findVO);

		if (findVO == null) { // ???????????? ????????? ????????? ??????

			model.addAttribute("memberListVO", memberListVO);
			
			return "member/naverJoin";

		} else {
		
		MemberListVO find = memberDao.login(memberListVO);
		if (find != null) {
			// ????????? ???????????? root??? ???????????????
			session.setAttribute("loginNo", find.getMemberNo());
			session.setAttribute("loginEmail", find.getMemberEmail());
			session.setAttribute("loginNick", find.getMemberNickname());
			session.setAttribute("loginGrade", find.getMemberGrade());	
			session.setAttribute("loginProfileNo", find.getMemberProfileNo());	
			model.addAttribute("result", apiResult);

			return "redirect:/";
			
		} else {
			return "redirect:login?error";	
		}	
		
		}
	}

	
	@PostMapping("/naverJoin")
	public String naverJoin(@ModelAttribute MemberListVO memberListVO) throws IllegalStateException, IOException {
		
		memberDao.snsJoin(memberListVO);

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



	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginNo");
		session.removeAttribute("loginEmail");
		session.removeAttribute("loginNick");
		session.removeAttribute("loginGrade");
		session.removeAttribute("loginProfileNo");
		
		return "redirect:/";
	}

	@GetMapping("/join")
	public String join(Model model, HttpSession session) {
		/* ????????????????????? ?????? URL??? ???????????? ????????? naverLoginBO???????????? getAuthorizationUrl????????? ?????? */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		System.out.println("?????????:" + naverAuthUrl);
		// ?????????
		model.addAttribute("naverAuthUrl", naverAuthUrl);

		return "member/join";
	}

	@PostMapping("/join")
	public String join(@ModelAttribute MemberJoinVO memberJoinVO) throws IllegalStateException, IOException {
		memberService.join(memberJoinVO);
		return "redirect:/";
	}

//	???????????? ??????
	@GetMapping("/password")
	public String password() {
		return "member/password";
	}

	@PostMapping("/password")
	public String password(@RequestParam String changePw, HttpSession session) {
		String memberEmail = (String) session.getAttribute("loginEmail");

		boolean result = memberDao.changePassword(memberEmail,  changePw);
		if (result) {
			return "redirect:password";
		} else {
			return "redirect:password?error";
		}
	}


	@GetMapping("/withdrawal")
	public String withdrawals() {
		return "member/withdrawal";
	}

	@PostMapping("/withdrawal")
	public String quit(HttpSession session) {
		String memberEmail = (String) session.getAttribute("loginEmail");

		boolean result = memberDao.quit(memberEmail);
		if (result) {
			session.removeAttribute("loginNo");
			session.removeAttribute("loginEmail");
			session.removeAttribute("loginNick");
			session.removeAttribute("loginGrade");
			session.removeAttribute("loginProfileNo");

			return "redirect:/";
		} else {
			return "redirect:withdrawal?error";
		}
	}

	@RequestMapping("/quit_success")
	public String quitSuccess() {
		return "member/quit_success";
	}

//	????????? ??????????????? ?????? ?????? ??????
//	= (??????) ??? ???????????? ???????????? ?????????. @ResponseBody ??? ???????????? ?????? ????????????
//	= ???????????? ????????? ?????? ????????? ???????????? ??????????????? ????????? ???????????? ????????? ??? ????????? ??????
//	= ResponseEntity??? ???????????? ??????(??????)??? ?????? ????????? ??? ????????? ???????????? Spring ??????
//	= ByteArrayResource??? ????????? ?????? ????????? ????????? ?????? ??? ?????? Spring ??????
	@GetMapping("/profile")
	@ResponseBody // ??? ?????????????????? ??? ???????????? ?????? ?????????
	public ResponseEntity<ByteArrayResource> profile(@RequestParam int memberNo) throws IOException {

		// ???????????????(memberProfileNo)??? ????????? ????????? ??????????????? ?????????.
		MemberProfileDto memberProfileDto = memberProfileDao.noGet(memberNo);
		if(memberProfileDto == null) {
			File target = new File(directory, "dummy");

			byte[] data = FileUtils.readFileToByteArray(target);
			ByteArrayResource resource = new ByteArrayResource(data); 
			
			String encodeName = URLEncoder.encode("dummy.png", "UTF-8");
			encodeName = encodeName.replace("+", "%20");
			
			return ResponseEntity.ok()
					.contentType(MediaType.APPLICATION_OCTET_STREAM)
					.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
					.header("content-Encoding", "UTF-8")
					.contentLength(1132)
					.body(resource);
		}
		// ???????????????(memberProfileNo)??? ?????? ?????? ????????? ????????????
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
	 * ?????? ?????????????????? ???????????? ????????? ???????????? ????????? ?????? try { ?????? ??????????????? ?????? ???????????? } catch(Exception e){
	 * ????????? ????????? ???????????? ??????... }
	 */
//	@ExceptionHandler(Exception.class)
//	public String handler(Exception e) {
//		//??????(logging) ?????? ?????? ?????? ?????? ??????
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

	// ????????? ????????? ??????
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
	
	
	// ????????? ????????? ??????
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

	// ????????? ??????
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
	public String profileEdit(@ModelAttribute MemberDto memberDto, MultipartFile attach, HttpSession session) throws IllegalStateException, IOException {
		

		memberService.edit(memberDto, attach);
		session.removeAttribute("loginNick");
		session.setAttribute("loginNick", memberDto.getMemberNickname());
		
		return "redirect:profileEdit";
	}

	
	//?????? ?????? ?????????
	@RequestMapping("/memberList")
	public String memberList(Model model, @ModelAttribute MemberListVO memberListVO) throws Exception {
		
	
		model.addAttribute("memberListVO", memberService.VOlist(memberListVO));
		
		return "member/memberList";
	}
	

	// ?????? ?????????
	@RequestMapping("/page")
	public String page(@RequestParam int memberNo ,@ModelAttribute FollowVO followVO ,Model model, HttpSession session) {
	
		MemberDto memberDto = memberDao.noGet(memberNo);
		MemberProfileDto memberProfileDto = memberProfileDao.noGet(memberNo);

		// ??????????????????
		int followerCount = followService.followerCount(memberNo);	
		
		// ??????????????????
		int followingCount = followService.followingCount(memberNo);

		
		
		if(session.getAttribute("loginNo") != null) {
		
		int followerUser = (int) session.getAttribute("loginNo");
		int followingUser = memberNo;

		followVO.setFollowerUser(followerUser);
		followVO.setFollowingUser(followingUser);
		
		int followCheck = followService.isFollow(followVO);		
		
		model.addAttribute("followCheck", followCheck);
		
		}
		model.addAttribute("followerCount", followerCount);
		model.addAttribute("followingCount", followingCount);		
		model.addAttribute("followingCount", followingCount);	
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("memberProfileDto", memberProfileDto);

		return "member/page";
	}
	
	@RequestMapping("orders")
	public String orders(Model model, HttpSession session) {
		if(session.getAttribute("loginNo") == null) {
			return "redirect:/member/login/";
		}
		model.addAttribute("memberDto", memberDao.noGet((int) session.getAttribute("loginNo")));
		
		return "member/orders";
	}
    // ????????? ?????? ??????
    @PostMapping("/emailConfirm")
    @ResponseBody
    public int emailConfirm(@RequestParam String memberEmail){

        int emailConfirm = memberService.emailConfirm(memberEmail);
        
        return emailConfirm;
    }

    // ????????? ?????? ??????
    @PostMapping("/nickConfirm")
    @ResponseBody
    public int nickConfirm(@RequestParam String memberNickname){

        int nickConfirm = memberService.nickConfirm(memberNickname);
        
        return nickConfirm;
    }

	
	@Autowired
	private OrderService orderService;
	
	@PostMapping("/order/list")
	@ResponseBody
	public List<OrderListVO> adminOrderList(@ModelAttribute OrderSearchVO orderSearchVO,
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "10") int size,
			@RequestParam(required = false, defaultValue = "0") int admin,
			HttpSession session) {
		
		int endRow = page * size;
		int startRow = endRow - (size - 1);
		int memberNo = (int)session.getAttribute("loginNo");
		if(admin != 0) {
			memberNo = 0;
		}
		
		orderSearchVO.setStartRow(startRow);
		orderSearchVO.setEndRow(endRow);
		orderSearchVO.setMemberNo(memberNo);
		
		List<OrderListVO> a = orderService.listBySearchVO(orderSearchVO);
		log.debug("=============================={}", a);
		return a;
	}
	
	@Autowired
	private OrdersDao ordersDao;
	@Autowired
	private OrderDetailDao orderDetailDao;
	@Autowired
	private KakaoPayService kakaoPayService;
	
	@GetMapping("/order/detail/{orderNo}")
	public String orderDetail(@PathVariable int orderNo, Model model, HttpSession session) throws URISyntaxException {
		if(session.getAttribute("loginNo") != null) {
			model.addAttribute("memberDto", memberDao.noGet((int)session.getAttribute("loginNo")));
		}
		OrdersDto ordersDto = ordersDao.get(orderNo);
		model.addAttribute("ordersDto", ordersDto);
		log.debug("=================================={}", ordersDto);
		log.debug("=================================={}", orderNo);
		log.debug("=================================={}", orderDetailDao.list(orderNo));
		model.addAttribute("orderDetailList", orderDetailDao.orderDetailCustom(orderNo));
		model.addAttribute("responseVO", kakaoPayService.search(ordersDto.getTid()));
		
		return "member/orders/detail";
	}
	
	@RequestMapping("/delivery")
	public String delivery(HttpSession session, Model model) {
		
		int memberNo = (int)session.getAttribute("loginNo");
		MemberDto memberDto = memberDao.noGet(memberNo);

		model.addAttribute("memberDto", memberDto);
		return "member/delivery";
	}
	
//	???????????? ?????????
	@GetMapping("/passwordReset")
	public String passwordReset() {
		return "member/passwordReset";
	}

	@PostMapping("/passwordReset")
	public String passwordReset(@RequestParam String memberEmail, @RequestParam String changePw, HttpSession session) {

		boolean result = memberDao.changePassword(memberEmail,  changePw);
		if (result) {
			return "redirect:/";
		} else {
			return "redirect:passwordReset?error";
		}
	}
	
}
