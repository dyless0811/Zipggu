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
	public List<StoreListVO> listByPage(int startRow, int endRow) {
		Map<String, Object> param = new HashMap<>();
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		return sqlSession.selectList("item.listByPage", param);
	}

	@Override
	public List<ItemListVO> listBySearchVO(ItemSearchVO itemSearchVO) {
		return sqlSession.selectList("item.listBySearchVO", itemSearchVO);
	}
}
