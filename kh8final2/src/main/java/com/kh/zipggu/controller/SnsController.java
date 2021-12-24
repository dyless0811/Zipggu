package com.kh.zipggu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/sns")
public class SnsController {
	
	@RequestMapping("/list")
	public String sns() {
		return "sns/list";
	}
	
	@RequestMapping("/write")
	public String write() {
		return "sns/write";
	}
}
