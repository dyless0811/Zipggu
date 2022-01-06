package com.kh.zipggu.service;

import java.net.URISyntaxException;

import com.kh.zipggu.vo.kakaopay.KakaoPayApproveRequestVO;
import com.kh.zipggu.vo.kakaopay.KakaoPayApproveResponseVO;
import com.kh.zipggu.vo.kakaopay.KakaoPayCancelResponseVO;
import com.kh.zipggu.vo.kakaopay.KakaoPayReadyRequestVO;
import com.kh.zipggu.vo.kakaopay.KakaoPayReadyResponseVO;
import com.kh.zipggu.vo.kakaopay.KakaoPaySearchResponseVO;

public interface KakaoPayService {
	KakaoPayReadyResponseVO ready(KakaoPayReadyRequestVO requestVO) throws URISyntaxException;
	KakaoPayApproveResponseVO approve(KakaoPayApproveRequestVO requestVO) throws URISyntaxException;
	KakaoPaySearchResponseVO search(String tid) throws URISyntaxException;
	KakaoPayCancelResponseVO cancel(String tid, int amount)  throws URISyntaxException;
}
