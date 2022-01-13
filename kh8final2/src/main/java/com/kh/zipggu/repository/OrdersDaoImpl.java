package com.kh.zipggu.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.OrdersDto;

import com.kh.zipggu.vo.ReviewOrderListVO;
import com.kh.zipggu.vo.SalesChartVO;
import com.kh.zipggu.vo.OrderListVO;
import com.kh.zipggu.vo.OrderSearchVO;
import com.kh.zipggu.vo.ReviewListVO;


import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class OrdersDaoImpl implements OrdersDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("orders.sequence");
	}

	@Override
	public void insert(OrdersDto ordersDto) {
		sqlSession.insert("orders.insert", ordersDto);
	}

	@Override
	public List<OrdersDto> list() {
		return sqlSession.selectList("orders.list");
	}

	@Override
	public OrdersDto get(int orderNo) {
		return sqlSession.selectOne("orders.get", orderNo);
	}

	@Override
	public void refresh(int orderNo) {
		sqlSession.update("orders.refresh", orderNo);
	}
	
	@Override
	public List<ReviewOrderListVO> orderList(Map<String, Object> param) {
		
		return sqlSession.selectList("orders.orderList", param);
	}

	@Override
	public List<OrderListVO> listBySearchVO(OrderSearchVO orderSearchVO) {
		List<OrderListVO> a = sqlSession.selectList("orders.listBySearchVO", orderSearchVO);
		log.debug("=============================================={}", a);
		return a;
	}

	@Override
	public SalesChartVO salseChart(int day) {
		return sqlSession.selectOne("orders.salesChartList", day);
	}

}
