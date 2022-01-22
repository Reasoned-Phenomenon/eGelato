package com.gelato.app.biz.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



import com.gelato.app.biz.dao.OrderMapper;
import com.gelato.app.biz.dao.OrderVO;
import com.gelato.app.biz.service.OrderService;

@Service
public class OrderServiceImpl implements  OrderService{
	
	@Autowired OrderMapper orderMapper;
	
	// 주문서 전체 조회.
	@Override
	public List<OrderVO> findOrderList(OrderVO vo) {
		
		return orderMapper.findOrderList(vo);
	}
	
	// 모달창으로 거래처 조회.
	@Override
	public List<OrderVO> vendList() {
		
		return orderMapper.vendList();
	}
	
	// 모달창으로 제품코드 조회.
	@Override
	public List<OrderVO> prdtList() {
		
		return orderMapper.prdtList();
	}

}
