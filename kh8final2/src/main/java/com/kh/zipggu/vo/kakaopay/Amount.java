package com.kh.zipggu.vo.kakaopay;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Amount {
	private int total;
	private int tax_free;
	private int vat;
	private int point;
	private int discount;
	
}
