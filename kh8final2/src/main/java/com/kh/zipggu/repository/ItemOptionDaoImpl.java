package com.kh.zipggu.repository;

import java.util.List;
import java.util.Map;

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

	@Override
	public void itemOptionDetailDelete(int itemOptionNo) {
		sqlSession.delete("itemOption.itemOptionDetailDelete", itemOptionNo);
	}

	@Override
	public void itemOptionGroupRemove(ItemOptionDto itemOptionDto) {
		sqlSession.delete("itemOption.itemOptionGroupDelete", itemOptionDto);
	}

	@Override
	public void itemOptionDetailUpdate(ItemOptionDto itemOptionDto) {
		sqlSession.update("itemOption.itemOptionDetailUpdate", itemOptionDto);
	}

	@Override
	public void itemOptionGroupUpdate(Map<String, Object> param) {
		sqlSession.update("itemOption.itemOptionGroupUpdate", param);
	}

	@Override
	public void itemOptionDetailInsert(ItemOptionDto itemOptionDto) {
		sqlSession.insert("itemOption.itemOptionDetailInsert", itemOptionDto);
	}
}
