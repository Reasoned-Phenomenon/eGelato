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
	
	// 완제품 LOT번호 테이블.
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date prodDt;  // 제조일자.
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date expdate; // 유통기한.
	
	String fg;
	
	// 날짜 조회할때 필요함.
	String startDate;
	String endDate;
	
	
	// join 시 필요한거 추가하기.
}
