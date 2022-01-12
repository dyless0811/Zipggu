package com.kh.zipggu.repository;

import java.util.List;
import java.util.Map;

import com.kh.zipggu.entity.OrdersDto;

import com.kh.zipggu.vo.ReviewOrderListVO;
import com.kh.zipggu.vo.kakaopay.SalesChartVO;
import com.kh.zipggu.vo.OrderListVO;
import com.kh.zipggu.vo.OrderSearchVO;
import com.kh.zipggu.vo.ReviewListVO;


public interface OrdersDao {
	int sequence();
	void insert(OrdersDto ordersDto);
	OrdersDto get(int no);
	List<OrdersDto> list();
	void refresh(int OrderNo);
	List<OrderListVO> listBySearchVO(OrderSearchVO orderSearchVO);
	//리뷰 작성시 구매한 목록 출력
	List<ReviewOrderListVO> orderList(Map<String, Object> param);
	SalesChartVO salseChart(int day);
}
