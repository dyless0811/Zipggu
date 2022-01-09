package com.kh.zipggu.entity;

import lombok.Data;

@Data
public class MemberDto {
	private int memberNo;
	private String memberEmail;
	private String memberPw;
	private String memberNickname;
	private String memberBirth;
	private String memberJoin;
	private int memberPoint;
	private String memberGrade;
	private String memberIntroduce;
	private String memberType;
	private String memberGender;
	
	public String getMemberBirthDay() {
		return this.memberBirth.substring(0,10);
	}

	public String getMemberJoinDay() {
		return this.memberJoin.substring(0,10);
	}	
	
}
