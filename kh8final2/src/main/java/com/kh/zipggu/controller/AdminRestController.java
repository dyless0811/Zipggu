package com.kh.zipggu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.zipggu.entity.CategoryDto;
import com.kh.zipggu.service.CategoryService;
import com.kh.zipggu.vo.CategoryVO;

import oracle.jdbc.proxy.annotation.Post;

@RestController
@RequestMapping("/admin/data")
public class AdminRestController {
	
	@Autowired
	private CategoryService categoryService;
	
	@PostMapping("/category/list")
	public List<CategoryVO> categoryList() {
		
		return categoryService.list();
	}
	
	@PostMapping("/category/add")
	public void categoryAdd(@RequestParam String categoryName, @RequestParam int categorySuper) {
		categoryService.add(categoryName, categorySuper);
	}
	
	@PostMapping("/category/modify")
	public void categoryModify(@RequestParam int categoryNo ,@RequestParam String categoryName) {
		categoryService.modify(categoryNo, categoryName);
	}
	
	@PostMapping("/category/delete")
	public void categoryDelete(@RequestParam int categoryNo) {
		categoryService.delete(categoryNo);
	}
	
	@PostMapping("/category/child")
	public List<CategoryDto> listBySuper(@RequestParam int categorySuper) {
		return categoryService.listBySuper(categorySuper);
	}
}