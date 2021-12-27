package com.kh.zipggu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.zipggu.service.SnsService;
import com.kh.zipggu.vo.SnsListVO;

@RestController
@RequestMapping("/sns/data")
public class SnsRestController {
	
	@Autowired
	private SnsService snsService;
	
	@GetMapping("/list")
	public List<SnsListVO> snsList(@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "18") int size) {
		int endRow = page * size;
		int startRow = endRow - (size - 1);
		
		return snsService.listByPage(startRow, endRow);
	}
}
