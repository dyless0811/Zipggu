package com.kh.zipggu.vo;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ItemSearchVO {
	private int categoryNo;
	private String categoryName;
	private List<Integer> categoryList;
	private int itemNo;
	private String itemName;
	private int minPrice;
	private int maxPrice;
	private String itemShippingType;
	private String order;
	private String sort;
	private int startRow = 1;
	private int endRow = 24;
}
