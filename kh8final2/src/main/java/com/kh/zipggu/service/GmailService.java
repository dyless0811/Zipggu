package com.kh.zipggu.service;

import java.text.DecimalFormat;
import java.text.Format;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.kh.zipggu.entity.CertificationDto;
import com.kh.zipggu.repository.CertificationDao;
import com.kh.zipggu.util.RandomUtil;

@Service
public class GmailService implements EmailService {

	@Autowired
	private JavaMailSender sender;

	@Autowired
	private RandomUtil randomUtil;

	@Autowired
	private CertificationDao certificationDao;

	@Override
	public void sendCertificationNumber(String to) throws MessagingException {
		//랜덤번호 생성 부분
		String number = randomUtil.generateRandomNumber(6);
		
		MimeMessage message = sender.createMimeMessage();
		
		//실제 이메일 발송 부분
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		helper.setTo(to);
		helper.setSubject("[집꾸] 인증코드 안내");
		helper.setText("<h1>집꾸</h1> <br/><br/>"+
	    		"<h3>인증코드를 확인해주세요.</h3>"+
				"<div align='center' style='border:1px solid black; font-family:verdana; width:120px;'>"+ 		
				"<h1 style='color:blue;'>"+number+"</h1>"+ 
	    		"</div>"+
	    		"<br/><br/><br/>이메일 인증 절차에 따라 이메일 인증코드를 발급해드립니다."+ 
	    		"<br/>인증코드는 이메일 발송 시점으로부터 3분동안 유효합니다."			
	    		, true);


		sender.send(message);

		//데이터베이스 등록 부분
		CertificationDto certificationDto = new CertificationDto();
		certificationDto.setEmail(to);
		certificationDto.setSerial(number);

		certificationDao.insert(certificationDto);
		
	}

}