package com.kh.zipggu.service;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.ItemDto;
import com.kh.zipggu.entity.ItemOptionDto;
import com.kh.zipggu.entity.ItemFileDto;
import com.kh.zipggu.repository.ItemDao;
import com.kh.zipggu.repository.ItemFileDao;
import com.kh.zipggu.repository.ItemOptionDao;
import com.kh.zipggu.vo.ItemInsertVO;
import com.kh.zipggu.vo.ItemListVO;
import com.kh.zipggu.vo.ItemSearchVO;
import com.kh.zipggu.vo.ItemUpdateVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ItemServiceImpl implements ItemService {

	@Autowired
	private ItemDao itemDao;
	
	@Autowired
	private ItemOptionDao itemOptionDao;
	
	@Autowired
	private ItemFileDao itemFileDao;
	
	private File directory = new File("D:/upload/ITEM");
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insert(ItemInsertVO itemInsertVo, MultipartFile thumbnail, List<MultipartFile> attach) throws IllegalStateException, IOException {
		int itemNo = itemDao.sequance();
		
		ItemDto itemDto = new ItemDto();
		itemDto.setItemNo(itemNo);
		itemDto.setCategoryNo(itemInsertVo.getCategoryNo());
		itemDto.setItemName(itemInsertVo.getItemName());
		itemDto.setItemPrice(itemInsertVo.getItemPrice());
		itemDto.setItemShippingType(itemInsertVo.getItemShippingType());
		
		itemDao.insert(itemDto);
		
		if(itemInsertVo.getOptionList() == null) {
			ItemOptionDto itemOptionDto = new ItemOptionDto();
			itemOptionDto.setItemNo(itemNo);
			itemOptionDto.setItemOptionGroup("기본");
			itemOptionDto.setItemOptionDetail("단품");
			itemOptionDto.setItemOptionPrice(0);
			itemOptionDto.setItemOptionRequired(1);
			
			itemOptionDao.insert(itemOptionDto);
		} else {
			for (ItemOptionDto itemOptionDto : itemInsertVo.getOptionList()) {
				itemOptionDto.setItemNo(itemNo);
				
				itemOptionDao.insert(itemOptionDto);
			}			
		}
		itemFileInsert(itemNo, thumbnail, true);
		//다중 첨부파일이 때문에 반복문으로 꺼내기
		for(MultipartFile file : attach) {
			itemFileInsert(itemNo, file, false);		
		}
		return itemNo;
	}

	private void itemFileInsert(int itemNo, MultipartFile file, boolean isThumbnail) throws IOException {
		log.debug("=============================================파일인서트");
		int thumbnail = isThumbnail ? 1 : 0;
		//만약 파일이 있다면
		if(!file.isEmpty()) {
			
			log.debug("=============================================파일인서트이프문");
			//등록페이지에서 넘어오는 정보만 snsFileDto 객체에 정보 담아Dao로 보내기
			//(여기서는 정보만 담아 보낸다)
			int itemFileNo = itemFileDao.getSeq();
			
			File target = new File(directory, String.valueOf(itemFileNo));
			file.transferTo(target);
			
			ItemFileDto itemFileDto = new ItemFileDto();
			itemFileDto.setItemFileNo(itemFileNo);
			itemFileDto.setItemNo(itemNo);
			itemFileDto.setItemFileUploadname(file.getOriginalFilename());
			itemFileDto.setItemFileSavename(String.valueOf(itemFileNo));
			itemFileDto.setItemFileSize(file.getSize());
			itemFileDto.setItemFileType(file.getContentType());
			itemFileDto.setItemFileThumbnail(thumbnail);
			//snsFileDao로 보내주고 등록 시작
			itemFileDao.insert(itemFileDto);
		}
	}
	
	@Override
	public ResponseEntity<ByteArrayResource> getDummy() throws IOException {
		
		
		//ItemNo로 실제 파일 정보를 불러온다
		File target = new File(directory, "dummy");

		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data); 
		
		String encodeName = URLEncoder.encode("dummy.png", "UTF-8");
		encodeName = encodeName.replace("+", "%20");
		
		return ResponseEntity.ok()
				.contentType(MediaType.APPLICATION_OCTET_STREAM)
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
				.header("content-Encoding", "UTF-8")
				.contentLength(1132)
				.body(resource);
	}
	@Override
	public ResponseEntity<ByteArrayResource> getThumbnail(int itemNo) throws IOException {
		
		ItemFileDto itemFileDto = itemFileDao.getThumnail(itemNo);
		if(itemFileDto == null) {
			return getDummy();
		}
		
		//ItemNo로 실제 파일 정보를 불러온다
		File target = new File(directory, String.valueOf(itemFileDto.getItemFileNo()));
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data); 
		
		String encodeName = URLEncoder.encode(itemFileDto.getItemFileUploadname(), "UTF-8");
		encodeName = encodeName.replace("+", "%20");
		
		return ResponseEntity.ok()
						.contentType(MediaType.APPLICATION_OCTET_STREAM)
						.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
						.header("content-Encoding", "UTF-8")
						.contentLength(itemFileDto.getItemFileSize())
						.body(resource);
	}

	@Override
	public ResponseEntity<ByteArrayResource> getFile(int itemFileNo) throws IOException {
		ItemFileDto itemFileDto = itemFileDao.get(itemFileNo);
		
		//ItemNo로 실제 파일 정보를 불러온다
		File target = new File(directory, String.valueOf(itemFileDto.getItemFileNo()));
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data); 
		
		String encodeName = URLEncoder.encode(itemFileDto.getItemFileUploadname(), "UTF-8");
		encodeName = encodeName.replace("+", "%20");
		
		return ResponseEntity.ok()
						.contentType(MediaType.APPLICATION_OCTET_STREAM)
						.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+encodeName+"\"")
						.header("content-Encoding", "UTF-8")
						.contentLength(itemFileDto.getItemFileSize())
						.body(resource);
	}

	@Override
	public ItemDto get(int itemNo) {
		return itemDao.get(itemNo);
	}

	@Override
	public List<ItemListVO> listBySearchVO(ItemSearchVO itemSearchVO) {
		return itemDao.listBySearchVO(itemSearchVO);
	}

	@Override
	public void itemOptionDetailDelete(int itemOptionNo) {
		itemOptionDao.itemOptionDetailDelete(itemOptionNo);
	}

	@Override
	public void itemOptionGroupRemove(ItemOptionDto itemOptionDto) {
		itemOptionDao.itemOptionGroupRemove(itemOptionDto);
	}

	@Override
	public void itemOptionDetailUpdate(ItemOptionDto itemOptionDto) {
		itemOptionDao.itemOptionDetailUpdate(itemOptionDto);
	}


	@Override
	public void itemOptionGroupUpdate(int itemNo, String itemOptionGroup, String changeGroup) {
		Map<String, Object> param = new LinkedHashMap<String, Object>();
		param.put("itemNo", itemNo);
		param.put("itemOptionGroup", itemOptionGroup);
		param.put("changeGroup", changeGroup);
		itemOptionDao.itemOptionGroupUpdate(param);		
	}

	@Override
	public void itemOptionDetailInsert(ItemOptionDto itemOptionDto) {
		itemOptionDao.itemOptionDetailInsert(itemOptionDto);
	}

	@Override
	public int update(ItemUpdateVO itemUpdateVO, MultipartFile thumbnail, List<MultipartFile> attach) throws IOException {
		int itemNo = itemUpdateVO.getItemNo();
		//item 테이블 수정
		ItemDto itemDto = new ItemDto();
		itemDto.setItemNo(itemNo);
		itemDto.setCategoryNo(itemUpdateVO.getCategoryNo());
		itemDto.setItemName(itemUpdateVO.getItemName());
		itemDto.setItemPrice(itemUpdateVO.getItemPrice());
		itemDto.setItemShippingType(itemUpdateVO.getItemShippingType());
		
		itemDao.update(itemDto);
		
		//추가한 옵션이 있다면 등록
		if(itemUpdateVO.getOptionList() == null) {
			if(itemOptionDao.listByItemNo(itemNo) == null) {					
				ItemOptionDto itemOptionDto = new ItemOptionDto();
				itemOptionDto.setItemNo(itemNo);
				itemOptionDto.setItemOptionGroup("기본");
				itemOptionDto.setItemOptionDetail("단품");
				itemOptionDto.setItemOptionPrice(0);
				itemOptionDto.setItemOptionRequired(1);			
				itemOptionDao.insert(itemOptionDto);
			}
		} else {
			for (ItemOptionDto itemOptionDto : itemUpdateVO.getOptionList()) {
				itemOptionDto.setItemNo(itemNo);
				itemOptionDao.insert(itemOptionDto);
			}			
		}
		
		//썸네일이 없다면 추가
		if(!itemUpdateVO.isThumbnailRemaining()) {
			itemFileInsert(itemNo, thumbnail, true);
		}
		
		if(itemUpdateVO.isFileRemaining()) {
			itemFileDao.updateFiles(itemUpdateVO.getRemainingFile());
		}
		
		//다중 첨부파일이 때문에 반복문으로 꺼내기
		for(MultipartFile file : attach) {
			itemFileInsert(itemNo, file, false);		
		}
		return itemNo;
	}

	@Override
	public ItemDto delete(int itemNo) {
		ItemDto deletedItemDto = itemDao.get(itemNo);
		itemDao.delete(itemNo);
		return deletedItemDto;
	}
	
	

}
