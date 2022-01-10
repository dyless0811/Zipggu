package com.kh.zipggu.entity;

import lombok.Data;

@Data
public class ReviewDto {
	
	private int reviewNo;
	private int orderDetailNo;
	private int itemNo;
	private int reviewPoint;
	private String reviewDetail;
}
