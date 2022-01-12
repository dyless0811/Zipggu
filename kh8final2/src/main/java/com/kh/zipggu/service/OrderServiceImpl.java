package com.kh.zipggu.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.repository.OrdersDao;
import com.kh.zipggu.vo.OrderListVO;
import com.kh.zipggu.vo.OrderSearchVO;
import com.kh.zipggu.vo.kakaopay.SalesChartVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrdersDao ordersDao;
	
	@Override
	public List<OrderListVO> listBySearchVO(OrderSearchVO orderSearchVO) {
		List<OrderListVO> a = ordersDao.listBySearchVO(orderSearchVO);
		log.debug("=================================={}", a);
		return a;
	}

	@Override
	public List<SalesChartVO> salseChartList() {
		List<SalesChartVO> list = new ArrayList<SalesChartVO>();
		for (int i = 6; i >= 0; i--) {
			list.add(ordersDao.salseChart(i));
		}
		return list;
	}
}
