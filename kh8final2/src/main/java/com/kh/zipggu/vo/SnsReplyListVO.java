package com.kh.zipggu.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class SnsReplyListVO {
	
	private int snsReplyNo;
	private int memberNo;
	private int snsNo;
	private String snsReplyDetail;
	private Date snsReplyDate;
	private int snsReplySuperno;
	private int snsReplyGroupno;
	private int snsReplyDepth;
	private String memberNickname;
}
