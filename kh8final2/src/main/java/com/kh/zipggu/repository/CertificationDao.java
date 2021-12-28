package com.kh.zipggu.repository;


import com.kh.zipggu.entity.CertificationDto;

public interface CertificationDao {
	void insert(CertificationDto certificationDto);
	boolean check(CertificationDto certificationDto);
	void clean();
	
	
	CertificationDto get(String memberEmail, String serial);
}
