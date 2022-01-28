package com.gelato.app.biz.service;

import java.util.List;


import com.gelato.app.biz.dao.OrderVO;

public interface OrderService {

	//주문서 조회.
	List<OrderVO> findOrderList(OrderVO vo);
	
	// 거래처 조회.
	List<OrderVO> vendList(OrderVO vo);
	
	// 제품코드 조회.
	List<OrderVO> prdtList(OrderVO vo);
}
