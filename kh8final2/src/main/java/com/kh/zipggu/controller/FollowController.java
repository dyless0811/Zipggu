package com.kh.zipggu.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.zipggu.entity.MemberDto;
import com.kh.zipggu.entity.MemberProfileDto;
import com.kh.zipggu.repository.MemberDao;
import com.kh.zipggu.repository.MemberProfileDao;
import com.kh.zipggu.service.FollowService;
import com.kh.zipggu.service.MemberService;
import com.kh.zipggu.vo.FollowVO;
import com.kh.zipggu.vo.MemberListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/follow")
public class FollowController {

	@Autowired
	private FollowService followService;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private MemberProfileDao memberProfileDao;	

	//팔로워 목록 페이지
	@RequestMapping("/followerList")
	public String followerList(@RequestParam int memberNo ,HttpSession session, Model model) {
	
		MemberDto memberDto = memberDao.noGet(memberNo);
		MemberProfileDto memberProfileDto = memberProfileDao.noGet(memberNo);

		// 회원 유저 번호 가져오기
		log.info("현재 페이지 회원 번호 : " + memberNo);
		
		// 팔로우 객체 생성
		FollowVO follow = new FollowVO();
		follow.setFollowingUser(memberNo); // 상대 유저 회원 번호 
		
		// 팔로워 리스트
		List<FollowVO> followerList = followService.followerList(memberNo);
		log.info("현재 페이지 회원 리스트 : " + followerList);
		
		// 팔로잉리스트
		List<FollowVO> followingList = followService.followingList(memberNo);
		log.info("현재 페이지 회원 번호 리스트 : " + followingList);		

		// 팔로워 카운트
		int followerCount = followService.followerCount(memberNo);
		log.info("팔로워 카운트 : " + followerCount);		
		
		// 팔로잉 카운트
		int followingCount = followService.followingCount(memberNo);
		log.info("팔로잉 카운트 : " + followingCount);		
		
		model.addAttribute("followerCount", followerCount);
		model.addAttribute("followingCount", followingCount);			
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("memberProfileDto", memberProfileDto);
		model.addAttribute("followerList", followerList);
		model.addAttribute("followingList", followingList);
		
		return "follow/followerList";
		
	}	
	
	//팔로잉 목록 페이지
	@RequestMapping("/followingList")
	public String followingList(@RequestParam int memberNo ,HttpSession session, Model model) {
	
	MemberDto memberDto = memberDao.noGet(memberNo);
	MemberProfileDto memberProfileDto = memberProfileDao.noGet(memberNo);

	// 팔로우 객체 생성
	FollowVO follow = new FollowVO();
	follow.setFollowerUser(memberNo); // 선택 회원번호
	
	// 팔로워 리스트
	List<FollowVO> followerList = followService.followerList(memberNo);
	log.info("현재 페이지 회원 리스트 : " + followerList);
	
	// 팔로워 카운트
	int followerCount = followService.followerCount(memberNo);
	log.info("팔로워 카운트 : " + followerCount);		
	
	// 팔로잉 카운트
	int followingCount = followService.followingCount(memberNo);
	log.info("팔로잉 카운트 : " + followingCount);		
	
	model.addAttribute("followerCount", followerCount);
	model.addAttribute("followingCount", followingCount);		
	model.addAttribute("memberDto", memberDto);
	model.addAttribute("memberProfileDto", memberProfileDto);
	model.addAttribute("followerList", followerList);
	
	return "follow/followingList";
}	
}
