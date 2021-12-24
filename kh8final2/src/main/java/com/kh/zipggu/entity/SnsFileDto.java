package com.kh.zipggu.entity;

import lombok.Data;

@Data
public class SnsFileDto {
	
	private int snsFileNo;
	private int snsNo;
	private int thumnail;
	private String snsFileUploadname;
	private String snsFileSavename;
	private long snsFileSize;
	private String snsFileType;
}
