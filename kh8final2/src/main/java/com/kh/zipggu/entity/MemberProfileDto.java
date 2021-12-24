package com.kh.zipggu.entity;

import lombok.Data;

@Data
public class MemberProfileDto {
	private int memberProfileNo;
	private String memberEmail;
	private String memberProfileUploadname;
	private String memberProfileSavename;
	private long memberProfileSize;
	private String memberProfileType;
}
