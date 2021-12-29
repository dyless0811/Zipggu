package com.kh.zipggu.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.zipggu.entity.ItemDto;
import com.kh.zipggu.entity.ItemOptionDto;
import com.kh.zipggu.repository.ItemDao;
import com.kh.zipggu.repository.ItemOptionDao;
import com.kh.zipggu.vo.ItemInsertVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ItemServiceImpl implements ItemService {

	@Autowired
	private ItemDao itemDao;
	
	@Autowired
	private ItemOptionDao itemOptionDao;
	
	@Override
	public int insert(ItemInsertVO itemInsertVo) {
		int itemNo = itemDao.sequance();
		
		ItemDto itemDto = new ItemDto();
		itemDto.setItemNo(itemNo);
		itemDto.setCategoryNo(itemInsertVo.getCategoryNo());
		itemDto.setItemName(itemInsertVo.getItemName());
		itemDto.setItemPrice(itemInsertVo.getItemPrice());
		itemDto.setItemShippingType(itemInsertVo.getItemShippingType());
		
		itemDao.insert(itemDto);
		
		if(itemInsertVo.getOptionList() == null) {
			ItemOptionDto itemOptionDto = new ItemOptionDto();
			itemOptionDto.setItemNo(itemNo);
			itemOptionDto.setItemOptionGroup("기본");
			itemOptionDto.setItemOptionDetail("단품");
			itemOptionDto.setItemOptionPrice(0);
			itemOptionDto.setItemOptionRequired(1);
			
			itemOptionDao.insert(itemOptionDto);
		} else {
			for (ItemOptionDto itemOptionDto : itemInsertVo.getOptionList()) {
				itemOptionDto.setItemNo(itemNo);
				
				itemOptionDao.insert(itemOptionDto);
			}			
		}
		
		return itemNo;
	}
}
