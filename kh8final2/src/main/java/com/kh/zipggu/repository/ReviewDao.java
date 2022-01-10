package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.ReviewDto;
import com.kh.zipggu.vo.ReviewInsertVO;
import com.kh.zipggu.vo.ReviewListVO;

public interface ReviewDao {

	//리뷰등록
	void insert(ReviewDto reviewDto);

	//시퀀스 먼저 받는 기능
	int sequence();

	//리뷰 목록 출력 기능
	List<ReviewListVO> reviewList(int itemNo);

	//리뷰 수정 기능
	void edit(ReviewInsertVO reviewInsertVO);

	//리뷰 삭제 기능
	void delete(int reviewNo);

}
