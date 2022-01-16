package com.kh.zipggu.repository;
import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.MemberDto;
import com.kh.zipggu.entity.MemberProfileDto;
import com.kh.zipggu.entity.SnsDto;
import com.kh.zipggu.vo.MemberJoinVO;
import com.kh.zipggu.vo.MemberUploadVO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Repository
public class MemberProfileDaoImpl implements MemberProfileDao{
	
	
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private MemberProfileDao memberProfileDao;

	
	//저장용 폴더
	private File directory = new File("D:/upload/kh82/member");
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
	public byte[] load(int memberNo) throws IOException {
		File target = new File(directory, String.valueOf(memberNo));
		byte[] data = FileUtils.readFileToByteArray(target);
		return data;
	}

	@Override
	public MemberProfileDto noGet(int memberNo) {
		return sqlSession.selectOne("memberProfile.noGet", memberNo);
	}

	@Override
	public void delete(int memberNo) {
		sqlSession.delete("memberProfile.delete",memberNo);
		}

	@Override
	public void upload(MemberProfileDto memberProfileDto, MultipartFile multipartFile) throws IllegalStateException, IOException {
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
	public void edit(MemberProfileDto memberProfileDto) {
		sqlSession.update("memberProfile.edit", memberProfileDto);
	}

}