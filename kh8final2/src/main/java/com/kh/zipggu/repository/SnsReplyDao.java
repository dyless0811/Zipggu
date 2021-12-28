package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.SnsReplyDto;
import com.kh.zipggu.vo.SnsReplyListVO;

public interface SnsReplyDao {

	//댓글 등록
	void insert(SnsReplyDto snsReplyDto);
	
	//시퀀스 번호
	int sequence();

	List<SnsReplyListVO> listByPage(int startRow, int endRow, int snsNo);
	
}
