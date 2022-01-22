package com.gelato.app.rwmatr.order.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class RwmatroVO {

	String orderId;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date orderDt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date dudt;
	
	String startDate;
	String endDate;
	String rwmName;
	String totalPrice;
	
	//join 
	String rwmatrId;
	String rwmatrOrderDetaId;
	String nm;
	String untprc;
	String qy;
	String vendId;
	String vendName;
	String fg;
	String remk;
}
