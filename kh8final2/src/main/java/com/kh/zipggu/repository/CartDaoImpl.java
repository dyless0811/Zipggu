package com.kh.zipggu.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	//시퀀스 먼저 받는 기능
	@Override
	public int getSequence() {
		
		return sqlSession.selectOne("cart.sequence");
	}
	
	//장바구니 등록 기능
	@Override
	public void insert(CartDto cartDto) {
		
		sqlSession.insert("cart.insert", cartDto);
		
	}
	
	//장바구니 조회 기능 (회원번호)
	@Override
	public List<CartListVO> list(int memberNo) {
		
		return sqlSession.selectList("cart.cartCustom", memberNo);
		
	}
	
	//장바구니에서 선택된 상품 결제페이지에서 조회 기능
	@Override
	public List<CartListVO> listByOrder(ItemOrderListVO itemOrderListVO) {
		
		return sqlSession.selectList("cart.payList", itemOrderListVO);
	}
	
	//장바구니 삭제 기능 (ajax)
	@Override
	public boolean delete(int cartNo) {
		
		int result = sqlSession.delete("cart.delete", cartNo);
		
		return result > 0;
		
	}

	//장바구니에서 상품 수량 변경 기능
	@Override
	public void updateQuantity(ItemOrderListVO itemOrderListVO) {
		
		sqlSession.update("cart.updateQuantity", itemOrderListVO);
		
	}
}
