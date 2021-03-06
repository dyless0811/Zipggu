package com.kh.zipggu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.zipggu.entity.CategoryDto;
import com.kh.zipggu.repository.MemberDao;
import com.kh.zipggu.service.CategoryService;
import com.kh.zipggu.service.ItemService;
import com.kh.zipggu.service.MemberService;
import com.kh.zipggu.service.OrderService;
import com.kh.zipggu.vo.CategoryVO;
import com.kh.zipggu.vo.ItemListVO;
import com.kh.zipggu.vo.ItemSearchVO;
import com.kh.zipggu.vo.JoinChartVO;
import com.kh.zipggu.vo.OrderListVO;
import com.kh.zipggu.vo.OrderSearchVO;
import com.kh.zipggu.vo.SalesChartVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/admin/data")
public class AdminRestController {
	
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private ItemService itemService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private MemberService memberService;	

	
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
	
	@PostMapping("/item/list")
	public List<ItemListVO> adminItemList(@ModelAttribute ItemSearchVO itemSearchVO, 
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "10") int size) {

		int endRow = page * size;
		int startRow = endRow - (size - 1);
		itemSearchVO.setStartRow(startRow);
		itemSearchVO.setEndRow(endRow);
		return itemService.listBySearchVO(itemSearchVO);
	}
	
	@GetMapping("/sales/chart")
	public List<SalesChartVO> orderChart() {
		return orderService.salseChartList();
	}
	
	@GetMapping("/member/joinChart")
	public List<JoinChartVO> joinChartVO(JoinChartVO joinChartVO) {
		
		log.debug("--------------------------------------{}", memberService.joinChartVO(joinChartVO));
		
		return memberService.joinChartVO(joinChartVO);
	}
	
}