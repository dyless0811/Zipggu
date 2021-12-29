package com.kh.zipggu.service;

import java.util.List;

import com.kh.zipggu.vo.CategoryVO;

public interface CategoryService {
	List<CategoryVO> list();

	void add(String categoryName, int categorySuper);
}
