package com.kh.zipggu.vo;

import java.util.List;

import lombok.Data;

@Data
public class CategoryVO {
	private int categoryNo;
	private String categoryName;
	private int categorySuper;
	
	private List<CategoryVO> list;
}
