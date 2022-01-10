package com.kh.zipggu.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.OrderOptionDto;

@Repository
public class OrderOptionDaoImpl implements OrderOptionDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(OrderOptionDto orderOptionDto) {
		sqlSession.insert("orderOption.insert");
	}

}
