package com.kh.zipggu.vo;

import java.text.DecimalFormat;
import java.util.List;

import com.kh.zipggu.entity.OrderOptionDto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrderDetailListVO {
	private int orderDetailNo;
	private int orderNo;
	private int itemNo;
	private int orderQuantity;
	private String deliveryStatus;
	private String orderItemName;
	private int orderItemPrice;
	private String orderDetailStatus;
	
	private List<OrderOptionDto> optionList;
	
	public String getTotalPriceToString() {
		DecimalFormat f = new DecimalFormat("###,###");
		
		return f.format(getOrderItemPrice());
	}
	
}
