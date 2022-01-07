package com.kh.zipggu.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.SnsDto;
import com.kh.zipggu.entity.SnsFileDto;
import com.kh.zipggu.repository.MemberDao;
import com.kh.zipggu.repository.SnsDao;
import com.kh.zipggu.repository.SnsFileDao;
import com.kh.zipggu.repository.SnsReplyDao;
import com.kh.zipggu.vo.SnsListVO;



@Service
public class SnsServiceImpl implements SnsService{
	
	@Autowired
	private SnsDao snsDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private SnsFileDao snsFileDao;

	
	//저장 폴더
	private File directory = new File("D:/upload/SNS");

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
	
	
	//게시글 수정 기능
	@Override
	public void edit(SnsDto snsDto, List<MultipartFile> attach) throws IllegalStateException, IOException {
		//검사값 false를 변수에 담고
		boolean check = false;
		//파일이 있는지 없는 체크
		for(MultipartFile file : attach) {
			//만약 파일이 비어있지 않다면
			if(!file.isEmpty()) {
				check = true;
				break;
			}
		}
		
		//파일이 있다면 기존 파일을 삭제하고 새로운 파일을 추가
		if(check) {
			//해당 번호에 파일 업로드 되어 있는지 확인한다
			
			List<SnsFileDto> list = snsFileDao.list(snsDto.getSnsNo());
			
			if(!list.isEmpty()) {
				//파일이 있다면
				for(SnsFileDto file : list) {
					//하나씩 꺼내서 삭제
					File target = new File(directory, String.valueOf(file.getSnsFileSavename()));
					target.delete();
					
					//db에서도 파일 삭제
					snsFileDao.delete(file.getSnsFileNo());
				}
			}
			
			
			int count = 1;
			//새로운 파일이 들어온 것으로 수정
			for(MultipartFile file : attach) {
				if(!file.isEmpty()) {

					//등록페이지에서 넘어오는 정보만 snsFileDto 객체에 정보 담아Dao로 보내기
					//(여기서는 정보만 담아 보낸다)
					SnsFileDto snsFileDto = new SnsFileDto();
					snsFileDto.setSnsNo(snsDto.getSnsNo()); //sns 시퀀스
					snsFileDto.setSnsFileUploadname(file.getOriginalFilename());
					snsFileDto.setThumnail(count++);
					snsFileDto.setSnsFileType(file.getContentType());
					snsFileDto.setSnsFileSize(file.getSize());
					//snsFileDao로 보내주고 등록 시작
					snsFileDao.insert(snsFileDto, file);
				}
			}
		}
		
		//게시판 내용 수정
		snsDao.edit(snsDto);
	}
	
	
	//게시글 삭제 기능
	@Override
	public void delete(int snsNo) {
		
		//첨부 파일 삭제를 위해 snsNo로 게시글 번호에 해당하는 첨부파일 확인
		List<SnsFileDto>list = snsFileDao.list(snsNo);
		
		 if(!list.isEmpty()) {
			 
			 for(SnsFileDto file : list) {
				 
				File target = new File(directory, String.valueOf(file.getSnsFileSavename()));
				target.delete();
				
				snsFileDao.delete(file.getSnsFileNo());
			 }
		 }
		 
		 snsDao.delete(snsNo);
	}
	
	//페이징 목록
//	@Override
//	public List<SnsListVO> listByPage(int startRow, int endRow, String column) {
//		
//		return snsDao.listByPage(startRow, endRow, column);
//	}
	
	@Override
	public List<SnsListVO> listByPage(Map<String, Object> param) {
		
		return snsDao.listByPage(param);
	}
	
}
