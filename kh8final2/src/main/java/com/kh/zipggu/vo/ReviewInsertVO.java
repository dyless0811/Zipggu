package com.kh.zipggu.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ReviewInsertVO {
	
	private int reviewNo;
	private int orderDetailNo;
	private int itemNo;
	private int reviewPoint;
	private String reviewDetail;
	private MultipartFile attach;
}
