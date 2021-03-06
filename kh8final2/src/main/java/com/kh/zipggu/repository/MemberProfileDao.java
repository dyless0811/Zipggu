package com.kh.zipggu.repository;
import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.entity.MemberProfileDto;



public interface MemberProfileDao {
	void save(MemberProfileDto memberProfileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;
	MemberProfileDto get(int memberProfileNo);
	MemberProfileDto noGet(int memberNo);
	byte[] load(int memberNo) throws IOException;
	
	void delete(int memberNo);
	
	void edit(MemberProfileDto memberProfileDto);
	
	void upload(MemberProfileDto memberProfileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;

}
