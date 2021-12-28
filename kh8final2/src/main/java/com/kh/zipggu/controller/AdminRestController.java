package com.kh.zipggu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.zipggu.service.AdminService;
import com.kh.zipggu.vo.CategoryVO;

@RestController
@RequestMapping("/admin/data")
public class AdminRestController {
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/category/list")
	public List<CategoryVO> categoryList() {
		
		return adminService.list();
	}
	
	@GetMapping("/category/add")
	public void categoryAdd(@RequestParam String categoryName, @RequestParam int categorySuper) {
		adminService.add(categoryName, categorySuper);
	}
}