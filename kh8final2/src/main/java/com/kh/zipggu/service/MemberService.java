package com.kh.zipggu.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.vo.MemberJoinVO;
import com.kh.zipggu.vo.MemberUploadVO;

public interface MemberService {
	void join(MemberJoinVO memberJoinVO) throws IllegalStateException, IOException;
	
	public void upload(MemberUploadVO memberUploadVO, int memberNo) throws IllegalStateException, IOException;
	
//	void edit(MemberUploadVO memberUploadVO, MultipartFile attach) throws IllegalStateException, IOException;
}