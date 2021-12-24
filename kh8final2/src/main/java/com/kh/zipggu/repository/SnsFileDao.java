package com.kh.zipggu.repository;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.SnsFileDto;

public interface SnsFileDao {

	//시퀀스 번호 먼저 받는 기능
	int sequence();

	//첨부파일 등록 기능
	void insert(SnsFileDto snsFileDto, MultipartFile file) throws IllegalStateException, IOException;

	//썸네일 불러오는 기능
	SnsFileDto getThumnail(int snsNo);

	//썸네일 파일 다운로드 기능
	byte[] load(int snsNo) throws IOException;

	List<SnsFileDto> list(int snsNo);

}
