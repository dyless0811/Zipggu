package com.kh.zipggu.controller;

import java.net.URISyntaxException;
import java.text.DecimalFormat;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.zipggu.entity.OrderDetailDto;
import com.kh.zipggu.entity.OrderOptionDto;
import com.kh.zipggu.entity.OrdersDto;
import com.kh.zipggu.entity.ItemDto;
import com.kh.zipggu.entity.ItemOptionDto;
import com.kh.zipggu.repository.OrdersDao;
import com.kh.zipggu.repository.OrderDetailDao;
import com.kh.zipggu.repository.OrderOptionDao;
import com.kh.zipggu.repository.ItemDao;
import com.kh.zipggu.service.KakaoPayService;
import com.kh.zipggu.vo.kakaopay.KakaoPayApproveRequestVO;
import com.kh.zipggu.vo.kakaopay.KakaoPayApproveResponseVO;
import com.kh.zipggu.vo.kakaopay.KakaoPayCancelResponseVO;
import com.kh.zipggu.vo.kakaopay.KakaoPayReadyRequestVO;
import com.kh.zipggu.vo.kakaopay.KakaoPayReadyResponseVO;
import com.kh.zipggu.repository.CartDao;
import com.kh.zipggu.service.CartService;
import com.kh.zipggu.vo.CartListVO;
import com.kh.zipggu.vo.ItemOrderListVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/payment")
public class PaymentController {
	
	@Autowired
	private CartDao cartDao;

	@Autowired
	private OrdersDao ordersDao;

	@Autowired
	private OrderDetailDao orderDetailDao;
	
	@Autowired
	private OrderOptionDao orderOptionDao;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private KakaoPayService kakaoPayService;
	
	//장바구니 페이지 또는 상품상세 페이지에서 저장된 상품 목록 찍어주는 기능
	@RequestMapping("/list")
	public String list(Model model, @ModelAttribute ItemOrderListVO itemOrderListVO, @RequestParam(required = false, defaultValue = "0") int shipping) {
		log.debug("=============================================");
		log.debug("페이먼트 = {}", itemOrderListVO);
		log.debug("=============================================");
		//log.debug("ItemOrderListVO = {}", itemOrderListVO);
		
		//페이지에서 리스트로 보내진 quantity, cartNo가 있는 VO로 조회 시작
		List<CartListVO> cartListVOList = cartService.listByOrder(itemOrderListVO);
		log.debug("==============================================");
		log.debug("카트리스트브이오 = {}", cartListVOList);
		log.debug("==============================================");
		int totalPrice = 0;
		for (CartListVO cartListVO : cartListVOList) {
			totalPrice += cartListVO.getSumPrice();
		}
		//System.out.println("---------------------------------"+list);
		DecimalFormat f = new DecimalFormat("###,###");
		//조회된 내용으로 목록 출력
		model.addAttribute("orderList", cartListVOList);
		model.addAttribute("totalPrice", f.format(totalPrice));
		model.addAttribute("shipping", f.format(shipping));
		model.addAttribute("totalAmount", f.format(totalPrice+shipping));
		return "payment/list";
	}
	
