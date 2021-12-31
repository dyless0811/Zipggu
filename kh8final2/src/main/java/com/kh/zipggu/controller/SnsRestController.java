package com.kh.zipggu.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.zipggu.entity.SnsLikeDto;
import com.kh.zipggu.repository.SnsLikeDao;
import com.kh.zipggu.service.SnsService;
import com.kh.zipggu.vo.SnsListVO;

@RestController
@RequestMapping("/sns/data")
public class SnsRestController {
	
	@Autowired
	private SnsService snsService;
	
	@Autowired
	private SnsLikeDao snsLikeDao;
	
	@GetMapping("/list")
	public List<SnsListVO> snsList(@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "18") int size) {
		int endRow = page * size;
		int startRow = endRow - (size - 1);
		
		return snsService.listByPage(startRow, endRow);
	}
	
	@GetMapping("/like")
	public void insert(@RequestParam int snsNo, HttpSession session) {
		
		int memberNo = (int)session.getAttribute("loginNo");
	
			
			snsLikeDao.insert(snsNo, memberNo);
		
		
		
	}
	
	@DeleteMapping("/delete")
	public void delete(@RequestParam int snsNo, HttpSession session) {
		
		int memberNo = (int)session.getAttribute("loginNo");
		
		snsLikeDao.delete(snsNo, memberNo);
		
	}
}
