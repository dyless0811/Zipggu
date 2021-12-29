package com.kh.zipggu.repository;
import java.io.IOException;
import org.springframework.web.multipart.MultipartFile;
import com.kh.zipggu.entity.MemberProfileDto;

public interface MemberProfileDao {
	void save(MemberProfileDto memberProfileDto, MultipartFile multipartFile) throws IllegalStateException, IOException;
	MemberProfileDto get(int memberProfileNo);
	MemberProfileDto noGet(int memberNo);
	byte[] load(int memberProfileNo) throws IOException;
}
