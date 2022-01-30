package com.gelato.app.prd.prdPrcsNow.dao;

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
	String indicaDt;
	
	String deta;
	
	// 모달1
	String prcsSelDeta;
	
	// 모달2
	String startD;
	String endD;
	
}
