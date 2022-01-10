package com.kh.zipggu.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.ItemDto;
import com.kh.zipggu.entity.ItemOptionDto;
import com.kh.zipggu.vo.ItemListVO;
import com.kh.zipggu.vo.ItemSearchVO;
import com.kh.zipggu.vo.StoreListVO;

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
	
	@Override
	public List<StoreListVO> listByPage(ItemSearchVO itemSearchVO) {
		return sqlSession.selectList("item.listByPage", itemSearchVO);
	}

	@Override
	public List<ItemListVO> listBySearchVO(ItemSearchVO itemSearchVO) {
		return sqlSession.selectList("item.listBySearchVO", itemSearchVO);
	}

	@Override
	public void update(ItemDto itemDto) {
		sqlSession.update("item.update", itemDto);
	}

	@Override
	public void delete(int itemNo) {
		sqlSession.delete("item.delete", itemNo);
	}
}
