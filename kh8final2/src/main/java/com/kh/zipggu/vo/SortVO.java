package com.kh.zipggu.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SortVO {
	private String order;//정렬항목
	private String sort;//정렬방식
}
