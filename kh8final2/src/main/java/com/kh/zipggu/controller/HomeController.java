package com.kh.zipggu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class HomeController {
	@RequestMapping("/")
	public String home() {
		return "store/main";
	}
	
	@GetMapping("/help")
	public String help() {
		return "customer/qna";
	}
}
