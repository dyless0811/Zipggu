package com.kh.zipggu.service;

import java.util.List;

import com.kh.zipggu.vo.CartListVO;
import com.kh.zipggu.vo.CartVO;
import com.kh.zipggu.vo.ItemOrderListVO;

public interface CartService {

	//카트 등록 기능
	ItemOrderListVO insert(CartVO cartVO);

	//장바구니 목록 출력 기능
	List<CartListVO> list(int memberNo);

	//장바구니에서 선택한 상품 결제페이지에서 출력하는 기능
	List<CartListVO> listByOrder(ItemOrderListVO itemOrderListVO);

}
