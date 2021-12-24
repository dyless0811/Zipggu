package com.kh.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class SnsReplyDto {
	
	private int snsReplyNo;
	private int member_no;
	private int snsNo;
	private String snsReplyDetail;
	private Date snsReplyDate;
	private int snsReplySuperno;
	private int snsReplyGroupno;
	private int snsReplyDepth;
}
