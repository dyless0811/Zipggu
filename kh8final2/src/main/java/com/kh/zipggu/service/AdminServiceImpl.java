package com.kh.zipggu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.zipggu.repository.CategoryDao;
import com.kh.zipggu.vo.CategoryVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private CategoryDao categoryDao;
	
	@Override
	public List<CategoryVO> list() {
		return categoryDao.list();
	}

}
