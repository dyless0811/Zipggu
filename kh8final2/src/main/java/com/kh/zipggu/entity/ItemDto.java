package com.kh.zipggu.entity;


import java.text.DecimalFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ItemDto {
	private int itemNo;
	private int categoryNo;
	private String itemName;
	private int itemPrice;
	private int itemShippingType;
	
	public String getItemPricetoString() {
		DecimalFormat f = new DecimalFormat("###,###");
		return f.format(itemPrice);
	}
}
