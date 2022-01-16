package com.kh.zipggu.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.MemberProfileDto;
import com.kh.zipggu.entity.ReviewDto;
import com.kh.zipggu.entity.ReviewFileDto;
import com.kh.zipggu.repository.ReviewDao;
import com.kh.zipggu.repository.ReviewFileDao;
import com.kh.zipggu.vo.ReviewInsertVO;
import com.kh.zipggu.vo.ReviewListVO;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private ReviewFileDao reviewFileDao;
	
	// 저장 폴더
	private File directory = new File("D:/upload/kh8b/review");
		
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
	
	//리뷰 수정 기능
	public void edit(ReviewInsertVO reviewInsertVO) throws IllegalStateException, IOException {
		//검사값 false를 변수에 담고
		boolean check = false;
		//파일이 있는지 없는 체크
		
		MultipartFile multipartFile = reviewInsertVO.getAttach();
			//만약 파일이 비어있지 않다면
			if(!multipartFile.isEmpty()) {
				check = true;
		}
		
		//파일이 있다면 기존 파일을 삭제하고 새로운 파일을 추가
		if(check) {
			//해당 번호에 파일 업로드 되어 있는지 확인한다
			
			ReviewFileDto reviewFileDto = reviewFileDao.get(reviewInsertVO.getReviewNo());
			
			if(reviewFileDto != null) {
				//파일이 있다면 삭제
					File target = new File(directory, String.valueOf(reviewFileDto.getReviewFileSavename()));
					target.delete();
					//db에서도 파일 삭제
					reviewFileDao.delete(reviewFileDto.getReviewNo());
				}
			}

				if(!multipartFile.isEmpty()) {
					
					//등록페이지에서 넘어오는 정보만 snsFileDto 객체에 정보 담아Dao로 보내기
					//(여기서는 정보만 담아 보낸다)
					ReviewFileDto reviewFileDto = new ReviewFileDto();
					reviewFileDto.setReviewNo(reviewInsertVO.getReviewNo());
					reviewFileDto.setReviewFileUploadname(multipartFile.getOriginalFilename());
					reviewFileDto.setReviewFileType(multipartFile.getContentType());
					reviewFileDto.setReviewFileSize(multipartFile.getSize());
					reviewFileDao.save(reviewFileDto, multipartFile);
				}
				reviewDao.edit(reviewInsertVO);
		}
	
	//리뷰 삭제 기능
	@Override
	public void delete(int reviewNo) {
		
		ReviewFileDto reviewFileDto = reviewFileDao.get(reviewNo);
		
		if(reviewFileDto != null) {
			
			File target = new File(directory, String.valueOf(reviewFileDto.getReviewFileSavename()));
			target.delete();
			
			reviewFileDao.delete(reviewNo);
		}
		
		reviewDao.delete(reviewNo);
	}
	
	//리뷰 목록 출력
	@Override
	public List<ReviewListVO> reviewList(int itemNo) {
		
		return reviewDao.reviewList(itemNo);
	}
}
