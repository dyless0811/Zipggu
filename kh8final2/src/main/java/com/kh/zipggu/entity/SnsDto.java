package com.kh.zipggu.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class SnsDto {
	
	private int snsNo;
	private int memberNo;
	private String snsDetail;
	private Date snsDate;
	private int snsCount;
	private int snsReplyCount;
	
	public String snsDetailSub() {
		return this.snsDetail.substring(0,10);
	}
}
