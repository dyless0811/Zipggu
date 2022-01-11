package com.kh.zipggu.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.OrderDetailDto;
import com.kh.zipggu.vo.OrderDetailListVO;

@Repository
public class OrderDetailDaoImpl implements OrderDetailDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("orderDetail.sequence");
	}
	
	@Override
	public void insert(OrderDetailDto orderDetailDto) {
		sqlSession.insert("orderDetail.insert", orderDetailDto);
	}

	@Override
	public List<OrderDetailDto> list(int orderNo) {
		return sqlSession.selectList("orderDetail.listByOrderNo", orderNo);
	}

	@Override
	public OrderDetailDto get(int orderNo, int itemNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("orderNo", orderNo);
		param.put("itemNo", itemNo);
		return sqlSession.selectOne("orderDetail.get", param);
	}

	@Override
	public void cancel(int orderDetailNo) {
		sqlSession.update("orderDetail.cancel", orderDetailNo);
	}

	@Override
	public int getCancelAvailableAmount(int orderNo) {
		return sqlSession.selectOne("orderDetail.cancelAvailableAmount", orderNo);
	}

	@Override
	public void cancelAll(int orderNo) {
		sqlSession.update("orderDetail.cancelAll", orderNo);
	}

	@Override
	public OrderDetailDto get(int orderDetailNo) {
		return sqlSession.selectOne("orderDetail.getByNo", orderDetailNo);
	
	}

	@Override
	public List<OrderDetailListVO> orderDetailCustom(int orderNo) {
		
		return sqlSession.selectList("orderDetail.orderDetailCustom", orderNo);
	}

}
