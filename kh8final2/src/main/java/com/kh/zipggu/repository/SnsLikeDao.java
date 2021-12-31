package com.kh.zipggu.repository;

import com.kh.zipggu.entity.SnsLikeDto;

public interface SnsLikeDao {

	void insert(int snsNo, int memberNo);

	void delete(int snsNo, int memberNo);

	SnsLikeDto get(int snsNo, int memberNo);

}
