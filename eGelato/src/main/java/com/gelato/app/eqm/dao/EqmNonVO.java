package com.gelato.app.eqm.dao;

import lombok.Data;

@Data
public class EqmNonVO {
	String eqmNonOprId;	//비가동코드
	String eqmId;		//설비코드
	String nonOprFrTm;	//비가동시작
	String remk;		//비고
	String nonOprToTm;	//비가동종료시간
	String resnId;		//비가동사유코드
	
	String eqmName;		//설비명
	String resnName;	//비가동사유명
	String gubun;		//구분
	
	String toDate;
	String fromDate;
	String searchId;
}
