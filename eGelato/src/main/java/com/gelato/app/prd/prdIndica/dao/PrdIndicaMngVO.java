package com.gelato.app.prd.prdIndica.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class PrdIndicaMngVO {
	
	//생산계획
	String planId;
	String orderId;
	String name;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date dt;
	String prodDcnt;
	String fg;
	
	//생산계획디테일
	String planDetaId;
	String prdtId;
	String qy;
	String priort;
	String remk;
	
	//홀딩
	String rwmatrId;
	String nm;
	
	//원자재
	String wkUnit;
	
	//생산지시
	String indicaId;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date indicaDt;
	
	//생산지시디테일
	String indicaDetaId;
	String ord;
	String lineId;
	
	//투입원자재
	String lotNo;
	
	//완제품
	String prdtNm;
	
	//라인
	String prcsId;
	
	//원자재 현재고
	String eqcpQy;
	
	//공정
	
	//원자재 입출고
	String istOustDttm;
	String istQy;
	String oustQy;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date expdate;
	String rwmatrOrderDetaId;
	
	//BOM
	String bomId;
	String useYn;
	
}
