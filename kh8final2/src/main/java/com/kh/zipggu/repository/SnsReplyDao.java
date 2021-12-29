package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.SnsReplyDto;
import com.kh.zipggu.vo.SnsReplyListVO;

public interface SnsReplyDao {

	//댓글 등록
	void insert(SnsReplyDto snsReplyDto);
	
	//시퀀스 번호
	int sequence();

	//비동기 페이징을 위한 목록 기능
	List<SnsReplyListVO> listByPage(int startRow, int endRow, int snsNo);

	//댓글 삭제 기능
	boolean delete(int snsReplyNo);

	//댓글 갱신 기능
	void replyCount(int snsNo);

	
}
