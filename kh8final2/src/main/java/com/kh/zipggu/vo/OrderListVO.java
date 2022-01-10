package com.kh.zipggu.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrderListVO {
	private int orderNo;
	private String orderName;
	private int totalAmount;
	private String tid;
	private int memberNo;
	private String memberNickname;
	private Date orderDate;
	private String orderStatus;
}
