package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.CartDto;
import com.kh.zipggu.vo.CartListVO;

public interface CartDao {

	int getSequence();

	void insert(CartDto cartDto);

	List<CartListVO> list(int memberNo);

}
