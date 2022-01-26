package com.gelato.app.eqm.eqmState.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class EqmStateVO {
	
	String eqmId;	//설비코드
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date calTm;		//계산일자
	String oprTm;	//가동시간
	String prodQy;	//산출량
	String uph;		//uph
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	String logTime;	//log시간
	String tempNow;	//실시간 온도
	
}
