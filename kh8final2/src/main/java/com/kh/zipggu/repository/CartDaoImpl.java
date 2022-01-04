package com.kh.zipggu.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.CartDto;
import com.kh.zipggu.vo.CartListVO;
import com.kh.zipggu.vo.ItemOrderListVO;
import com.kh.zipggu.vo.ItemOrderVO;

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
	
	@Override
	public List<CartListVO> list(int memberNo) {
		
		
		
		return sqlSession.selectList("cart.cartCustom", memberNo);
		
	}
	

	
	@Override
	public List<CartListVO> listByOrder(ItemOrderListVO itemOrderListVO) {
		

		return sqlSession.selectList("cart.payList", itemOrderListVO);
	}
	
	@Override
	public boolean delete(int cartNo) {
		
		int result = sqlSession.delete("cart.delete", cartNo);
		
		return result > 0;
		
	}
}
