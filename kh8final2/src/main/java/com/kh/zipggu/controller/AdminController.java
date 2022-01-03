package com.kh.zipggu.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.ItemOptionDto;
import com.kh.zipggu.service.CategoryService;
import com.kh.zipggu.service.ItemService;
import com.kh.zipggu.service.StoreService;
import com.kh.zipggu.vo.ItemInsertVO;
import com.kh.zipggu.vo.ItemSearchVO;
import com.kh.zipggu.vo.ItemUpdateVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private ItemService itemService;
	
	@Autowired
	private StoreService storeService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private SqlSession sqlSession;
	
	
	
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
	@ResponseBody
	public int itemInsert(@ModelAttribute ItemInsertVO vo,@RequestParam MultipartFile thumbnail , @RequestParam List<MultipartFile> attach) throws IllegalStateException, IOException {
	
		return itemService.insert(vo,thumbnail , attach);
	}
	
	@GetMapping("/item/update/{itemNo}")
	public String itemUpdate(@PathVariable("itemNo") int itemNo, Model model) {
		model.addAttribute("categoryVOList", categoryService.list());
		model.addAttribute("itemDto", itemService.get(itemNo));
		model.addAttribute("itemOptionGroupMap", storeService.getOptionGroupMap(itemNo));
		model.addAttribute("itemFileDtoList", storeService.nonThumbnailListByItemNo(itemNo));
		return "admin/item/update";
	}
	
	@PostMapping("item/update")
	@ResponseBody
	public int itemUpdate(@ModelAttribute ItemUpdateVO vo, @RequestParam MultipartFile thumbnail , @RequestParam List<MultipartFile> attach) throws IllegalStateException, IOException {
		
		
		return 0;
	}
	
	@PostMapping("item/update/optionRemove")
	@ResponseBody
	public void itemOptionRemove(@RequestParam int itemOptionNo) {
		System.out.println("========================================="+itemOptionNo);
	}
	@PostMapping("item/update/optionGroupRemove")
	@ResponseBody
	public void itemOptionGroupRemove(@RequestParam int itemNo, @RequestParam String itemOptionGroup) {
		System.out.println("========================================="+itemNo);
		System.out.println("========================================="+itemOptionGroup);
	}
	@PostMapping("item/update/optionUpdate")
	@ResponseBody
	public void itemOptionUpdate(@ModelAttribute ItemOptionDto itemOptionDto) {
		System.out.println("========================================="+itemOptionDto.getItemOptionNo());		
		System.out.println("========================================="+itemOptionDto.getItemOptionDetail());		
		System.out.println("========================================="+itemOptionDto.getItemOptionPrice());		
	}
	@PostMapping("item/update/optionGroupUpdate")
	@ResponseBody
	public void itemOptionGroupUpdate(@RequestParam int itemNo, @RequestParam String itemOptionGroup, @RequestParam String changeGroup) {
		System.out.println("========================================="+itemNo);		
		System.out.println("========================================="+itemOptionGroup);				
		System.out.println("========================================="+changeGroup);				
	}
	@PostMapping("item/update/optionInsert")
	@ResponseBody
	public void itemOptionInsert(@ModelAttribute ItemOptionDto itemOptionDto) {
		System.out.println("========================================="+itemOptionDto.getItemNo());						
		System.out.println("========================================="+itemOptionDto.getItemOptionGroup());						
		System.out.println("========================================="+itemOptionDto.getItemOptionDetail());						
		System.out.println("========================================="+itemOptionDto.getItemOptionPrice());				
		System.out.println("========================================="+itemOptionDto.getItemOptionRequired());				
	}
	
	
	@RequestMapping("/item/category")
	public String category() {
		
		return "admin/item/category";
	}
	
	@RequestMapping("/item/list")
	public String list(@ModelAttribute ItemSearchVO itemSearchVO, Model model){
		
		model.addAttribute("itemList", itemService.listBySearchVO(itemSearchVO));
		return "admin/item/list";
	}
}
