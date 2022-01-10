package com.kh.zipggu.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.zipggu.repository.ReviewDao;
import com.kh.zipggu.service.ReviewService;
import com.kh.zipggu.vo.ReviewInsertVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private ReviewService reviewService;
	
	@GetMapping("/insert")
	public String insert() {
		
		return "review/insert";
	}
	
	@PostMapping("/insert")
	public String insert(@ModelAttribute ReviewInsertVO reviewInsertVO, HttpSession session) throws IllegalStateException, IOException {
		
		log.debug("=================================={}", reviewInsertVO);
		
		reviewService.insert(reviewInsertVO);
		
		return "redirect:/store/detail/"+reviewInsertVO.getItemNo();
		
	}	
}
