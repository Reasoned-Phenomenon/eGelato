package com.gelato.app.biz.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class OrderVO {
	
	//order_sht 주문서.
	String orderId; // 주문코드.
	String vendId;  // 업체 코드.
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date orderDt;  // 주문 일자.
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date oustDt; // 납기 일자.
	
	String stFg; // 진행상황 구분.
	String remk; // 비고.
	
	
	// order_sht_deta주문서 디테일(join)
	String orderShtDetaId; // 주문서 디테일 코드.
	String prdtId;         // 제품 코드.
	String qy;             // 수량.
	
	// vend거래처(join) 
	String vendName;       // 업체명.
	String bizno;          // 사업자 등록번호.
	String telno;          // 업체연락처.
	String fg;             // 구분.
	
	//prdt(완제품).(join)
	String prdtNm;         //제품명.
	String spec;           //규격.
	
}
