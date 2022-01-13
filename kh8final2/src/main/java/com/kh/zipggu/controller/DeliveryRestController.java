package com.kh.zipggu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.zipggu.entity.DeliveryDto;
import com.kh.zipggu.service.DeliveryService;


@RestController
@RequestMapping("/delivery/data")
public class DeliveryRestController {

	@Autowired
	private DeliveryService deliveryService;
	
	@PostMapping("")
	public int insert(@ModelAttribute DeliveryDto deliveryDto) {
		return deliveryService.insert(deliveryDto);
	}
	
	@GetMapping("")
	public DeliveryDto get(@RequestParam int deliveryNo) {
		return deliveryService.get(deliveryNo);
	}
	
	@GetMapping("/listByMemberNo")
	public List<DeliveryDto> getListByMemberNo(@RequestParam int memberNo) {
		return deliveryService.getListByMemberNo(memberNo);
	}
	
	@PostMapping("/update")
	public int update(DeliveryDto deliveryDto) {
		deliveryService.update(deliveryDto);
		return deliveryDto.getDeliveryNo();
	}
	
	@PostMapping("/delete")
	public void delete(@RequestParam int deliveryNo) {
		deliveryService.delete(deliveryNo);
	}
}
