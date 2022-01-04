package com.kh.zipggu.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.CartOptionDto;

@Repository
public class CartOptionImpl implements CartOptionDao{

	@Autowired
	private SqlSession sqlSession;
	
	//장바구니 등록하면서 상품옵션 같이 등록하는 기능 (Service)
	@Override
	public void insert(CartOptionDto cartOptionDto) {
		
		sqlSession.insert("cartOption.insert", cartOptionDto);
		
	}
}
