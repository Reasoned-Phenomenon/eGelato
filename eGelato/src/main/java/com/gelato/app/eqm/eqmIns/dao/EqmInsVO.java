package com.gelato.app.eqm.eqmIns.dao;

import lombok.Data;

@Data
public class EqmInsVO {
	
	String eqmId;		//설비코드
	String chckDt;		//점검일자
	String chckDeta;	//점검내용
	String judt;		//판전
	String inspr;		//검수인
	
	String eqmName;		//설비명
	String chckPerd;	//점검주기		
	
	String gubun;
}
