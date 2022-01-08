package com.kh.zipggu.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.MemberDto;
import com.kh.zipggu.entity.MemberProfileDto;
import com.kh.zipggu.vo.MemberJoinVO;
import com.kh.zipggu.vo.MemberListVO;
import com.kh.zipggu.vo.MemberPageVO;
import com.kh.zipggu.vo.MemberUploadVO;

public interface MemberService {
	void join(MemberJoinVO memberJoinVO) throws IllegalStateException, IOException;
	
	public void upload(MemberUploadVO memberUploadVO, int memberNo) throws IllegalStateException, IOException;
	
	void edit(MemberDto memberDto, MultipartFile attach) throws IllegalStateException, IOException;	
	
	List<MemberListVO> VOlist (MemberListVO memberListVO) throws Exception;
	
	MemberPageVO memberPage(MemberPageVO memberPageVO) throws Exception;
	
}