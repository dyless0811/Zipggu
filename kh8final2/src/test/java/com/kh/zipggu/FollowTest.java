package com.kh.zipggu;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.zipggu.repository.FollowDao;
import com.kh.zipggu.vo.FollowVO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@Slf4j
@WebAppConfiguration
public class FollowTest {

	
	@Autowired
	private FollowDao followDao;
	
//	@Test
	public void followTest() {
		FollowVO followVO = new FollowVO();
		
		followVO.setFollowNo(4);
		followVO.setFollowerUser(4);
		followVO.setFollowingUser(5);
		
		followDao.follow(followVO);
		
		log.debug("followVO = {}", followVO);
	}
	
//	@Test
	public void followTest2() {
		FollowVO followVO = new FollowVO();
		
		followVO.setFollowerUser(166);
		followVO.setFollowingUser(165);
		
		int result = followDao.isFollow(followVO);
		
		System.out.println(result);
		
		if(result == 0 ) {
			System.out.println("팔로우 X");
		} else {
			System.out.println("팔로우 O");
		}
		
	}
	
//	@Test
	public void followTest3() {

		List<FollowVO> follower = followDao.followerList(166);
		
		System.out.println(follower);

	}		
	
	@Test
	public void followTest4() {
		
		FollowVO followVO = new FollowVO();
		
		followVO.setFollowerUser(1);
		followVO.setFollowingUser(166);
		
		int result = followDao.isFollow(followVO);
		
		System.out.println("팔로우  : " + result);
		
		if(result == 0) {
			System.out.println("팔로우 체크 X");
		} else {
			System.out.println("팔로우 체크 O");
		}
		
		
	}		
	
}
