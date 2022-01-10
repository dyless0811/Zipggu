package com.kh.zipggu.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.ReviewDto;
import com.kh.zipggu.vo.ReviewInsertVO;
import com.kh.zipggu.vo.ReviewListVO;

@Repository
public class ReviewDaoImpl implements ReviewDao{

	@Autowired
	private SqlSession sqlSession;
	
	//리뷰 등록
	@Override
	public void insert(ReviewDto reviewDto) {
		
		sqlSession.insert("review.insert",reviewDto);
	}
	
	//시퀀스 먼저 받는 기능
	@Override
	public int sequence() {
		
		return sqlSession.selectOne("review.sequence");
	}
	
	//리뷰 목록 출력 기능
	@Override
	public List<ReviewListVO> reviewList(int itemNo) {
		
		return sqlSession.selectList("review.reviewList", itemNo);
	}
	
	@Override
	public void edit(ReviewInsertVO reviewInsertVO) {
		
		sqlSession.update("review.edit", reviewInsertVO);
		
	}
	
	//리뷰 삭제 기능
	@Override
	public void delete(int reviewNo) {
		
		sqlSession.delete("review.delete", reviewNo);
		
	}
}
