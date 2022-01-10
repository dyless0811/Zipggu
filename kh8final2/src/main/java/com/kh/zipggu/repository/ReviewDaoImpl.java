package com.kh.zipggu.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.ReviewDto;

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
}
