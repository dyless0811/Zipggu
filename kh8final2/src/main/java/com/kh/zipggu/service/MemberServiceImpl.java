package com.kh.zipggu.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.MemberDto;
import com.kh.zipggu.entity.MemberProfileDto;
import com.kh.zipggu.repository.MemberDao;
import com.kh.zipggu.repository.MemberProfileDao;
import com.kh.zipggu.vo.MemberJoinVO;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDao memberDao;

	@Autowired
private MemberProfileDao memberProfileDao;

@Override
public void join(MemberJoinVO memberJoinVO) throws IllegalStateException, IOException {
	//(필수) 회원정보를 뽑아서 회원테이블에 저장
	//= MemberJoinVO에서 정보를 뽑아서 MemberDto를 생성하고 설정
	MemberDto memberDto = new MemberDto();
//	memberDto.setMemberId(memberJoinVO.getMemberId());
	memberDto.setMemberNo(memberJoinVO.getMemberNo());
	memberDto.setMemberPw(memberJoinVO.getMemberPw());
	memberDto.setMemberNickname(memberJoinVO.getMemberNickname());
//	memberDto.setMemberBirth(memberJoinVO.getMemberBirth());
	memberDto.setMemberEmail(memberJoinVO.getMemberEmail());
//	memberDto.setMemberPhone(memberJoinVO.getMemberPhone());
	memberDao.join(memberDto);

	//(선택) 회원이미지 정보를 뽑아서 이미지 테이블과 실제 하드디스크에 저장
	MultipartFile multipartFile = memberJoinVO.getAttach();
	if(!multipartFile.isEmpty()) {//파일이 있으면
		MemberProfileDto memberProfileDto = new MemberProfileDto();
//		memberProfileDto.setMemberId(memberJoinVO.getMemberId());
		memberProfileDto.setMemberProfileUploadname(multipartFile.getOriginalFilename());
		memberProfileDto.setMemberProfileType(multipartFile.getContentType());
		memberProfileDto.setMemberProfileSize(multipartFile.getSize());
		memberProfileDao.save(memberProfileDto, multipartFile);
	}
}

}