	@PostMapping("/confirm")
	public String confirm(@ModelAttribute ItemOrderListVO itemOrderListVO, @ModelAttribute OrdersDto ordersDto , HttpSession session) throws URISyntaxException {
		log.debug("============================{}", itemOrderListVO);
		log.debug("============================{}", ordersDto);
		List<CartListVO> cartListVOList = cartService.listByOrder(itemOrderListVO);
		log.debug("============================{}", cartListVOList.get(0).getMemberNo());
		
		String item_name = cartListVOList.get(0).getItemName();
		if(cartListVOList.size() > 1)
			item_name += " 외 " + (cartListVOList.size()-1) + "건";
		int total_amount = 0;
		for (CartListVO cartListVO : cartListVOList) {
			total_amount += cartListVO.getSumPrice();
		}
		KakaoPayReadyRequestVO requestVO = new KakaoPayReadyRequestVO();
		requestVO.setPartner_order_id(String.valueOf(ordersDao.sequence()));
		requestVO.setPartner_user_id(String.valueOf(cartListVOList.get(0).getMemberNo()));
		requestVO.setItem_name(item_name);
		requestVO.setQuantity(1);
		requestVO.setTotal_amount(total_amount);
		
		KakaoPayReadyResponseVO responseVO = kakaoPayService.ready(requestVO);
		
		session.setAttribute("tid", responseVO.getTid());
		session.setAttribute("partner_order_id", requestVO.getPartner_order_id());
		session.setAttribute("partner_user_id", requestVO.getPartner_user_id());
		session.setAttribute("orderList", cartListVOList);
		session.setAttribute("ordersDto", ordersDto);

		return "redirect:"+responseVO.getNext_redirect_pc_url();
		
	}

	
//	
//	@Autowired
//	private ItemDao itemDao;
//	
//	
//	
//	@PostMapping("/list")
//	public String confirm2(@RequestParam List<Integer> no, HttpSession session) throws URISyntaxException {
//		List<itemDto> list = productDao.search(no);
//		
//		String item_name = list.get(0).getName();
//		if(list.size() > 1)
//			item_name += " 외 " + (list.size()-1) + "건";
//		int total_amount = 0;
//		for (ProductDto productDto : list) {
//			total_amount += productDto.getPrice();
//		}
//		KakaoPayReadyRequestVO requestVO = new KakaoPayReadyRequestVO();
//		requestVO.setPartner_order_id(String.valueOf(ordersDao.sequence()));
//		requestVO.setPartner_user_id(UUID.randomUUID().toString());
//		requestVO.setItem_name(item_name);
//		requestVO.setQuantity(1);
//		requestVO.setTotal_amount(total_amount);
//		
//		KakaoPayReadyResponseVO responseVO = kakaoPayService.ready(requestVO);
//		
//		session.setAttribute("tid", responseVO.getTid());
//		session.setAttribute("partner_order_id", requestVO.getPartner_order_id());
//		session.setAttribute("partner_user_id", requestVO.getPartner_user_id());
//		session.setAttribute("list", list);
//		
//		return "redirect:"+responseVO.getNext_redirect_pc_url();
//		
//	}
//	
	@GetMapping("/success")
	public String success(@RequestParam String pg_token, HttpSession session) throws URISyntaxException {
		String tid = (String) session.getAttribute("tid");
		session.removeAttribute("tid");
		String partner_order_id = (String) session.getAttribute("partner_order_id");
		session.removeAttribute("partner_order_id");
		String partner_user_id = (String) session.getAttribute("partner_user_id");
		session.removeAttribute("partner_user_id");
		List<CartListVO> cartListVOList = (List<CartListVO>) session.getAttribute("orderList");
		session.removeAttribute("orderList");
		OrdersDto ordersDto = (OrdersDto) session.getAttribute("ordersDto");
		session.removeAttribute("ordersDto");

		
		KakaoPayApproveRequestVO requestVO = new KakaoPayApproveRequestVO();
		requestVO.setTid(tid);
		requestVO.setPartner_order_id(partner_order_id);
		requestVO.setPartner_user_id(partner_user_id);
		requestVO.setPg_token(pg_token);
		
		KakaoPayApproveResponseVO responseVO = kakaoPayService.approve(requestVO);
		ordersDto.setOrderNo(Integer.parseInt(responseVO.getPartner_order_id()));
		ordersDto.setMemberNo(Integer.parseInt(responseVO.getPartner_user_id()));
		ordersDto.setTid(responseVO.getTid());
		ordersDto.setOrderName(responseVO.getItem_name());
		ordersDto.setTotalAmount(responseVO.getAmount().getTotal());
		ordersDao.insert(ordersDto);
		
		for (CartListVO cartListVO : cartListVOList) {
			OrderDetailDto orderDetailDto = new OrderDetailDto();
			orderDetailDto.setOrderDetailNo(orderDetailDao.sequence());
			orderDetailDto.setOrderNo(ordersDto.getOrderNo());
			orderDetailDto.setItemNo(cartListVO.getItemNo());
			orderDetailDto.setOrderItemName(cartListVO.getItemName());
			orderDetailDto.setOrderQuantity(cartListVO.getQuantity());
			orderDetailDto.setOrderItemPrice(cartListVO.getSumPrice());
			
			orderDetailDao.insert(orderDetailDto);
			log.debug("================================== 옵션리스트 왜 망함?{}", cartListVO.getOptionList());
			for (ItemOptionDto optionList : cartListVO.getOptionList()) {
				OrderOptionDto orderOptionDto = new OrderOptionDto();
				orderOptionDto.setItemOptionNo(optionList.getItemOptionNo());
				orderOptionDto.setOrderDetailNo(orderDetailDto.getOrderDetailNo());
				log.debug("================================= 오더옵션디티오 {}", orderOptionDto);
				orderOptionDao.insert(orderOptionDto);
			}
			
			cartDao.delete(cartListVO.getCartNo());
		}
		
		return "redirect:success_result";
	}
	
	@GetMapping("/success_result")
	public String success_result() {
		return "payment/success_result";
	}
//	
//	@GetMapping("/history")
//	public String history(Model model) {
//		model.addAttribute("list", buyDao.list());
//		return "pay/history";
//	}
//	
//	@GetMapping("/history_detail")
//	public String historyDetail(@RequestParam int no, Model model) throws URISyntaxException {
//		BuyDto buyDto = buyDao.get(no);
//		model.addAttribute("buyDto", buyDto);
//		model.addAttribute("buyDetailList", buyDetailDao.list(no));
//		model.addAttribute("responseVO", kakaoPayService.search(buyDto.getTid()));
//		
//		return "pay/history_detail";
//	}
//	
//	@GetMapping("cancel_all")
//	public String cancelAll(@RequestParam int no) throws URISyntaxException {
//		BuyDto buyDto = buyDao.get(no);
//		if(buyDto.isAllCanceled()) {
//			throw new IllegalArgumentException("취소가 불가능한 항목입니다");
//		}
//		
//		int amount = buyDetailDao.getCancelAvailableAmount(no);
//		
//		KakaoPayCancelResponseVO responseVO = kakaoPayService.cancel(buyDto.getTid(), amount);
//		
//		buyDetailDao.cancelAll(no);
//		buyDao.refresh(no);
//		
//		return "redirect:history_detail?no="+no;
//	}
//	
//	@GetMapping("cancel_part")
//	public String cancelPart(@RequestParam int buyNo, @RequestParam int productNo) throws URISyntaxException {
//		BuyDetailDto buyDetailDto = buyDetailDao.get(buyNo, productNo);
//		
//			if(!buyDetailDto.isCancelAvailable()) {
//				throw new IllegalArgumentException("취소가 불가능한 항목입니다");
//			}
//			BuyDto buyDto = buyDao.get(buyNo);
//			KakaoPayCancelResponseVO responseVO = kakaoPayService.cancel(buyDto.getTid(), buyDetailDto.getPrice());
//			
//			buyDetailDao.cancel(buyNo, productNo);
//			buyDao.refresh(buyNo);
//			
//			return "redirect:history_detail?no="+buyNo;
//	}
//
}
