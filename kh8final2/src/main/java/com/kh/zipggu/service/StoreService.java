package com.kh.zipggu.service;

import java.util.List;
import java.util.Map;

import com.kh.zipggu.entity.ItemDto;
import com.kh.zipggu.entity.ItemOptionDto;

public interface StoreService {
	ItemDto getItemDto(int itemNo);
	List<ItemOptionDto> getItemOptionList(int itemNo);
	Map<String, List<ItemOptionDto>> getOptionGroupMap(int itemNo);
}
