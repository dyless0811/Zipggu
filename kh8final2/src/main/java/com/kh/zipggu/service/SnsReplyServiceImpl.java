package com.kh.zipggu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.zipggu.repository.SnsReplyDao;
import com.kh.zipggu.vo.SnsReplyListVO;

@Service
public class SnsReplyServiceImpl implements SnsReplyService{
	
	@Autowired
	private SnsReplyDao snsReplyDao;
	
	//댓글 목록 페이징 기능
	@Override
	public List<SnsReplyListVO> listByPage(int startRow, int endRow, int snsNo) {
				
		return snsReplyDao.listByPage(startRow, endRow, snsNo);
	
	}
}
