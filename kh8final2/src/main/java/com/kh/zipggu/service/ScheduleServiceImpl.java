package com.kh.zipggu.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.zipggu.repository.CertificationDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ScheduleServiceImpl implements ScheduleService{

	@Autowired
	private CertificationDao certificationDao;

	@Scheduled(cron = "0 0 * * * *")//매 정각마다
	@Override
	public void execute() {
		log.debug("이메일 인증번호 DB 자동 삭제");
		certificationDao.clean();
	}

}
