package com.gelato.app.prd.prdPlanFind.dao;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class PrdPlanMngFindVO {
	
	//prod_plan
	String planId;
	String name;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date dt;
	String prodDcnt;
	String fg;
	
	//prod_plan_deta
	String planDetaId;
	String qy;
	String priort;	
	String remk;
	
	//prdt
	String prdtId;
	String prdtNm;
	
	String endD;
	String startD;
}
