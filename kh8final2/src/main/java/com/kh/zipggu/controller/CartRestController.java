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
	
	@DeleteMapping("/delete")
	public void delete(@RequestParam int cartNo) {
		
		cartDao.delete(cartNo);
	}
	
}
