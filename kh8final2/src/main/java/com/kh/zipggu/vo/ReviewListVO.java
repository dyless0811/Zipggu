package com.kh.zipggu.vo;

import lombok.Data;

@Data
public class ReviewListVO {
	
	private int reviewNo;
	private String reviewDetail;
	private int orderDetailNo;
	private int reviewPoint;
	private String memberNickname;
	private int memberNo;
	private int itemNo;
	private int orderQuantity;
	private String orderName;
}
