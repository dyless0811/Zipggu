package com.kh.zipggu.repository;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.SnsFileDto;

@Repository
public class SnsFileDaoImpl implements SnsFileDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	//저장용 폴더
	private File directory = new File("D:/upload/SNS");
	
	//시퀀스값 먼저 받는 기능
	@Override
	public int sequence() {
		
		return sqlSession.selectOne("snsFile.sequence");
	}
	
	//첨부파일 등록 기능
	@Override
	public void insert(SnsFileDto snsFileDto, MultipartFile file) throws IllegalStateException, IOException {

		//겹치지 않는 파일이름으로 저장하기 위해 시퀀스값 먼저 받기
		int sequence = sqlSession.selectOne("snsFile.sequence");
		
		//시퀀스 번호로 실제 파일저장
		File target = new File(directory, String.valueOf(sequence));
		file.transferTo(target);
		
		//파일 정보 db저장
		snsFileDto.setSnsFileNo(sequence);
		snsFileDto.setSnsFileSavename(String.valueOf(sequence));
		sqlSession.insert("snsFile.insert", snsFileDto);
	}
	
	//목록페이지 썸네일 기능
	@Override
	public SnsFileDto getThumnail(int snsNo) {
		
		return sqlSession.selectOne("snsFile.getThumnail", snsNo);
		
	}
	
	//썸네일 파일 다운로드 기능
	@Override
	public byte[] load(int snsNo) throws IOException {
		
		File target = new File(directory, String.valueOf(snsNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		
		return data;
		
	}
	
	//파일 목록 조회
	@Override
	public List<SnsFileDto> list(int snsNo) {
		
		return sqlSession.selectList("snsFile.list", snsNo);
	}
	
	//파일 단일조회
	@Override
	public SnsFileDto get(int snsFileNo) {
		
		return sqlSession.selectOne("snsFile.get", snsFileNo);
	}
	
	//파일 삭제
	@Override
	public void delete(int snsFileNo) {
		
		sqlSession.delete("snsFile.delete", snsFileNo);
		
	}
}
