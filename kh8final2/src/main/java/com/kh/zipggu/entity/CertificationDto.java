package com.kh.zipggu.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class CertificationDto {
	private String email;
	private String serial;
	private Date when;
}
