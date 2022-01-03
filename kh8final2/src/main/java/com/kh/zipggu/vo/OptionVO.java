package com.kh.zipggu.vo;

import java.util.ArrayList;
import java.util.List;

import com.kh.zipggu.entity.ItemOptionDto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OptionVO {
	
	private int quantity;
	List<ItemOptionDto> noList = new ArrayList<>();
	
	
	
}
