package com.kh.zipggu.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class SnsListVO {
	
	private int snsNo;
	private int memberNo;
	private String snsDetail;
	private Date snsDate;
	private int snsCount;
	private int snsReplyCount;
	private String memberNickname;
	private int count;
	
	
}
