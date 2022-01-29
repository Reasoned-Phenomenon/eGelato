package com.gelato.app.biz.eprd.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class EproductVO {
	
	String prdtId;
	String prdtNm;
	
	String prdtLotNo;
	String qy;
	String prodDt;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date expdate;
	String fg;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date istOustDttm;
	String istQy;
	String oustQy;
	
	
	String startDate;
	String endDate;
	String eprdtName;
	
}
