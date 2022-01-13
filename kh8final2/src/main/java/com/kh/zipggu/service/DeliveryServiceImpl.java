package com.kh.zipggu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.zipggu.entity.DeliveryDto;
import com.kh.zipggu.repository.DeliveryDao;

@Service
public class DeliveryServiceImpl implements DeliveryService {

	@Autowired
	private DeliveryDao deliveryDao;
	
	@Override
	public int insert(DeliveryDto deliveryDto) {
		int deliveryNo = deliveryDao.getSeq();
		deliveryDto.setDeliveryNo(deliveryNo);
		deliveryDao.insert(deliveryDto);
		return deliveryNo;
	}

	@Override
	public DeliveryDto get(int deliveryNo) {
		return deliveryDao.get(deliveryNo);
	}

	@Override
	public List<DeliveryDto> getListByMemberNo(int memberNo) {
		return deliveryDao.getListByMemberNo(memberNo);
	}

	@Override
	public void update(DeliveryDto deliveryDto) {
		deliveryDao.update(deliveryDto);	
	}

	@Override
	public void delete(int deliveryNo) {
		deliveryDao.delete(deliveryNo);
	}

}
