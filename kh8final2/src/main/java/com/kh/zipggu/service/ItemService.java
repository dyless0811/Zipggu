package com.kh.zipggu.service;

import java.io.IOException;
import java.util.List;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.vo.ItemInsertVO;

public interface ItemService {
	int insert(ItemInsertVO itemInsertVo, List<MultipartFile> attach) throws IllegalStateException, IOException;

	ResponseEntity<ByteArrayResource> getThumbnail(int itemNo) throws IOException;
}
