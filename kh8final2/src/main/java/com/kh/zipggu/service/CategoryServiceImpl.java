package com.kh.zipggu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.zipggu.entity.CategoryDto;
import com.kh.zipggu.repository.CategoryDao;
import com.kh.zipggu.vo.CategoryVO;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryDao categoryDao;
	
	@Override
	public List<CategoryVO> list() {
		return categoryDao.list();
	}

	@Override
	public void add(String categoryName, int categorySuper) {
		CategoryDto categoryDto=new CategoryDto();
		categoryDto.setCategoryName(categoryName);
		categoryDto.setCategorySuper(categorySuper);
		categoryDao.add(categoryDto);
	}

	@Override
	public List<CategoryDto> listBySuper(int categorySuper) {
		
		return categoryDao.listBySuper(categorySuper);
	}

	@Override
	public void modify(int categoryNo, String categoryName) {
		
		CategoryDto categoryDto = new CategoryDto();
		categoryDto.setCategoryNo(categoryNo);
		categoryDto.setCategoryName(categoryName);
		categoryDao.modify(categoryDto);
	}

}
