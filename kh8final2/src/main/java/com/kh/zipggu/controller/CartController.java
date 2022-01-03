package com.kh.zipggu.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.zipggu.service.CartService;
import com.kh.zipggu.vo.CartVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/cart")
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute CartVO cartVO, HttpSession session) {
		
		log.debug("cartVO = {}", cartVO);
		cartVO.setMemberNo((int)session.getAttribute("loginNo"));
		
		cartService.insert(cartVO);
		
		return "redirect:/store/detail/"+cartVO.getItemNo();
	}
//	
//	@GetMapping("/list")
//	public String list(Model model) {
//		
//		
//	}
	
}
