package com.kh.zipggu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.zipggu.repository.CartDao;
import com.kh.zipggu.service.CartService;
import com.kh.zipggu.vo.CartListVO;
import com.kh.zipggu.vo.ItemOrderListVO;
import com.kh.zipggu.vo.ItemOrderVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/payment")
public class paymentController {
	
	@Autowired
	private CartDao cartDao;
	
	@Autowired
	private CartService cartService;
	
	@GetMapping("/list")
	public String list(Model model, @ModelAttribute ItemOrderListVO itemOrderListVO) {
		
		log.debug("ItemOrderListVO = {}", itemOrderListVO);
		
	
		List<CartListVO>list = cartService.listByOrder(itemOrderListVO);
		System.out.println("---------------------------------"+list);
		model.addAttribute("orderList", list);
		
		return "payment/list";
	}
}