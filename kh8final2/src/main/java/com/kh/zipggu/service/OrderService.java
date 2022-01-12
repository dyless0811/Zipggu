package com.kh.zipggu.service;

import java.util.List;

import com.kh.zipggu.vo.OrderListVO;
import com.kh.zipggu.vo.OrderSearchVO;
import com.kh.zipggu.vo.kakaopay.SalesChartVO;

public interface OrderService {

	List<OrderListVO> listBySearchVO(OrderSearchVO orderSearchVO);

	List<SalesChartVO> salseChartList();

}
