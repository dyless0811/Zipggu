package com.kh.zipggu.vo;

import lombok.Data;

@Data
public class ReviewListVO {
	
	private int orderNo;
	private int memberNo;
	private String memberNickname;
	private String orderName;
	private int orderDetailNo;
	private int itemNo;
	private int orderQuantity;
}
