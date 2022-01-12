package com.kh.zipggu.entity;

import java.text.DecimalFormat;
import java.text.Format;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ItemOptionDto {
	private int itemOptionNo;
	private int itemNo;
	private String itemOptionGroup;
	private String itemOptionDetail;
	private int itemOptionPrice;
	private int itemOptionRequired;
	
	public String getItemOptionPriceToString() {
		DecimalFormat f = new DecimalFormat("###,###");
		return f.format(getItemOptionPrice());
	}
	
	public String getOptionAndPrice() {
		if(getItemOptionPrice() > 0) {
			return getItemOptionDetail()+" +"+getItemOptionPriceToString()+"원";
		} else {
			return getItemOptionDetail();
		}
	}
}
