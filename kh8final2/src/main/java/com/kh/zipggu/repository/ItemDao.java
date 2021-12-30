package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.ItemDto;
import com.kh.zipggu.vo.ItemListVO;
import com.kh.zipggu.vo.ItemSearchVO;
import com.kh.zipggu.vo.StoreListVO;

public interface ItemDao {
	// 시퀀스 생성
	int sequance();
	// 아이템 등록
	void insert(ItemDto itemDto);
	// 아이템 단일 조회
	ItemDto get(int itemNo);
	
	List<StoreListVO> listByPage(int startRow, int endRow);
	List<ItemListVO> listBySearchVO(ItemSearchVO itemSearchVO);
}
