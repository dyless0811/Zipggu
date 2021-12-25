package com.kh.zipggu.repository;

import com.kh.zipggu.entity.ItemDto;

public interface ItemDao {
	// 시퀀스 생성
	int sequance();
	// 아이템 등록
	void insert(ItemDto itemDto);
	// 아이템 단일 조회
	ItemDto get(int itemNo);
}
