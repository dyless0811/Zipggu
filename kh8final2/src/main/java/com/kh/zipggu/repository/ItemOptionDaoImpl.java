package com.kh.zipggu.repository;

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

}
