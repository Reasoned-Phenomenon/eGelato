package com.gelato.app.biz.oust.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class OustVO {


	// 주문서 디테일 테이블.
	String orderId;   // 주문코드.
	String prdtId;    // 제품코드.
	String qy;        // 수량.
	String orderShtDetaId;  // 주문서 디테일 코드.
	
	// 완제품 재고 테이블.
	String  lotNo; // 완제품 로트번호.
	String  prdtQy; // 완제품 수량.
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date prodDt;  // 제조일자.
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date expdate; // 유통기한.
	
	String fg;  // (원자재, 반제품, 완제품).
	
	// 완제품 입출고 테이블.
	String istQy; // 입고량.
	String oustQy; // 출고량.
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date istOustDttm; // 입출고 일시.
	
	// 날짜 조회할때 필요함.
	String startDate;
	String endDate;
	
	// 
	String prdtNm;// 제품명.
	
	
}
