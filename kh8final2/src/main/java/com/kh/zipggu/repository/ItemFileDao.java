package com.kh.zipggu.repository;

import com.kh.zipggu.entity.ItemFileDto;

public interface ItemFileDao {

	void insert(ItemFileDto itemFileDto);
	
	int getSeq();

	ItemFileDto getThumnail(int itemNo);
}
