package com.kh.zipggu.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberDto {
	private int memberNo;
	private String memberEmail;
	private String memberPw;
	private String memberNickname;
	private Date memberJoin;
	private int memberPoint;
	private String memberGrade;
	private String birthday;
	private String birthyear;


}
