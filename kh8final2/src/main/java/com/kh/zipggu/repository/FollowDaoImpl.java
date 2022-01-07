package com.kh.zipggu.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.vo.FollowVO;

@Repository
public class FollowDaoImpl implements FollowDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void follow(FollowVO followVO) {
		sqlSession.insert("follow.follow", followVO);
	}

	@Override
	public void unfollow(FollowVO followVO) {
		sqlSession.delete("follow.unfollow", followVO);
	}

	@Override
	public int isFollow(FollowVO followVO) {
	return sqlSession.selectOne("follow.isFollow", followVO);
	}

	@Override
	public List<FollowVO> followerList(int memberNo) {
		return sqlSession.selectList("follow.followerList", memberNo);
	}

	@Override
	public List<FollowVO> followingList(int memberNo) {
		return sqlSession.selectList("follow.followingList", memberNo);
	}

	@Override
	public void deleteAllFollow(int follower) {
	
	}

	@Override
	public int followerCount(int memberNo) {
		return sqlSession.selectOne("follow.followerCount", memberNo);
	}

	@Override
	public int followingCount(int memberNo) {
		return sqlSession.selectOne("follow.followingCount", memberNo);
	}


//	@Override
//	public List<FollowVO> followerF4f(int memberNo) {
//		return sqlSession.selectList("follow.followerF4f", memberNo);
//	}

//	@Override
//	public List<FollowVO> followingF4f(int memberNo) {
//		return sqlSession.selectList("follow.followingF4f", memberNo);
//	}

	@Override
	public List<FollowVO> followerF4f(int loginNo, int memberNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("loginNo", loginNo);
		param.put("memberNo", memberNo);
		return sqlSession.selectList("follow.followerF4f", param);
	}

	@Override
	public List<FollowVO> followingF4f(int loginNo, int memberNo) {
		Map<String, Object> param = new HashMap<>();
		param.put("loginNo", loginNo);
		param.put("memberNo", memberNo);			
		return sqlSession.selectList("follow.followingF4f", param);
	}


}
