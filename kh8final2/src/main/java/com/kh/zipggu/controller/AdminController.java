package com.kh.zipggu.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.repository.ItemDao;
import com.kh.zipggu.service.CategoryService;
import com.kh.zipggu.service.ItemService;
import com.kh.zipggu.vo.ItemInsertVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private ItemService itemService;
	
	@Autowired
	private CategoryService categoryService;
	
	@RequestMapping("")
	public String main() {
		return "admin/main";
	}
	
	@RequestMapping("/item")
	public String item() {
		return "admin/item/main";
	}
	
	@GetMapping("/item/insert")
	public String itemInsert(Model model) {
		model.addAttribute("categoryVOList", categoryService.list());
		return "admin/item/insert";
	}
	
	@PostMapping("/item/insert")
	public String itemInsert(@ModelAttribute ItemInsertVO vo,@RequestParam MultipartFile thumbnail , @RequestParam List<MultipartFile> attach) throws IllegalStateException, IOException {
	
		return "redirect:/store/detail/"+itemService.insert(vo,thumbnail , attach);
	}
	
	@RequestMapping("/item/category")
	public String category(Model model) {
		
		return "admin/item/category";
	}
}
