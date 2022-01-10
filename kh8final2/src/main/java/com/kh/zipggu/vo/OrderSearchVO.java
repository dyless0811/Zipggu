package com.kh.zipggu.vo;

import java.sql.Date;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrderSearchVO {
	private int orderNo;
	private String orderName;
	private int memberNo;
	private String memberNickname;
	private Date minDate;
	private Date maxDate;
	private String orderStatus;
	private String order;
	private String sort;
	private int startRow = 1;
	private int endRow = 24;
}
