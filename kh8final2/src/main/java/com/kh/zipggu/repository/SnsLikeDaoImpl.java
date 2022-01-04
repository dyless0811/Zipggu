package com.kh.zipggu.repository;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.SnsLikeDto;

@Repository
public class SnsLikeDaoImpl implements SnsLikeDao{

	@Autowired
	private SqlSession sqlSession;
	
	//좋아요 등록 기능
	@Override
	public void insert(int snsNo, int memberNo) {
		
		Map<String, Object>param = new HashMap<>();
		param.put("snsNo", snsNo);
		param.put("memberNo", memberNo);
		
		sqlSession.insert("like.insert", param);
		
	}
	
	//좋아요 삭제 기능
	@Override
	public void delete(int snsNo, int memberNo) {
		
		Map<String, Object>param = new HashMap<>();
		param.put("snsNo", snsNo);
		param.put("memberNo", memberNo);
		
		sqlSession.insert("like.delete", param);
		
	}
	
	//좋아요 단일조회 (좋아요와 좋아요 취소를 위한 단일조회)
	@Override
	public SnsLikeDto get(int snsNo, int memberNo) {
		
		Map<String, Object>param = new HashMap<>();
		param.put("snsNo", snsNo);
		param.put("memberNo", memberNo);
		
		return sqlSession.selectOne("like.get", param);
	}
}
