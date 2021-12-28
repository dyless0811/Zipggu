package com.kh.zipggu.repository;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.CertificationDto;
@Repository
public class CertificationDaoImpl   implements CertificationDao{
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(CertificationDto certificationDto) {

		sqlSession.insert("certification.allInOneInsert", certificationDto);
	}

	@Override
	public boolean check(CertificationDto certificationDto) {
		CertificationDto findDto = sqlSession.selectOne("certification.check", certificationDto);
		if(findDto != null) {//인증 성공 시
			sqlSession.delete("certification.delete", certificationDto.getEmail());
			return true;
		}
		else {//인증 실패 시
			return false; 
		}
	}
	
	@Override
	public void clean() {
		sqlSession.delete("certification.clean");
	}

	@Override
	public CertificationDto get(String memberEmail, String serial) {
		Map<String, Object> param = new HashMap<>();
		param.put("email", memberEmail);
		param.put("serial", serial);
		return sqlSession.selectOne("certification.get", param);
	}

	
//	@Override
//	public CertificationDto get(String memberEmail) {
//		return sqlSession.selectOne("certification.get", memberEmail);
//	}
	
}