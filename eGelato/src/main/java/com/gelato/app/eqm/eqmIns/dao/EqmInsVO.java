package com.gelato.app.eqm.eqmIns.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class EqmInsVO {
	
	String eqmId;		//설비코드
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date chckDt;		//점검일자
	String chckDeta;	//점검내용
	String judt;		//판정
	String inspr;		//검수인
	
	String eqmName;		//설비명
	String chckPerd;	//점검주기	
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date nmCkDt;		//차기점검일 : 점검일 + 점검주기
	String gubun;
	String fg;
	

	String fromCkDate;	
	String toCkDate;

	String total;
	
	String fromDayCkDate;
	String toDayCkDate;
}
