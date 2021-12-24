package com.kh.zipggu.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.SnsDto;
import com.kh.zipggu.entity.SnsFileDto;
import com.kh.zipggu.repository.SnsDao;
import com.kh.zipggu.repository.SnsFileDao;



@Service
public class SnsServiceImpl implements SnsService{
	
	@Autowired
	private SnsDao snsDao;
	
	@Autowired
	private SnsFileDao snsFileDao;
	

	//SNS 글 등록 Service(상세 페이지 구현 전)
	@Override
	public int write(SnsDto snsDto, List<MultipartFile> attach) throws IllegalStateException, IOException {
		
		//첨부파일 등록을 위해 snsNo 번호 먼저 뽑아내기
		//(첨부파일에 sns번호 외래키가 있고, 글 등록 후 상세페이지로 보내주기 위함)
		int sequence = snsDao.sequence();
		
		//SnsWriteVO에서 받은 값을 snsDto객체에 저장
		snsDto.setSnsNo(sequence);
		
		//저장한 값들을 snsDao.write로 넘겨준다
		snsDao.write(snsDto);
		
		
		int count = 1;
		//다중 첨부파일이 때문에 반복문으로 꺼내기
		for(MultipartFile file : attach) {
			
			//만약 파일이 있다면
			if(!file.isEmpty()) {
				
				//등록페이지에서 넘어오는 정보만 snsFileDto 객체에 정보 담아Dao로 보내기
				//(여기서는 정보만 담아 보낸다)
				SnsFileDto snsFileDto = new SnsFileDto();
				snsFileDto.setSnsNo(sequence); //sns 시퀀스
				snsFileDto.setSnsFileUploadname(file.getOriginalFilename());
				snsFileDto.setThumnail(count++);
				snsFileDto.setSnsFileType(file.getContentType());
				snsFileDto.setSnsFileSize(file.getSize());
				//snsFileDao로 보내주고 등록 시작
				snsFileDao.insert(snsFileDto, file);
			}	
			
		}
		
		//sns, snsFile 등록이 완료되면 controller로 게시글 번호 반환
		return sequence;
	}
	
	
}
