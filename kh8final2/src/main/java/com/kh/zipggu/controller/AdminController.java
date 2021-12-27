package com.kh.zipggu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.zipggu.repository.ItemDao;
import com.kh.zipggu.service.ItemService;
import com.kh.zipggu.vo.ItemInsertVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private ItemService itemService;
	
	@Autowired
	private ItemDao itemDao;
	
	@RequestMapping("")
	public String main() {
		return "admin/main";
	}
	
	@RequestMapping("/item")
	public String item() {
		return "admin/item/main";
	}
	
	@GetMapping("/item/insert")
	public String itemInsert() {
		
		return "admin/item/insert";
	}
	
	@PostMapping("/item/insert")
	public String itemInsert(@ModelAttribute ItemInsertVO vo) {
		int itemNo = itemDao.sequance();
		vo.setItemNo(itemNo);
		itemService.insert(vo);
		return "redirect:/store/detail/"+itemNo;
	}
	
	@RequestMapping("/item/category")
	public String category(Model model) {
		
		return "admin/item/category";
	}
}
