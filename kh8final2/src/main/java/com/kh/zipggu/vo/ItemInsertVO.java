package com.kh.zipggu.vo;

import java.util.List;

import com.kh.zipggu.entity.ItemOptionDto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ItemInsertVO {
	private int itemNo;
	private int categoryNo;
	private String itemName;
	private int itemPrice;
	private int itemShippingType;
	
	List<ItemOptionDto> optionList;
}
