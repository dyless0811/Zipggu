package com.kh.zipggu.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * 	회원 가입 정보를 받기 위한 VO
 *	회원정보(MemberDto)와 프로필 이미지(attach)를 저장한다
 */
@Data
public class MemberJoinVO {
	private int memberNo;
	private String memberEmail;
	private String memberPw;
	private String memberNickname;
	private MultipartFile attach;
}
