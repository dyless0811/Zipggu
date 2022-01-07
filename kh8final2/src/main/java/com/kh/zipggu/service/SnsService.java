package com.kh.zipggu.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.SnsDto;
import com.kh.zipggu.vo.SnsListVO;


public interface SnsService {

	
	//SNS게시글 등록 및 첨부파일 등록 기능
	int write(SnsDto snsDto, List<MultipartFile> attach) throws IllegalStateException, IOException;

	//SNS게시글 수정 기능
	void edit(SnsDto snsDto, List<MultipartFile>attach) throws IllegalStateException, IOException;
	
	//SNS 게시글 삭제 기능
	void delete(int snsNo);
	
	//SNS 전체 목록 기능
	//List<SnsListVO> listByPage(int startRow, int endRow, String column);

	//SNS 전체 목록 기능
	List<SnsListVO> listByPage(Map<String, Object> param);

	//팔로우 한사람들 글 목록
	List<SnsListVO> followerList(Map<String, Object> param);

	
}
