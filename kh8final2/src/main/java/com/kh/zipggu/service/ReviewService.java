package com.kh.zipggu.service;

import java.io.IOException;
import java.util.List;

import com.kh.zipggu.entity.ReviewDto;
import com.kh.zipggu.vo.ReviewInsertVO;
import com.kh.zipggu.vo.ReviewListVO;

public interface ReviewService {
	
	//리뷰 사진 첨부 등록 기능
	void insert(ReviewInsertVO reviewInsertVO) throws IllegalStateException, IOException;


}
