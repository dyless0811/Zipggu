package com.kh.zipggu.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberUploadVO {
	private int memberNo;
	private MultipartFile attach;
	private int memberProfileNo;
	private String memberProfileUploadname;
	private String memberProfileSavename;
	private long memberProfileSize;
	private String memberProfileType;
}
