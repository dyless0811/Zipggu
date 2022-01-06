package com.kh.zipggu.vo.kakaopay;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class KakaoPayReadyRequestVO {
	private String item_name;
	private int quantity;
	private int total_amount;
	private String partner_order_id;
	private String partner_user_id;
	
	
	public String getQuantityString() {
		return String.valueOf(quantity);
	}
	public String getTotal_amountString() {
		return String.valueOf(total_amount);
	}
}
