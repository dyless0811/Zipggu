package com.kh.zipggu.vo;

import java.util.Date;

import lombok.Data;

@Data
public class OrderListVO {
		
	private int orderNo;
	private String orderName;
	private int totalAmount;
	private String tid;
	private int memberNo;
	private String memberNickname;
	private String orderStatus;
}
