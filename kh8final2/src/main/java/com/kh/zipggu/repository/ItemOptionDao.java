package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.ItemOptionDto;

public interface ItemOptionDao {
	void insert(ItemOptionDto itemOptionDto);

	List<ItemOptionDto> listByItemNo(int itemNo);
}
