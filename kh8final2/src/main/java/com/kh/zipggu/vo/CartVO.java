package com.kh.zipggu.vo;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CartVO {
	
	private int itemNo;
	
	private int memberNo;
	private List<OptionVO> optionList=new ArrayList<>();
	
}
