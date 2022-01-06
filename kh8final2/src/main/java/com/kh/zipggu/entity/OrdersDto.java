package com.kh.zipggu.entity;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrdersDto {
	private int orderNo;
	private int memberNo;
	private String addresseeName;
	private String addresseePhone;
	private int addresseePostCode;
	private String addresseeAddress;
	private String addresseeAddressDetail;
	private String tid;
	private String orderName;
	private int totalAmount;
	private Date orderDate;
	private String orderStatus;
}
