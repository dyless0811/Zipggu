package com.kh.zipggu.repository;

import java.util.List;
import java.util.Map;

import com.kh.zipggu.entity.SnsDto;
import com.kh.zipggu.vo.SnsListVO;

public interface SnsDao {

	//등록 기능
	void write(SnsDto snsDto);

	//시퀀스 먼저 받는 기능
	int sequence();

	//단일조회 기능(상세페이지)
	SnsListVO get(int snsNo);

	//목록 조회
	List<SnsDto> list();

	//게시글 수정
	void edit(SnsDto snsDto);

	//게시글 삭제
	void delete(int snsNo);

	//페이징 목록조회
	//List<SnsListVO> listByPage(int startRow, int endRow);

	//조회수 증가
	void readUp(int snsNo, int memberNo);

	//페이징 목록조회
	List<SnsListVO> listByPage(Map<String, Object> param);
	
	//내가 팔로우 한사람들 글 목록
	List<SnsListVO> followerList(Map<String, Object> param);

	//내가쓴 게시물 목록
	List<SnsDto> myList(Map<String, Object> param);

	//SNS 전체 목록 기능 (내가 좋아요한 게시글 목록)
	List<SnsListVO> myLikeList(Map<String, Object> param);

	
	
}
