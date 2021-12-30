package com.kh.zipggu.repository;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.MemberDto;
import com.kh.zipggu.entity.MemberProfileDto;

@Repository
public class MemberDaoWithEncrypt implements MemberDao {

	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private PasswordEncoder encoder;

	@Override
	public MemberDto get(String memberEmail) {
		return sqlSession.selectOne("member.get", memberEmail);
	}

	@Override
	public MemberDto login(MemberDto memberDto) {
		MemberDto findDto = sqlSession.selectOne("member.get", memberDto.getMemberEmail());

		// 해당 아이디의 회원정보가 존재 && 입력 비밀번호와 조회된 비밀번호가 같다면 => 로그인 성공(객체를 반환)
		if (findDto != null && encoder.matches(memberDto.getMemberPw(), findDto.getMemberPw())) {
			return findDto;
		} else {// 아니면 null을 반환
			return null;
		}
	}

	@Override
	public void join(MemberDto memberDto) {

		// memberDto 안에 들어있는 원본 비밀번호를 BCrypt로 암호화 하여 다시 설정
		String origin = memberDto.getMemberPw();
		String encrypt = encoder.encode(origin);
		memberDto.setMemberPw(encrypt);
		// 변경된 정보를 가진 memberDto를 기존처럼 등록
		sqlSession.insert("member.insert", memberDto);
	}

	@Override
	public boolean changePassword(String memberEmail, String memberPw, String changePw) {
		// 변경해야 할 내용
		// 1. 비밀번호 검사는 무조건 encoder.matches()로 한다.
		// 2. 변경할 비밀번호는 암호화를 한다.
		MemberDto memberDto = sqlSession.selectOne("member.get", memberEmail);
		if (encoder.matches(memberPw, memberDto.getMemberPw())) {
			Map<String, Object> param = new HashMap<>();
			param.put("memberEmail", memberEmail);
			param.put("changePw", encoder.encode(changePw));// 변경할 비밀번호 암호화

			int count = sqlSession.update("member.changePassword", param);
			return count > 0;
		} else {
			return false;
		}
	}

	@Override
	public boolean changeInformation(MemberDto memberDto) {
		// 비밀번호 검사를 DAO에서 PasswordEncoder를 이용하여 수행하도록 변경
		MemberDto findDto = sqlSession.selectOne("member.get", memberDto.getMemberEmail());
		if (encoder.matches(memberDto.getMemberEmail(), findDto.getMemberEmail())) {
			// 일치하므로 변경 처리 지시
			int count = sqlSession.update("member.changeInformation", memberDto);
			return count > 0;
		} else {
			return false;
		}
	}

	@Override
	public boolean quit(String memberEmail, String memberPw) {
		MemberDto findDto = sqlSession.selectOne("member.get", memberEmail);
		if (encoder.matches(memberPw, findDto.getMemberPw())) {
			int count = sqlSession.delete("member.quit", memberEmail);
			return count > 0;
		} else {
			return false;
		}
	}

	@Override
	public MemberDto emailGet(String email) {
		return sqlSession.selectOne("member.emailGet", email);
	}

	@Override
	public MemberDto noGet(int memberNo) {
		return sqlSession.selectOne("member.noGet", memberNo);
	}

	@Override
	public void edit(MemberDto memberDto) {
					sqlSession.update("member.edit", memberDto);			
	}

}
