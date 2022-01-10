package com.kh.zipggu.entity;

import lombok.Data;

@Data
public class ReviewFileDto {
	
	private int reviewFileNo;
	private int reviewNo;
	private String reviewFileUploadname;
	private String reviewFileSavename;
	private long reviewFileSize;
	private String reviewFileType;
}
