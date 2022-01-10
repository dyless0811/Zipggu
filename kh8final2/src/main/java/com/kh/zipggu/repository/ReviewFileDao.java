package com.kh.zipggu.repository;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.ReviewFileDto;

public interface ReviewFileDao {

	//리뷰 첨부파일 등록 기능
	void save(ReviewFileDto reviewFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;

	//리뷰 첨부파일 불러오는 기능
	byte[] load(int reviewFileNo) throws IOException;
	
	//첨부파일 단일조회 기능
	ReviewFileDto get(int reviewNo);

	//첨부파일 삭제 기능
	void delete(int reviewNo);

}
