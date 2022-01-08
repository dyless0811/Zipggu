package com.kh.zipggu.entity;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SnsDto {
	
	private int snsNo;
	private int memberNo;
	private String snsDetail;
	private Date snsDate;
	private int snsCount;
	private int snsReplyCount;
	
	
}
