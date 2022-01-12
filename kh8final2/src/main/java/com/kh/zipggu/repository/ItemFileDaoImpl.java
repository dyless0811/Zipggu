package com.kh.zipggu.repository;

import java.util.ArrayList;
import java.util.List;

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
		return sqlSession.selectOne("itemFile.getThumbnail", itemNo);
	}

	@Override
	public ItemFileDto get(int itemFileNo) {
		return sqlSession.selectOne("itemFile.get", itemFileNo);
	}

	@Override
	public List<ItemFileDto> fileListByItemNo(int itemNo) {
		return sqlSession.selectList("itemFile.listByItemNo", itemNo);
	}

	@Override
	public List<ItemFileDto> nonThumbnailListByItemNo(int itemNo) {
		
		return sqlSession.selectList("itemFile.nonThumbnailListByItemNo", itemNo);
	}

	@Override
	public void updateFile(int thumbnailNo) {
		List<Integer> files = new ArrayList<Integer>();
		files.add(thumbnailNo);
		updateFiles(files);
	}
	@Override
	public void updateFiles(List<Integer> remainingFile) {
		sqlSession.update("itemFile.updateFiles", remainingFile);
	}

	@Override
	public void deleteFiles(int itemNo) {
		sqlSession.update("itemFile.deleteFiles", itemNo);	
	}

}
