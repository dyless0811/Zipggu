package com.kh.zipggu.vo;

import java.util.Date;

import lombok.Data;

@Data
public class FollowVO {
	private int followNo; //팔로우번호
	private int followerUser; //팔로우 요청한 회원번호
	private int followingUser; //팔로우 당한 회원번호
	private Date followWhen; //팔로우 요청 날짜
	
	private String memberNickname; //회원 닉네임
	private String memberIntroduce; //회원 한줄소개
	
	private int memberProfileNo; //회원 프로필 번호
	
}
