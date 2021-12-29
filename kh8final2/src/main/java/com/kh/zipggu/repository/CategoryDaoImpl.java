package com.kh.zipggu.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.CategoryDto;
import com.kh.zipggu.vo.CategoryVO;

@Repository
public class CategoryDaoImpl implements CategoryDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<CategoryVO> list() {
		return sqlSession.selectList("category.listCustom2");
	}

	@Override
	public void add(CategoryDto categoryDto) {
		sqlSession.insert("category.add",categoryDto);
		
	}

	@Override
	public List<CategoryDto> listBySuper(int categorySuper) {
		return sqlSession.selectList("category.listBySuper", categorySuper);
	}
	

}
