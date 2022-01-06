package com.kh.zipggu.vo;

import java.text.DecimalFormat;
import java.util.Iterator;
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
	
	public int getTotalPrice() {
		int totalPrice = getItemPrice();
		for (ItemOptionDto option : optionList) {
			totalPrice += option.getItemOptionPrice(); 
		}
		return totalPrice;
	}
	public int getSumPrice() {
		return getTotalPrice()*getQuantity();
	}
	
	public String getTotalPriceToString() {
		DecimalFormat f = new DecimalFormat("###,###");
		
		return f.format(getTotalPrice());
	}
	public String getSumPriceToString() {
		DecimalFormat f = new DecimalFormat("###,###");
		
		return f.format(getSumPrice());
	}
}
