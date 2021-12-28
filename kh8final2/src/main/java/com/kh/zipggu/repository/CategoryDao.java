package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.CategoryDto;
import com.kh.zipggu.vo.CategoryVO;

public interface CategoryDao {
	List<CategoryVO> list();

	void add(CategoryDto categoryDto);
}
