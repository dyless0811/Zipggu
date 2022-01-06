package com.kh.zipggu.vo.kakaopay;

import java.sql.Date;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class KakaoPaySearchResponseVO {
	private String tid;
	private String cid;
	private String status;
	private String partner_order_id;
	private String partner_user_id;
	private String partner_method_type;
	
	private Amount amount;
	private Amount canceled_amount;
	private Amount cancel_available_amount;
	
	private String item_name;
	private String item_code;
	private int quantity;
	
	private Date created_at;
	private Date approved_at;
	private Date canceled_at;
	
	private SelectedCardInfo selected_card_info;
	private List<PaymentActionDetails> payment_action_details;
}
