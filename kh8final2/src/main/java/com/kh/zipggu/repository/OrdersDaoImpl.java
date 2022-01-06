package com.kh.zipggu.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.OrdersDto;

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

}
