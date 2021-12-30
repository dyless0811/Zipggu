package com.kh.zipggu.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.ItemFileDto;

@Repository
public class ItemFileDaoImpl implements ItemFileDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(ItemFileDto itemFileDto) {
		sqlSession.insert("itemFile.insert", itemFileDto);
		
	}

	@Override
	public int getSeq() {
		return sqlSession.selectOne("itemFile.getSeq");
	}

	@Override
	public ItemFileDto getThumnail(int itemNo) {
		return sqlSession.selectOne("itemFile.getThumbnail");
	}

}
