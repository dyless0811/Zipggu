package com.kh.zipggu.service;

import java.util.List;
import java.util.Map;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;

import com.kh.zipggu.entity.ItemDto;
import com.kh.zipggu.entity.ItemFileDto;
import com.kh.zipggu.entity.ItemOptionDto;
import com.kh.zipggu.vo.ItemSearchVO;
import com.kh.zipggu.vo.StoreListVO;

public interface StoreService {
	ItemDto getItemDto(int itemNo);
	List<ItemOptionDto> getItemOptionList(int itemNo);
	Map<String, List<ItemOptionDto>> getOptionGroupMap(int itemNo);
	List<StoreListVO> getStoreList(ItemSearchVO itemSearchVO);
	List<ItemFileDto> fileListByItemNo(int itemNo);
	List<ItemFileDto> nonThumbnailListByItemNo(int itemNo);
}
