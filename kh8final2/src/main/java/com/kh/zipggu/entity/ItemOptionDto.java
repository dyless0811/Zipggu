package com.kh.zipggu.entity;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ItemOptionDto {
	private int itemOptionNo;
	private int itemNo;
	private String itemOptionGroup;
	private String itemOptionDetail;
	private int itemOptionPrice;
	private int itemOptionRequired;
}
