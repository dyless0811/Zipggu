package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.CartDto;
import com.kh.zipggu.vo.CartListVO;
import com.kh.zipggu.vo.ItemOrderListVO;
import com.kh.zipggu.vo.ItemOrderVO;

public interface CartDao {

	//시퀀스 먼저 받는 기능
	int getSequence();
	
	//장바구니 등록 기능 (Service)
	void insert(CartDto cartDto);

	//장바구니 조회 기능
	List<CartListVO> list(int memberNo);

	//장바구니에서 선택된 상품 결제페이지에서 조회 기능
	List<CartListVO> listByOrder(ItemOrderListVO itemOrderListVO);

	//장바구니 삭제 기능 (ajax)
	boolean delete(int cartNo);

	//장바구니에서 상품 수량 변경 기능
	void updateQuantity(ItemOrderListVO itemOrderListVO);

}
