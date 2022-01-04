package com.kh.zipggu.repository;

import com.kh.zipggu.entity.CartOptionDto;

public interface CartOptionDao {

	//장바구니 등록하면서 상품옵션 같이 등록하는 기능 (Service)
	void insert(CartOptionDto cartOptionDto);

}
