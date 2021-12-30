package com.kh.zipggu.controller;

import java.io.File;
import java.io.IOException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.zipggu.service.ItemService;


@Controller
@RequestMapping("/item")
public class ItemController {
	
	@Autowired
	private ItemService itemService;
	
	//목록 페이지 썸네일을 위한 다운로드 기능
	@GetMapping("/thumbnail")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> thumnail(@RequestParam int itemNo) throws IOException{
		return itemService.getThumbnail(itemNo);
	}
}
