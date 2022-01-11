package com.kh.zipggu.entity;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrderDetailDto {
	private int orderDetailNo;
	private int orderNo;
	private int itemNo;
	private int orderQuantity;
	private String deliveryStatus;
	private String orderItemName;
	private int orderItemPrice;
	private String orderDetailStatus;
	
	public boolean isCancelAvailable() {
		return orderDetailStatus != null && orderDetailStatus.equals("결제");
	}
}
