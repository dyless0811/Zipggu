package com.kh.zipggu.repository;

import com.kh.zipggu.entity.SnsLikeDto;

public interface SnsLikeDao {

	//좋아요 추가 기능
	void insert(int snsNo, int memberNo);

	//좋아요 삭제 기능
	void delete(int snsNo, int memberNo);

	//좋아요 개수 출력 기능
	SnsLikeDto get(int snsNo, int memberNo);

}
