package com.kh.zipggu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.zipggu.repository.CartDao;
import com.kh.zipggu.service.CartService;
import com.kh.zipggu.vo.CartListVO;
import com.kh.zipggu.vo.ItemOrderListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/payment")
public class PaymentController {
	
	@Autowired
	private CartDao cartDao;
	
	@Autowired
	private CartService cartService;
	
	
	//장바구니 페이지 또는 상품상세 페이지에서 저장된 상품 목록 찍어주는 기능
	@GetMapping("/list")
	public String list(Model model, @ModelAttribute ItemOrderListVO itemOrderListVO) {
		
		//log.debug("ItemOrderListVO = {}", itemOrderListVO);
		
		//페이지에서 리스트로 보내진 quantity, cartNo가 있는 VO로 조회 시작
		List<CartListVO>list = cartService.listByOrder(itemOrderListVO);
		
		//System.out.println("---------------------------------"+list);
		
		//조회된 내용으로 목록 출력
		model.addAttribute("orderList", list);
		
		return "payment/list";
	}
}
