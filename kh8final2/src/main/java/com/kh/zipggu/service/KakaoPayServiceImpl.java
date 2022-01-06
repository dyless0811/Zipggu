package com.kh.zipggu.service;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.kh.zipggu.vo.kakaopay.KakaoPayApproveRequestVO;
import com.kh.zipggu.vo.kakaopay.KakaoPayApproveResponseVO;
import com.kh.zipggu.vo.kakaopay.KakaoPayCancelResponseVO;
import com.kh.zipggu.vo.kakaopay.KakaoPayReadyRequestVO;
import com.kh.zipggu.vo.kakaopay.KakaoPayReadyResponseVO;
import com.kh.zipggu.vo.kakaopay.KakaoPaySearchResponseVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class KakaoPayServiceImpl implements KakaoPayService {
	@Value("${kakaopay.authorization}")
	public static String Authorization;
	
	@Value("${kakaopay.contentType}")
	public static String ContentType;
	
	@Override
	public KakaoPayReadyResponseVO ready(KakaoPayReadyRequestVO requestVO) throws URISyntaxException {
		
		RestTemplate template = new RestTemplate();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", Authorization);
		headers.add("Content-type", ContentType);

		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TC0ONETIME");
		body.add("partner_order_id", requestVO.getPartner_order_id());
		body.add("partner_user_id", requestVO.getPartner_user_id());
		body.add("item_name", requestVO.getItem_name());
		body.add("quantity", requestVO.getQuantityString());
		body.add("total_amount", requestVO.getTotal_amountString());
		body.add("tax_free_amount", "0");
		String ContextPath = "http://localhost:8080/zipggu";
		body.add("approval_url", ContextPath+"/payment/success");
		body.add("fail_url", ContextPath+"/payment/fail");
		body.add("cancel_url", ContextPath+"/payment/cancel");

		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);

		URI uri = new URI("https://kapi.kakao.com/v1/payment/ready");

		KakaoPayReadyResponseVO responseVO = template.postForObject(uri, entity, KakaoPayReadyResponseVO.class);
		
		return responseVO;
	}

	@Override
	public KakaoPayApproveResponseVO approve(KakaoPayApproveRequestVO requestVO) throws URISyntaxException {


		RestTemplate template = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", Authorization);
		headers.add("Content-type", ContentType);

		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TC0ONETIME");
		body.add("tid", requestVO.getTid());
		body.add("partner_order_id", requestVO.getPartner_order_id());
		body.add("partner_user_id", requestVO.getPartner_user_id());
		body.add("pg_token", requestVO.getPg_token());

		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body,headers);

		URI uri = new URI("https://kapi.kakao.com/v1/payment/approve");

		KakaoPayApproveResponseVO responseVO = template.postForObject(uri, entity, KakaoPayApproveResponseVO.class);
		log.debug("responseVO = {}", responseVO);
		return responseVO;
	}

	@Override
	public KakaoPaySearchResponseVO search(String tid) throws URISyntaxException {

		RestTemplate template = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", Authorization);
		headers.add("Content-type", ContentType);

		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TC0ONETIME");
		body.add("tid", tid);

		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body,headers);

		URI uri = new URI("https://kapi.kakao.com/v1/payment/order");

		KakaoPaySearchResponseVO responseVO = template.postForObject(uri, entity, KakaoPaySearchResponseVO.class);
		
		return responseVO;
	}

	@Override
	public KakaoPayCancelResponseVO cancel(String tid, int amount) throws URISyntaxException {
		RestTemplate template = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", Authorization);
		headers.add("Content-type", ContentType);

		MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
		body.add("cid", "TC0ONETIME");
		body.add("tid", tid);
		body.add("cancel_amount", String.valueOf(amount));
		body.add("cancel_tax_free_amount", "0");

		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body,headers);

		URI uri = new URI("https://kapi.kakao.com/v1/payment/cancel");

		KakaoPayCancelResponseVO responseVO = template.postForObject(uri, entity, KakaoPayCancelResponseVO.class);
		
		return responseVO;
	}
}
