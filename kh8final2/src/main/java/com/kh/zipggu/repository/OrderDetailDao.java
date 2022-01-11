package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.OrderDetailDto;
import com.kh.zipggu.vo.OrderDetailListVO;


public interface OrderDetailDao {
	int sequence();
	void insert(OrderDetailDto orderDetailDto);
	List<OrderDetailDto> list(int orderNo);
	OrderDetailDto get(int orderNo, int itemNo);
	void cancel(int orderNo);
	int getCancelAvailableAmount(int orderNo);
	void cancelAll(int orderNo);
	OrderDetailDto get(int orderDetailNo);
	List<OrderDetailListVO> orderDetailCustom(int orderNo);
}
