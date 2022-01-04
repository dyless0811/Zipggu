package com.kh.zipggu.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.zipggu.service.CartService;
import com.kh.zipggu.vo.CartListVO;
import com.kh.zipggu.vo.CartVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/cart")
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	//상품 결제전 장바구니 또는 결제페이지에 가기전 등록하는 기능
	@PostMapping("/insert")
	public String insert(@ModelAttribute CartVO cartVO, HttpSession session) {
		
		//log.debug("cartVO = {}", cartVO);
		
		//회원 번호를 세션에 받아 cartVO에 저장
		cartVO.setMemberNo((int)session.getAttribute("loginNo"));
		
		//등록 시작
		cartService.insert(cartVO);
		
		//상품 상세 페이지에 남아있는다 (현재는 장바구니로 이동 버튼을 누르면 장바구니 페이지로 이동)
		return "redirect:/store/detail/"+cartVO.getItemNo();
	}
	
	//장바구니 페이지에서 목록 찍어주는 기능
	@GetMapping("/list")
	public String list(Model model, HttpSession session) {
		
		//회원번호 저장
		int memberNo = (int)session.getAttribute("loginNo");
		
		//저장된 회원번호로 장바구니에 추가한 상품 조회
		List<CartListVO> cartListVO = cartService.list(memberNo);
		
		//모델로 전달하여 페이지에 찍어준다
		model.addAttribute("cartListVO", cartListVO);
		
		return "cart/list";
	}
	
}
