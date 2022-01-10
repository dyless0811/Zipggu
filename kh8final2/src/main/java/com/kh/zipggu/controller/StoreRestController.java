package com.kh.zipggu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.kh.zipggu.service.StoreService;
import com.kh.zipggu.vo.ItemSearchVO;
import com.kh.zipggu.vo.StoreListVO;

import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/store/data")
public class StoreRestController {
	
	@Autowired
	private StoreService storeService;
	
	@GetMapping("/list")
	public List<StoreListVO> storeList(@ModelAttribute ItemSearchVO itemSearchVO,
			@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "24") int size
			) {
		itemSearchVO.setEndRow(page * size);
		itemSearchVO.setStartRow(itemSearchVO.getEndRow() - (size - 1));
		
		log.debug("==========================================={}", itemSearchVO.getCategoryList());
		return storeService.getStoreList(itemSearchVO);
	}
}
