package com.kh.zipggu.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.zipggu.entity.ItemFileDto;
import com.kh.zipggu.repository.ItemFileDao;
import com.kh.zipggu.service.ItemService;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/item")
public class ItemController {
	
	@Autowired
	private ItemService itemService;
	@Autowired
	private ItemFileDao itemFileDao;
	
	private File directory = new File("D:/upload/ITEM");
	
	//목록 페이지 썸네일을 위한 다운로드 기능
	@GetMapping("/thumbnail")
	@ResponseBody
	public ResponseEntity<ByteArrayResource> thumnail(@RequestParam int itemNo) throws IOException{
		System.out.println("===========================================" + itemNo);
		ItemFileDto itemFileDto = itemFileDao.getThumnail(itemNo);
		
		//ItemNo로 실제 파일 정보를 불러온다
		File target = new File(directory, String.valueOf(itemFileDto.getItemFileNo()));
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data); 
		
		String encodeName = URLEncoder.encode(itemFileDto.getItemFileUploadname(), "UTF-8");
		encodeName = encodeName.replace("+", "%20");
		
		return ResponseEntity.ok()
						.contentType(MediaType.APPLICATION_OCTET_STREAM)
						.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
						.header("content-Encoding", "UTF-8")
						.contentLength(itemFileDto.getItemFileSize())
						.body(resource);
		
//		return itemService.getThumbnail(itemNo);
	}
}
