 package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.MemberDto;
import com.kh.zipggu.vo.MemberListVO;

public interface MemberDao {

	void join(MemberDto memberDto);//가입

	MemberDto get(String memberEmail);//이메일 단일조회
	
	MemberDto noGet(int memberNo);//회원번호 단일조회
	
	MemberDto emailGet(String email);//네이버 이메일 조회
	
	MemberListVO login(MemberListVO memberListVO);//비밀번호 검사까지 통과하면 객체를 반환하도록 구현	
	
	//비밀번호 변경
	boolean changePassword(String memberEmail, String memberPw, String changePw);
	
	//회원 정보 변경
	void edit(MemberDto memberDto);
	
	//개인정보 변경
	boolean changeInformation(MemberDto memberDto);
	
	//회원 탈퇴
	boolean quit(String memberEmail, String memberPw);
	
	List<MemberListVO> VOlist (MemberListVO memberListVO);
	
	List<MemberDto> list (MemberDto memberDto);	
	
}
