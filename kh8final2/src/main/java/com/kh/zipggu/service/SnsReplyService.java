package com.kh.zipggu.service;

import java.util.List;

import com.kh.zipggu.vo.SnsReplyListVO;

public interface SnsReplyService {

	List<SnsReplyListVO> listByPage(int startRow, int endRow, int snsNo);

}
