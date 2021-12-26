package com.kh.zipggu.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.zipggu.entity.ItemDto;
import com.kh.zipggu.entity.ItemOptionDto;
import com.kh.zipggu.repository.ItemDao;
import com.kh.zipggu.repository.ItemOptionDao;
import com.kh.zipggu.vo.StoreListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StoreServiceImpl implements StoreService {

	@Autowired
	private ItemDao itemDao;
	@Autowired
	private ItemOptionDao itemOptionDao;
	
	@Override
	public ItemDto getItemDto(int itemNo) {
		return itemDao.get(itemNo);
	}
	
	@Override
	public List<ItemOptionDto> getItemOptionList(int itemNo) {
		return itemOptionDao.listByItemNo(itemNo);
	}

	@Override
	public Map<String, List<ItemOptionDto>> getOptionGroupMap(int itemNo) {
		List<ItemOptionDto> optionList = this.getItemOptionList(itemNo);
		Map<String, List<ItemOptionDto>> groupMap = new LinkedHashMap<String, List<ItemOptionDto>>();
		for (ItemOptionDto itemOptionDto : optionList) {
			if(groupMap.get(itemOptionDto.getItemOptionGroup()) == null) {
				groupMap.put(itemOptionDto.getItemOptionGroup(), new ArrayList<ItemOptionDto>());
			}
			groupMap.get(itemOptionDto.getItemOptionGroup()).add(itemOptionDto);
		}
		return groupMap;
	}

	@Override
	public List<StoreListVO> getStoreList(int startRow, int endRow) {
		return itemDao.listByPage(startRow, endRow);
	}
	
	
	
}