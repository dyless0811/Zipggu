package com.kh.zipggu.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.ItemDto;

@Repository
public class ItemDaoImpl implements ItemDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int sequance() {
		return sqlSession.selectOne("item.sequance");
	}

	@Override
	public void insert(ItemDto itemDto) {
		sqlSession.insert("item.insert", itemDto);
	}

	@Override
	public ItemDto get(int itemNo) {
		return sqlSession.selectOne("item.get", itemNo);
	}
}
