package com.kh.zipggu.service;

import java.util.List;

import com.kh.zipggu.entity.CategoryDto;
import com.kh.zipggu.vo.CategoryVO;

public interface CategoryService {
	List<CategoryVO> list();

	void add(String categoryName, int categorySuper);

	List<CategoryDto> listBySuper(int categorySuper);

	void modify(int categoryNo, String categoryName);

	void delete(int categoryNo);
}
