package com.kh.zipggu.entity;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ItemFileDto {
	private int itemFileNo;
	private int itemNo;
	private String itemFileUploadname;
	private String itemFileSavename;
	private long itemFileSize;
	private String itemFileType;
	private int itemFileThumbnail;
	private String itemFileDel;
}
