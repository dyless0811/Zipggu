package com.kh.zipggu.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.MemberDto;

//@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public MemberDto get(String memberEmail) {
		return sqlSession.selectOne("member.get", memberEmail);
	}

	@Override
	public MemberDto login(MemberDto memberDto) {
		MemberDto findDto = sqlSession.selectOne("member.get", memberDto.getMemberEmail());

		//해당 아이디의 회원정보가 존재 && 입력 비밀번호와 조회된 비밀번호가 같다면 => 로그인 성공(객체를 반환)
		if(findDto != null && memberDto.getMemberPw().equals(findDto.getMemberPw())) {
			return findDto;
		}
		else {//아니면 null을 반환
			return null;
		}
	}
	
	@Override
	public void join(MemberDto memberDto) {
		sqlSession.insert("member.insert", memberDto);
	}
	
	@Override
	public boolean changePassword(String memberEmail, String memberPw, String changePw) {
		Map<String, Object> param = new HashMap<>();
		param.put("memberEmail", memberEmail);
		param.put("memberPw", memberPw);
		param.put("changePw", changePw);
		int count = sqlSession.update("member.changePassword", param);
		return count > 0;
	}
	
	@Override
	public boolean changeInformation(MemberDto memberDto) {
		int count = sqlSession.update("member.changeInformation", memberDto);
		return count > 0;
	}

	@Override
	public boolean quit(String memberEmail, String memberPw) {
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberEmail(memberEmail);
		memberDto.setMemberPw(memberPw);
		int count = sqlSession.delete("member.quit", memberDto);
		return count > 0;
	}

	@Override
	public MemberDto emailGet(String email) {
		return sqlSession.selectOne("member.emailGet", email);
	}
	
}
