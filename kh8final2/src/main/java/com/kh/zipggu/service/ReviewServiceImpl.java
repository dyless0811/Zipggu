package com.kh.zipggu.service;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.ReviewDto;
import com.kh.zipggu.entity.ReviewFileDto;
import com.kh.zipggu.repository.ReviewDao;
import com.kh.zipggu.repository.ReviewFileDao;
import com.kh.zipggu.vo.ReviewInsertVO;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private ReviewFileDao reviewFileDao;
	
	// 저장 폴더
	private File directory = new File("D:/upload/review");
		
	@Override
	public void insert(ReviewInsertVO reviewInsertVO) throws IllegalStateException, IOException {
		
		//첨부파일 등록을 위해 snsNo 번호 먼저 뽑아내기
		//(첨부파일에 review번호 외래키가 있고, 글 등록 후 상세페이지로 보내주기 위함)
		int sequence = reviewDao.sequence();
		
		//reviewDto에 시퀀스 번호 저장
		ReviewDto reviewDto = new ReviewDto();
		reviewDto.setReviewNo(sequence);
		reviewDto.setOrderDetailNo(reviewInsertVO.getOrderDetailNo());
		reviewDto.setItemNo(reviewInsertVO.getItemNo());
		reviewDto.setReviewPoint(reviewInsertVO.getReviewPoint());
		reviewDto.setReviewDetail(reviewInsertVO.getReviewDetail());
		
		//저장한 시퀀스 번호와 넘어온 Dto를 Dao로 전달 하여 등록 시작
		reviewDao.insert(reviewDto);
		
		//(선택)회원이미지 정보를 뽑아서 이미지 테이블과 실제 하드디스크에 저장
		MultipartFile multipartFile = reviewInsertVO.getAttach();
		if(!multipartFile.isEmpty()) {//파일이 있으면
			ReviewFileDto reviewFileDto = new ReviewFileDto();
			
			//사용자가 올린정보로 reviewFileDto에 저장
			reviewFileDto.setReviewNo(sequence);
			reviewFileDto.setReviewFileUploadname(multipartFile.getOriginalFilename());
			reviewFileDto.setReviewFileType(multipartFile.getContentType());
			reviewFileDto.setReviewFileSize(multipartFile.getSize());
			reviewFileDao.save(reviewFileDto, multipartFile);
		}

		
	}
}
