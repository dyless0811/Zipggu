package com.kh.zipggu.service;

import java.io.IOException;
import java.util.List;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.ItemDto;
import com.kh.zipggu.vo.ItemInsertVO;
import com.kh.zipggu.vo.ItemListVO;
import com.kh.zipggu.vo.ItemSearchVO;

public interface ItemService {
	int insert(ItemInsertVO itemInsertVo, MultipartFile thumbnail, List<MultipartFile> attach) throws IllegalStateException, IOException;

	ResponseEntity<ByteArrayResource> getThumbnail(int itemNo) throws IOException;

	ResponseEntity<ByteArrayResource> getFile(int itemFileNo) throws IOException;

	ItemDto get(int itemNo);

	List<ItemListVO> listBySearchVO(ItemSearchVO itemSearchVO);
}
