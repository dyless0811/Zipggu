package com.kh.zipggu.repository;

import java.util.List;
import java.util.Map;

import com.kh.zipggu.entity.ItemOptionDto;

public interface ItemOptionDao {
	void insert(ItemOptionDto itemOptionDto);

	List<ItemOptionDto> listByItemNo(int itemNo);

	void itemOptionDetailDelete(int itemOptionNo);

	void itemOptionGroupRemove(ItemOptionDto itemOptionDto);

	void itemOptionDetailUpdate(ItemOptionDto itemOptionDto);

	void itemOptionGroupUpdate(Map<String, Object> param);

	void itemOptionDetailInsert(ItemOptionDto itemOptionDto);
}
