package com.kh.zipggu.service;

import java.util.List;

import com.kh.zipggu.vo.OrderListVO;
import com.kh.zipggu.vo.OrderSearchVO;

public interface OrderService {

	List<OrderListVO> listBySearchVO(OrderSearchVO orderSearchVO);

}
