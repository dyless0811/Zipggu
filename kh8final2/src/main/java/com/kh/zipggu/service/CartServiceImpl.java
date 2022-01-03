package com.kh.zipggu.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.zipggu.entity.CartDto;
import com.kh.zipggu.entity.CartOptionDto;
import com.kh.zipggu.entity.ItemOptionDto;
import com.kh.zipggu.repository.CartDao;
import com.kh.zipggu.repository.CartOptionDao;
import com.kh.zipggu.repository.ItemOptionDao;
import com.kh.zipggu.vo.CartVO;
import com.kh.zipggu.vo.OptionVO;

@Service
public class CartServiceImpl implements CartService{
	
	@Autowired
	private CartDao cartDao;
	@Autowired
	private CartOptionDao cartOptionDao;
	
	@Override
	public void insert(CartVO cartVO) {
		
		for(OptionVO list : cartVO.getOptionList()) {
			int sequence = cartDao.getSequence();
			CartDto cartDto = new CartDto();
			cartDto.setCartNo(sequence);
			cartDto.setMemberNo(cartVO.getMemberNo());
			cartDto.setItemNo(cartVO.getItemNo());
			
			cartDto.setQuantity(list.getQuantity());
			cartDao.insert(cartDto);
			
			for(ItemOptionDto no : list.getNoList()) {
				
				CartOptionDto cartOptionDto = new CartOptionDto();
				cartOptionDto.setCartNo(sequence);
				cartOptionDto.setItemOptionNo(no.getItemOptionNo());
				cartOptionDao.insert(cartOptionDto);
			}
		}
	}
}
