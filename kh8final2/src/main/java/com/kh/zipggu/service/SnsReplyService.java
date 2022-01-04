package com.kh.zipggu.service;

import java.util.List;

import com.kh.zipggu.vo.SnsReplyListVO;

public interface SnsReplyService {

	//댓글 목록 페이징 기능
	List<SnsReplyListVO> listByPage(int startRow, int endRow, int snsNo);

}
