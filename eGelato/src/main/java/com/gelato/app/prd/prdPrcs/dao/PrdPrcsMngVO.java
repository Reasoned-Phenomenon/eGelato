package com.gelato.app.prd.prdPrcs.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class PrdPrcsMngVO {

	// 그리드1
	String indicaDetaId;
	String prdtNm;
	String prdtId;
	String qy;
	String lineId;
	String ord;
	
	// 모달창
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date indicaDt;
	String indicaD;
	
	//그리드2
	String prcsId;
	String nm;
	String eqmId;
	String eqmName;
	String prcsNowId;
	String mngr;
	String frTm;
	String lineOrd;
	String inptQy;
	
	String prcsSelDeta;
	String st;
	
	String jobName;
	String programName;
	
	String inptQyT;
	String inferQyT;
	String prodQyT;
	
	String startTm;
	String endTm;
	
	String psSt;
}
