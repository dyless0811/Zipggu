package com.kh.zipggu.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.zipggu.repository.MemberDao;
import com.kh.zipggu.service.KakaoService;
import com.kh.zipggu.vo.MemberListVO;

@Controller
@RequestMapping("/member")
public class KakaoController {

	@Autowired
	MemberDao memberDao;

	@Autowired
	KakaoService kakaoService;

	@GetMapping("/kakaoLogin")
	public String kakaoLogin() {
		StringBuffer loginUrl = new StringBuffer();
		loginUrl.append("https://kauth.kakao.com/oauth/authorize?client_id=");
		loginUrl.append("4a2a0753564d5f6612b3afc1a856191d");
		loginUrl.append("&redirect_uri=");
		loginUrl.append("http://121.132.223.55:8080/zipggu/member/kakaoJoin");
		loginUrl.append("&response_type=code");

		return "redirect:" + loginUrl.toString();
	}

	@GetMapping("/kakaoJoin")
	public String kakaoJoin(@RequestParam String code, HttpSession session, Model model) throws IOException {
		System.out.println(code);

		// 접속토큰 get
		String kakaoToken = kakaoService.getReturnAccessToken(code);

		// 접속자 정보 get
		Map<String, Object> result = kakaoService.getUserInfo(kakaoToken);
		System.out.println("result ==================================================" + result);
		System.out.println("result ==================================================" + result.get("email"));
		System.out.println("result ==================================================" + result.get("nickname"));
		System.out.println("result ==================================================" + result.get("id"));

		MemberListVO memberListVO = new MemberListVO();
		memberListVO.setMemberPw((String) result.get("id"));
		memberListVO.setMemberEmail((String) result.get("email"));
		memberListVO.setMemberNickname((String) result.get("nickname"));
		System.out.println("memberListVO==================================================" + memberListVO);

		MemberListVO findVO = memberDao.emailGet((String) result.get("email"));
		System.out.println("check= " + findVO);

		if (findVO == null) { // 일치하는 이메일 없으면 가입

			model.addAttribute("memberListVO", memberListVO);

			return "member/kakaoJoin";

		} else {

			MemberListVO find = memberDao.login(memberListVO);
			if (find != null) {
				// 세션에 설정하고 root로 리다이렉트
				session.setAttribute("loginNo", find.getMemberNo());
				session.setAttribute("loginEmail", find.getMemberEmail());
				session.setAttribute("loginNick", find.getMemberNickname());
				session.setAttribute("loginGrade", find.getMemberGrade());
				session.setAttribute("loginProfileNo", find.getMemberProfileNo());

				return "redirect:/";

			} else {
				return "redirect:login?error";
			}

		}
	}

	@PostMapping("/kakaoJoin")
	public String kakaoJoin(@ModelAttribute MemberListVO memberListVO) throws IllegalStateException, IOException {

		memberDao.snsJoin(memberListVO);

		return "redirect:/";
	}

}
