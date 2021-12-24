package com.kh.zipggu.service;

import java.io.IOException;

import com.kh.zipggu.vo.MemberJoinVO;

public interface MemberService {
	void join(MemberJoinVO memberJoinVO) throws IllegalStateException, IOException;
}