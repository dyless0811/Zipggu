package com.kh.zipggu.service;

import java.util.List;

import com.kh.zipggu.entity.DeliveryDto;

public interface DeliveryService {

	int insert(DeliveryDto deliveryDto);

	DeliveryDto get(int deliveryNo);

	List<DeliveryDto> getListByMemberNo(int memberNo);

	void update(DeliveryDto deliveryDto);

	void delete(int deliveryNo);

}
