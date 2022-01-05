package com.kh.zipggu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.zipggu.entity.CartDto;
import com.kh.zipggu.entity.CartOptionDto;
import com.kh.zipggu.entity.ItemOptionDto;
import com.kh.zipggu.repository.CartDao;
import com.kh.zipggu.repository.CartOptionDao;
import com.kh.zipggu.vo.CartListVO;
import com.kh.zipggu.vo.CartVO;
import com.kh.zipggu.vo.ItemOrderListVO;
import com.kh.zipggu.vo.ItemOrderVO;
import com.kh.zipggu.vo.OptionVO;

@Service
public class CartServiceImpl implements CartService{
	
	@Autowired
	private CartDao cartDao;
	@Autowired
	private CartOptionDao cartOptionDao;
	
	//카트 등록 기능
	@Override
	public void insert(CartVO cartVO) {
		
		//CartVO안에 OptionVO의 내용을 꺼내기위해서 반복문을 선언
		for(OptionVO list : cartVO.getOptionList()) {
			
			//cartOption 테이블에 저장하기 위해 시퀀스값을 먼저 받아야 한다
			int sequence = cartDao.getSequence();
			
			//cartDto 선언
			CartDto cartDto = new CartDto();
			
			//반복문으로 꺼낸 값들 cartDto에 저장하고 cartDao로 넘긴다
			cartDto.setCartNo(sequence);
			cartDto.setMemberNo(cartVO.getMemberNo());
			cartDto.setItemNo(cartVO.getItemNo());
			cartDto.setQuantity(list.getQuantity());
			cartDao.insert(cartDto);
			
			//OptionVO안에 또다른 List인 ItemOptionDto를 꺼내기 위해 반복문 선언 
			for(ItemOptionDto no : list.getNoList()) {
				
				//List에서 꺼낸값을 저장하기 위해 Dto선언하여 Dao로 전송한다
				CartOptionDto cartOptionDto = new CartOptionDto();
				cartOptionDto.setCartNo(sequence);
				cartOptionDto.setItemOptionNo(no.getItemOptionNo());
				cartOptionDao.insert(cartOptionDto);
			}
		}
	}
	
	
	//장바구니 목록 출력 기능
	@Override
	public List<CartListVO> list(int memberNo) {
		
		return cartDao.list(memberNo);
	}
	
	//장바구니에서 선택한 상품 결제페이지에서 출력하는 기능
	@Override
	public List<CartListVO> listByOrder(ItemOrderListVO itemOrderListVO) {
		
		//장바구니 페이지에서 변경된 수량을 수정한다.
		cartDao.updateQuantity(itemOrderListVO);
		
		//수량 변경되거나 변경되지 않은 내용 목록 출력
		return cartDao.listByOrder(itemOrderListVO);
	}

}
