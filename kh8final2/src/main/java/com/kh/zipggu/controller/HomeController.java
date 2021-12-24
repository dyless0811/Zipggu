package com.kh.zipggu.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
public class HomeController {
	@RequestMapping("/")
	public String home() {
		return "home";
	}
	
	@GetMapping("/sessionin")
	public String sessionIn(HttpSession session) {
		session.setAttribute("loginNo", "1");
		session.setAttribute("loginEmail", "master@master.com");
		session.setAttribute("loginNick", "master");
		return "redirect:/";
	}
	@GetMapping("/sessionout")
	public String sessionOut(HttpSession session) {
		session.removeAttribute("loginId");
		session.removeAttribute("loginGrade");
		session.removeAttribute("loginNo");
		session.removeAttribute("loginEmail");
		session.removeAttribute("loginNick");
		return "redirect:/";
	}
}
