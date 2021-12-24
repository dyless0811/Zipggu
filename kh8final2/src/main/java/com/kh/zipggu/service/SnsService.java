package com.kh.zipggu.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.SnsDto;


public interface SnsService {

	
	//SNS게시글 등록 및 첨부파일 등록 기능
	int write(SnsDto snsDto, List<MultipartFile> attach) throws IllegalStateException, IOException;
	
	
}
