package com.kh.zipggu.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.zipggu.repository.CertificationDao;
import com.kh.zipggu.repository.ItemFileDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ScheduleServiceImpl implements ScheduleService{

	@Autowired
	private CertificationDao certificationDao;

	@Autowired
	private ItemFileDao itemFileDao;
	
	@Scheduled(cron = "0 0 * * * *")//매 정각마다
	@Override
	public void execute() {
		log.debug("이메일 인증번호 DB 자동 삭제");
		certificationDao.clean();
		log.debug("item_file 사용하지 않는 이미지 삭제");
		itemFileDao.schedule();
	}

}
