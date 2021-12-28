package com.kh.zipggu.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.ItemOptionDto;

@Repository
public class ItemOptionDaoImpl implements ItemOptionDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ItemOptionDto itemOptionDto) {
		sqlSession.insert("itemOption.insert", itemOptionDto);
	}

	@Override
	public List<ItemOptionDto> listByItemNo(int itemNo) {
		return sqlSession.selectList("itemOption.listByItemNo", itemNo);
	}
}
