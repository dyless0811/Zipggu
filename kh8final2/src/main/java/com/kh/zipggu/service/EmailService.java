package com.kh.zipggu.service;

import javax.mail.MessagingException;

public interface EmailService {
	//인증번호 전송 서비스
	void sendCertificationNumber(String to) throws MessagingException;
}