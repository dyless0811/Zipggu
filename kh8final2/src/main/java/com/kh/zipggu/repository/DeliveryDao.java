package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.DeliveryDto;

public interface DeliveryDao {

	void insert(DeliveryDto deliveryDto);

	int getSeq();

	DeliveryDto get(int deliveryNo);

	List<DeliveryDto> getListByMemberNo(int memberNo);

	void update(DeliveryDto deliveryDto);

	void delete(int deliveryNo);


}
