package com.kh.zipggu.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.SnsReplyDto;
import com.kh.zipggu.vo.SnsReplyListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class SnsReplyDaoImpl implements SnsReplyDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	//댓글 등록 기능
	@Override
	public void insert(SnsReplyDto snsReplyDto) {
		
		int sequence = sqlSession.selectOne("snsReply.sequence");
		snsReplyDto.setSnsReplyNo(sequence);
		
		//넘어온 객체의 상위번호가 0이상이라면 (대댓글 등록)
		if(snsReplyDto.getSnsReplySuperno() > 0) {
			//넘어온 상위 댓글로 단일조회
			SnsReplyDto reply = sqlSession.selectOne("snsReply.get",snsReplyDto.getSnsReplySuperno());
			
			//그룹 번호등록 및 차수 1증가
			snsReplyDto.setSnsReplySuperno(reply.getSnsReplyNo());
			snsReplyDto.setSnsReplyGroupno(reply.getSnsReplyGroupno());
			snsReplyDto.setSnsReplyDepth(reply.getSnsReplyDepth()+1);
			
			//대댓글 등록
			sqlSession.insert("snsReply.reinsert", snsReplyDto);
		}
		//넘어온 객체에서 상위번호가 없다면 (일반 댓글)
		else {
			//그룹번호에 시퀀스번호를 저장
			snsReplyDto.setSnsReplyGroupno(sequence);
			sqlSession.insert("snsReply.insert", snsReplyDto);
		}
		
		
	}
	
	//시퀀스 번호 받는 기능
	@Override
	public int sequence() {
		
		return sqlSession.selectOne("snsReply.sequence");
	}
	
	//페이징 목록 기능
	@Override
	public List<SnsReplyListVO> listByPage(int startRow, int endRow, int snsNo) {
		
		Map<String, Object>param = new HashMap<>();
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		param.put("snsNo", snsNo);
		
		return sqlSession.selectList("snsReply.listByPage", param);
	}
	
	//댓글 삭제 기능
	@Override
	public boolean delete(int snsReplyNo) {
		
		int result = sqlSession.delete("snsReply.delete", snsReplyNo);
		
		return result > 0;
		
	}
	
	//댓글 갯수 확인하는 기능
	@Override
	public void replyCount(int snsNo) {
		
		log.debug("snsNo = {}", snsNo);
		int a = sqlSession.update("snsReply.replyCount", snsNo); 
		
		System.out.println(a);
	}
	
	//댓글 수정 기능
	@Override
	public void edit(SnsReplyDto snsReplyDto) {
		
		sqlSession.update("snsReply.edit", snsReplyDto);
		
	}
	
}
