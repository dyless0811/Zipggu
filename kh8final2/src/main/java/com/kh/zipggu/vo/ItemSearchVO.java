package com.kh.zipggu.vo;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ItemSearchVO {
	private int categoryNo;
	private String categoryName;
	private int itemNo;
	private String itemName;
	private int minPrice;
	private int maxPrice;
	private int itemShippingType;
	private List<SortVO> orders;
}
