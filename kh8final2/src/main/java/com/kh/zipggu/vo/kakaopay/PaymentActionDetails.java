package com.kh.zipggu.vo.kakaopay;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PaymentActionDetails {
	private String aid;
	private String approved_at;
	private int amount;
	private int point_amount;
	private int discount_amount;
	private String payment_action_type;
	private String payload;
}
