package com.kh.zipggu.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.CartDto;

@Repository
public class CartDaoImpl implements CartDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int getSequence() {
		
		return sqlSession.selectOne("cart.sequence");
	}
	
	@Override
	public void insert(CartDto cartDto) {
		
		sqlSession.insert("cart.insert", cartDto);
		
	}
}
