package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.MemberDto;


public interface MemberDao {

	void join(MemberDto memberDto);//가입

	MemberDto get(String memberEmail);//그냥 단일조회
	
	MemberDto emailGet(String email);//네이버 이메일 조회
	
	MemberDto login(MemberDto memberDto);//비밀번호 검사까지 통과하면 객체를 반환하도록 구현

	//비밀번호 변경
	boolean changePassword(String memberEmail, String memberPw, String changePw);
	
	//개인정보 변경
	boolean changeInformation(MemberDto memberDto);
	
	//회원 탈퇴
	boolean quit(String memberEmail, String memberPw);
	
	
}
