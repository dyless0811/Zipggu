package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.OrderDetailDto;


public interface OrderDetailDao {
	int sequence();
	void insert(OrderDetailDto orderDetailDto);
	List<OrderDetailDto> list(int orderNo);
	OrderDetailDto get(int orderNo, int itemNo);
	void cancel(int orderNo, int itemNo);
	int getCancelAvailableAmount(int orderNo);
	void cancelAll(int orderNo);
}
