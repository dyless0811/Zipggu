package com.kh.zipggu.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.DeliveryDto;

@Repository
public class DeliveryDaoImpl implements DeliveryDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(DeliveryDto deliveryDto) {
		sqlSession.insert("delivery.insert", deliveryDto);
	}
	
	@Override
	public int getSeq() {
		return sqlSession.selectOne("delivery.getSeq");
	}

	@Override
	public DeliveryDto get(int deliveryNo) {
		return sqlSession.selectOne("delivery.get", deliveryNo);
	}

	@Override
	public List<DeliveryDto> getListByMemberNo(int memberNo) {
		return sqlSession.selectList("delivery.getListByMemberNo", memberNo);
	}

	@Override
	public void update(DeliveryDto deliveryDto) {
		sqlSession.update("delivery.update", deliveryDto);
	}

	@Override
	public void delete(int deliveryNo) {
		sqlSession.delete("delivery.delete", deliveryNo);
	}
}
