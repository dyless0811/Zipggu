package com.kh.zipggu.vo;

import java.util.List;

import com.kh.zipggu.entity.ItemOptionDto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CartListVO {
	private int cartNo;
	private int memberNo;
	private int itemNo;
	private String itemName;
	private int quantity;
	private int categoryNo;
	private int itemPrice;
	private int itemShippingType;
	
	private List<ItemOptionDto> optionList;
}
