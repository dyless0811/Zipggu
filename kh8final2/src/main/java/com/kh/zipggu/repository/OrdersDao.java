package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.OrdersDto;
import com.kh.zipggu.vo.OrderListVO;

public interface OrdersDao {
	int sequence();
	void insert(OrdersDto ordersDto);
	OrdersDto get(int no);
	List<OrdersDto> list();
	void refresh(int OrderNo);
	//리뷰 작성시 구매한 목록 출력
	List<OrderListVO> orderList(int memberNo);
}
