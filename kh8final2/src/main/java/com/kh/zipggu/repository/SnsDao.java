package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.SnsDto;
import com.kh.zipggu.vo.SnsListVO;

public interface SnsDao {

	//등록 기능
	void write(SnsDto snsDto);

	//시퀀스 먼저 받는 기능
	int sequence();

	//단일조회 기능(상세페이지)
	SnsDto get(int snsNo);

	//목록 조회
	List<SnsDto> list();

	//게시글 수정
	void edit(SnsDto snsDto);

	//게시글 삭제
	void delete(int snsNo);

	//페이징 목록조회
	List<SnsListVO> listByPage(int startRow, int endRow);
	
}
