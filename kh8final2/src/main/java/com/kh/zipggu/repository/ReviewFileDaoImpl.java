package com.kh.zipggu.repository;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.ReviewFileDto;

@Repository
public class ReviewFileDaoImpl implements ReviewFileDao{

	@Autowired
	private SqlSession sqlSession;
	
	//저장용 폴더
	private File directory = new File("D:/upload/review");
		
	//리뷰 첨부파일 등록 기능
	@Override
	public void save(ReviewFileDto reviewFileDto, MultipartFile multipartFile) throws IllegalStateException, IOException {
		
		//1
		int sequence = sqlSession.selectOne("reviewFile.seq");
		
		//2
		File target = new File(directory, String.valueOf(sequence));
		multipartFile.transferTo(target);
		
		//3
		reviewFileDto.setReviewFileNo(sequence);
		reviewFileDto.setReviewFileSavename(String.valueOf(sequence));
		sqlSession.insert("reviewFile.save", reviewFileDto);
		
	}
	
	//리뷰 첨부파일 불러오는 기능
	@Override
	public byte[] load(int reviewFileNo) throws IOException {
		File target = new File(directory, String.valueOf(reviewFileNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}
	
	//첨부파일 단일조회 기능
	@Override
	public ReviewFileDto get(int reviewNo) {
		
		return sqlSession.selectOne("reviewFile.get", reviewNo);
	}
	
	//첨부파일 삭제 기능
	@Override
	public void delete(int reviewNo) {
		
		sqlSession.delete("reviewFile.delete", reviewNo);
		
	}
}
