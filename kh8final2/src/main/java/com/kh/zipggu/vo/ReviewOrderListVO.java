package com.kh.zipggu.vo;

import lombok.Data;

@Data
public class ReviewOrderListVO {
	
	private int orderNo;
	private int memberNo;
	private String memberNickname;
	private String orderName;
	private int orderDetailNo;
	private int itemNo;
	private int orderQuantity;
}
