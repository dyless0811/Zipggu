package com.kh.zipggu.service;

import java.io.IOException;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.MemberDto;
import com.kh.zipggu.entity.MemberProfileDto;
import com.kh.zipggu.repository.MemberDao;
import com.kh.zipggu.repository.MemberProfileDao;
import com.kh.zipggu.vo.MemberJoinVO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private MemberProfileDao memberProfileDao;
	
	@Autowired
	private SqlSession sqlSession;


	
	
	
@Override
public void join(MemberJoinVO memberJoinVO) throws IllegalStateException, IOException {
	
	int sequence = sqlSession.selectOne("member.seq");
	
	log.debug("sequence = {}", sequence);
	
	MemberDto memberDto = new MemberDto();
	memberDto.setMemberNo(sequence);
	memberDto.setMemberEmail(memberJoinVO.getMemberEmail());
	memberDto.setMemberPw(memberJoinVO.getMemberPw());
	memberDto.setMemberNickname(memberJoinVO.getMemberNickname());
	
	memberDao.join(memberDto);

	
	MultipartFile multipartFile = memberJoinVO.getAttach();
	if(!multipartFile.isEmpty()) {//파일이 있으면
		MemberProfileDto memberProfileDto = new MemberProfileDto();
		memberProfileDto.setMemberNo(sequence);
		memberProfileDto.setMemberProfileUploadname(multipartFile.getOriginalFilename());
		memberProfileDto.setMemberProfileType(multipartFile.getContentType());
		memberProfileDto.setMemberProfileSize(multipartFile.getSize());
		memberProfileDao.save(memberProfileDto, multipartFile);
	}
}

}
