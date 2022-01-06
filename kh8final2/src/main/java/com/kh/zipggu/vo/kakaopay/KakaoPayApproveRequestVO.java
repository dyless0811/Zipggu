package com.kh.zipggu.vo.kakaopay;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class KakaoPayApproveRequestVO {
	private String tid;
	private String partner_order_id;
	private String partner_user_id;
	private String pg_token;
}
