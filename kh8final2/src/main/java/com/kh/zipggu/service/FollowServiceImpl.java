package com.kh.zipggu.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.zipggu.repository.FollowDao;
import com.kh.zipggu.vo.FollowVO;

@Service
public class FollowServiceImpl implements FollowService{

	@Autowired
	FollowDao followDao;
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void follow(FollowVO followVO) {
		
		int sequence = sqlSession.selectOne("follow.seq");
		
		followVO.setFollowNo(sequence);
		followVO.setFollowerUser(followVO.getFollowerUser());
		followVO.setFollowingUser(followVO.getFollowingUser());
		
		followDao.follow(followVO);
		
	}

	@Override
	public void unfollow(FollowVO followVO) {
		followDao.unfollow(followVO);
	}

	@Override
	public int isFollow(FollowVO followVO) {
		return followDao.isFollow(followVO);
	}

	@Override
	public List<FollowVO> followerList(int memberNo) {
		return followDao.followerList(memberNo);
	}

	@Override
	public List<FollowVO> followingList(int memberNo) {
		return followDao.followingList(memberNo);
	}

	@Override
	public int followerCount(int memberNo) {
		return followDao.followerCount(memberNo);
	}

	@Override
	public int followingCount(int memberNo) {
		return followDao.followingCount(memberNo);
	}


//	@Override
//	public List<FollowVO> followerF4f(int memberNo) throws Exception {
//		return followDao.followerF4f(memberNo);
//	}
//
//	@Override
//	public List<FollowVO> followingF4f(int memberNo) throws Exception {
//		return followDao.followingF4f(memberNo);
//	}

	@Override
	public List<FollowVO> followerF4f(int loginNo, int memberNo) throws Exception {
		return followDao.followerF4f(loginNo, memberNo);
	}

	@Override
	public List<FollowVO> followingF4f(int loginNo, int memberNo) throws Exception {
		return followDao.followingF4f(loginNo, memberNo);
	}
	
	

}
