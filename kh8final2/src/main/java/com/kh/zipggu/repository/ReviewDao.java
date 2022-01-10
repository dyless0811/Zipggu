package com.kh.zipggu.repository;

import com.kh.zipggu.entity.ReviewDto;

public interface ReviewDao {

	//리뷰등록
	void insert(ReviewDto reviewDto);

	//시퀀스 먼저 받는 기능
	int sequence();

}
