package com.kh.zipggu.vo;

import java.text.DecimalFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class StoreListVO {
	private int itemNo;
	private String itemName;
	private int itemPrice;
	private int discountRate;
	private int reviewRate;
	private int reviewCount;
}
