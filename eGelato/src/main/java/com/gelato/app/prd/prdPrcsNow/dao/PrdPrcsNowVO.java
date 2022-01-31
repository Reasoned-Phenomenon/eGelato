package com.gelato.app.prd.prdPrcsNow.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class PrdPrcsNowVO {

	String prcsNowId;
	String prcsId;
	String nm;
	String eqmId;
	String eqmName;
	String frTm;
	String toTm;
	String mngr;
	String inptQy;
	String qy;
	String inferId;
	String inferQy;
	
	String indicaDetaId;
	String prdtNm;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date indicaDt;
	
	String deta;
	String infer;
	
	// 모달1
	String prcsSelDeta;
	
	// 모달2
	String startD;
	String endD;
	
	// 모달3
	String name;
	
}
