package com.kh.zipggu.vo;

import java.util.List;

import com.kh.zipggu.entity.ItemOptionDto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ItemOptionListVO {
	List<ItemOptionDto> optionList;
}
