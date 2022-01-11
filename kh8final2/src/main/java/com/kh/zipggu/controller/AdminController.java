package com.kh.zipggu.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.kh.zipggu.entity.ItemDto;
import com.kh.zipggu.entity.ItemOptionDto;
import com.kh.zipggu.entity.OrdersDto;
import com.kh.zipggu.repository.OrderDetailDao;
import com.kh.zipggu.repository.OrdersDao;
import com.kh.zipggu.service.CategoryService;
import com.kh.zipggu.service.ItemService;
import com.kh.zipggu.service.KakaoPayService;
import com.kh.zipggu.service.MemberService;
import com.kh.zipggu.service.StoreService;
import com.kh.zipggu.vo.ItemInsertVO;
import com.kh.zipggu.vo.ItemSearchVO;
import com.kh.zipggu.vo.ItemUpdateVO;
import com.kh.zipggu.vo.MemberListVO;
import com.kh.zipggu.vo.MemberPageVO;

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
	private MemberService memberService;
	
	@RequestMapping("")
	public String main() {
		return "admin/main";
	}
	@RequestMapping("/test")
	public String test() {
		return "admin/test";
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
		log.debug("==================================={}",vo);
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

	@PostMapping("/item/update")
	@ResponseBody
	public int itemUpdate(@ModelAttribute ItemUpdateVO vo,
							@RequestParam MultipartFile thumbnail , @RequestParam List<MultipartFile> attach
							) throws IOException {
		log.debug("====================================={}", vo);
		return itemService.update(vo, thumbnail, attach);
	}
	
	@GetMapping("/item/delete")
	public String itemDelete(@RequestParam int itemNo, RedirectAttributes redirectAttributes) {
		
		redirectAttributes.addFlashAttribute("deletedItemDto", itemService.delete(itemNo));
		
		return "redirect:list";
	}
	
	//상품 수정 시 기존의 상품 옵션 수정 기능
	@PostMapping("item/update/optionRemove")
	@ResponseBody
	public void itemOptionRemove(@RequestParam int itemOptionNo) {
		itemService.itemOptionDetailDelete(itemOptionNo);
	}
	@PostMapping("item/update/optionGroupRemove")
	@ResponseBody
	public void itemOptionGroupRemove(@ModelAttribute ItemOptionDto itemOptionDto) {
		itemService.itemOptionGroupRemove(itemOptionDto);
	}
	@PostMapping("item/update/optionUpdate")
	@ResponseBody
	public void itemOptionUpdate(@ModelAttribute ItemOptionDto itemOptionDto) {
		itemService.itemOptionDetailUpdate(itemOptionDto);	
	}
	@PostMapping("item/update/optionGroupUpdate")
	@ResponseBody
	public void itemOptionGroupUpdate(@RequestParam int itemNo, @RequestParam String itemOptionGroup, @RequestParam String changeGroup) {
		itemService.itemOptionGroupUpdate(itemNo, itemOptionGroup, changeGroup);				
	}
	@PostMapping("item/update/optionInsert")
	@ResponseBody
	public void itemOptionInsert(@ModelAttribute ItemOptionDto itemOptionDto) {
		itemService.itemOptionDetailInsert(itemOptionDto);			
	}
	
	
	@RequestMapping("/item/category")
	public String category() {
		
		return "admin/item/category";
	}
	
	@RequestMapping("/item/list")
	public String list(@ModelAttribute ItemSearchVO itemSearchVO, Model model, HttpServletRequest request){
		
		Map<String, ItemDto> confirm = (Map<String, ItemDto>)RequestContextUtils.getInputFlashMap(request);
		ItemDto deletedItemDto;
		if(confirm == null) {
			deletedItemDto = null;
		} else {
			deletedItemDto = (ItemDto) confirm.get("deletedItemDto");
		}
		
		model.addAttribute("itemList", itemService.listBySearchVO(itemSearchVO));
		model.addAttribute("deletedItemDto", deletedItemDto);
		return "admin/item/list";
	}
	
	// 회원 목록 조회
	@RequestMapping("/member/memberList")
	public String memberList(Model model, @ModelAttribute MemberPageVO memberPageVO) throws Exception {
		
			MemberPageVO param = memberService.memberPage(memberPageVO);
			System.err.println(param);
			model.addAttribute("memberPageVO",param);
			System.out.println("---------------------------------------------"+model);
			
		return "admin/member/memberList";
	}	
	
	@RequestMapping("/order/list")
	public String orderList() {
		return "admin/order/list";
	}

	@Autowired
	private OrdersDao ordersDao;
	@Autowired
	private OrderDetailDao orderDetailDao;
	@Autowired
	private KakaoPayService kakaoPayService;
	
	@GetMapping("/order/detail/{orderNo}")
	public String orderDetail(@PathVariable int orderNo, Model model) throws URISyntaxException {
		OrdersDto ordersDto = ordersDao.get(orderNo);
		model.addAttribute("ordersDto", ordersDto);
		log.debug("=================================={}", ordersDto);
		log.debug("=================================={}", orderNo);
		log.debug("=================================={}", orderDetailDao.list(orderNo));
		model.addAttribute("orderDetailList", orderDetailDao.orderDetailCustom(orderNo));
		model.addAttribute("responseVO", kakaoPayService.search(ordersDto.getTid()));
		
		return "admin/order/detail";
	}
	
}
