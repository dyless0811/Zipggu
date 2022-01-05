package com.kh.zipggu.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import com.kh.zipggu.service.FollowService;
import com.kh.zipggu.vo.FollowVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/follow")
public class FollowRestController {

	@Autowired
	private FollowService followService;

	// 팔로우 요청
	@PostMapping("/follow")
	public void follow(int memberNo, HttpSession session, @ModelAttribute FollowVO followVO) throws Exception {

		log.info("회원 번호 : " + memberNo + " [ 팔로우 요청 ]");

		int followerUser = (int) session.getAttribute("loginNo");
		int followingUser = memberNo;

		followVO.setFollowerUser(followerUser);
		followVO.setFollowingUser(followingUser);
		
		int followCheck = followService.isFollow(followVO);
		
		if (followCheck != 0) {
			
			log.info("회원 번호 : " + memberNo + " [ 이미  팔로우 입니다 ]");
		
		} else {
			
			followService.follow(followVO);
			
			log.info("회원 번호 : " + memberNo + " [ 팔로우 완료 ]");
			
		}

	}

	// 언팔로우 요청
	@PostMapping("/unfollow")
	public void unfollow(int memberNo, HttpSession session, @ModelAttribute FollowVO followVO) throws Exception {

		log.info("회원 번호 : " + memberNo + " [ 언팔로우 요청 ]");

		int followerUser = (int) session.getAttribute("loginNo");
		int followingUser = memberNo;

		followVO.setFollowerUser(followerUser);
		followVO.setFollowingUser(followingUser);
		
		int followCheck = followService.isFollow(followVO);

		if (followCheck == 0) {

			log.info("회원 번호 : " + memberNo + " [ 팔로우중이 아닙니다 ]");

		} else {

			followService.unfollow(followVO);

			log.info("회원 번호 : " + memberNo + " [ 언팔로우 완료 ]");
			
		}

	}

}
