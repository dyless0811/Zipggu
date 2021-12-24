package com.kh.zipggu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/store")
public class StoreController {
	
	@RequestMapping("")
	public String main() {
		return "store/main";
	}
}
