package com.kh.zipggu.repository;

import com.kh.zipggu.entity.CartDto;

public interface CartDao {

	int getSequence();

	void insert(CartDto cartDto);

}
