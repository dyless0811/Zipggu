package com.kh.zipggu.service;

import java.util.List;

import com.kh.zipggu.vo.CartListVO;
import com.kh.zipggu.vo.CartVO;

public interface CartService {

	void insert(CartVO cartVO);

	List<CartListVO> list(int memberNo);

}
