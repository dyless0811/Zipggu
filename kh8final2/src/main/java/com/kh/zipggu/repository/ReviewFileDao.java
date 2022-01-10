package com.kh.zipggu.repository;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.ReviewFileDto;

public interface ReviewFileDao {

	//리뷰 첨부파일 등록 기능
	void save(ReviewFileDto reviewFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;

}
