package com.kh.zipggu.entity;

import lombok.Data;

@Data
public class CartDto {
	
	private int cartNo;
	private int memberNo;
	private int itemNo;
	private int quantity;
}
