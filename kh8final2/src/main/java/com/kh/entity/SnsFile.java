package com.kh.entity;

import lombok.Data;

@Data
public class SnsFile {
	
	private int snsFileNo;
	private String snsFileUploadname;
	private String snsFileSavename;
	private long snsFileSize;
	private String snsFileType;
}
