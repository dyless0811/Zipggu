package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.vo.FollowVO;

public interface FollowDao {

	//팔로우 하기
	void follow(FollowVO followVO);
	
	//언팔로우 하기
	void unfollow(FollowVO followVO);
	
	//팔로우 유무
	int isFollow(FollowVO followVO);
	
	//팔로우 리스트 조회
	List<FollowVO> followerList (int memberNo);
	
	//팔로워 리스트 조회
	List<FollowVO> followingList (int memberNo);
	
	//탈퇴시 팔로우 삭제
	void deleteAllFollow(int follower);
	
	//팔로워 카운트
	int followerCount(int memberNo);
	
	//팔로잉 카운트
	int followingCount(int memberNo);	
	
	//팔로워 페이지 맞팔유무
//	List<FollowVO> followerF4f (int memberNo);	
	
	//팔로잉 페이지 맞팔유무
//	List<FollowVO> followingF4f (int memberNo);	
	
	//팔로워 페이지 맞팔유무
	List<FollowVO> followerF4f (int loginNo, int memberNo);	
	
	//팔로잉 페이지 맞팔유무
	List<FollowVO> followingF4f (int loginNo, int memberNo);	
	
	
	
}
