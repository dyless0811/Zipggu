package com.kh.zipggu.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ItemListVO {
	private int categoryNo;
	private String categoryName;	
	private int itemNo;
	private String itemName;
	private int itemPrice;
	private int itemShippingType;
}
