package com.kh.zipggu.repository;
import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;
import com.kh.zipggu.entity.MemberProfileDto;
@Repository
public class MemberProfileDaoImpl implements MemberProfileDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	//저장용 폴더
	private File directory = new File("D:/upload/member");
	/**
	 * 등록 절차
	 * 1. 시퀀스 번호를 구해온다.
	 * 2. 실제 파일을 시퀀스 번호로 저장한다.
	 * 3. 파일 정보를 DB에 저장한다.
	 */
	@Override
	public void save(MemberProfileDto memberProfileDto, MultipartFile multipartFile) throws IllegalStateException, IOException {
		//1
		int sequence = sqlSession.selectOne("memberProfile.seq");
		
		//2
		File target = new File(directory, String.valueOf(sequence));
		multipartFile.transferTo(target);
		
		//3
		memberProfileDto.setMemberProfileNo(sequence);
		memberProfileDto.setMemberProfileSavename(String.valueOf(sequence));
		sqlSession.insert("memberProfile.save", memberProfileDto);
	}

	@Override
	public MemberProfileDto get(int memberProfileNo) {
		return sqlSession.selectOne("memberProfile.get", memberProfileNo);
	}

	@Override
	public byte[] load(int memberProfileNo) throws IOException {
		File target = new File(directory, String.valueOf(memberProfileNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}

	@Override
	public MemberProfileDto get(String memberEmail) {
		return sqlSession.selectOne("memberProfile.getByEmail", memberEmail);
	}

}