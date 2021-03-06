package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.ItemFileDto;

public interface ItemFileDao {

	void insert(ItemFileDto itemFileDto);
	
	int getSeq();

	ItemFileDto getThumnail(int itemNo);

	ItemFileDto get(int itemFileNo);

	List<ItemFileDto> fileListByItemNo(int itemNo);

	List<ItemFileDto> nonThumbnailListByItemNo(int itemNo);

	void updateFile(int thumbnailNo);
	void updateFiles(List<Integer> remainingFile);

	void deleteFiles(int itemNo);

	void schedule();

}