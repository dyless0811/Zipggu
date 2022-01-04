package com.kh.zipggu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.zipggu.repository.CartDao;

@RestController
@RequestMapping("/cart")
public class CartRestController {

	@Autowired
	private CartDao cartDao;

	//장바구니에서 상품 삭제 기능
	@DeleteMapping("/delete")
	public void delete(@RequestParam int cartNo) {
		
		//파라미터로 전달받은 카트번호로 삭제 시작
		cartDao.delete(cartNo);
	}
	
}
