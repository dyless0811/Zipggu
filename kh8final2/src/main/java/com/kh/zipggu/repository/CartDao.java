package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.CartDto;
import com.kh.zipggu.vo.CartListVO;
import com.kh.zipggu.vo.ItemOrderListVO;

public interface CartDao {

	int getSequence();

	void insert(CartDto cartDto);

	List<CartListVO> list(int memberNo);

	List<CartListVO> listByOrder(ItemOrderListVO itemOrderListVO);

	boolean delete(int cartNo);


}
