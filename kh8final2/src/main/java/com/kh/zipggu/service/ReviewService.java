package com.kh.zipggu.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.ReviewDto;
import com.kh.zipggu.entity.ReviewFileDto;
import com.kh.zipggu.vo.ReviewInsertVO;
import com.kh.zipggu.vo.ReviewListVO;
import com.kh.zipggu.vo.OrderListVO;

public interface ReviewService {
	
	//리뷰 사진 첨부 등록 기능
	void insert(ReviewInsertVO reviewInsertVO) throws IllegalStateException, IOException;

	//리뷰 목록 출력
	List<ReviewListVO> reviewList(int itemNo);

	//리뷰 수정 기능
	void edit(ReviewInsertVO reviewInsertVO) throws IllegalStateException, IOException;

	//리뷰 삭제 기능
	void delete(int reviewNo);


}
