package com.kh.zipggu.entity;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class DeliveryDto {
	
	private int deliveryNo;
	private int memberNo;
	private String deliveryTitle;
	private String deliveryName;
	private String deliveryPhone;
	private String deliveryPostcode;
	private String deliveryAddress;
	private String deliveryAddressDetail;	
}
