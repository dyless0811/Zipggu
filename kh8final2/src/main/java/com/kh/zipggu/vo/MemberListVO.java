package com.kh.zipggu.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberListVO {
	
	private int memberNo;
	private String memberEmail;
	private String memberPw;
	private String memberNickname;
	private Date memberJoin;
	private int memberPoint;
	private String memberGrade;
	private String memberIntroduce;
	
	private int memberProfileNo;
	
}
