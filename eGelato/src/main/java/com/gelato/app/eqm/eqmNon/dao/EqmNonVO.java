package com.gelato.app.eqm.eqmNon.dao;

import lombok.Data;

@Data
public class EqmNonVO {
	String eqmNonOprId;	//비가동코드
	String eqmId;		//설비코드
	String nonOprFrTm;	//비가동시작
	String remk;		//비고
	String nonOprToTm;	//비가동종료시간
	String resnId;		//비가동사유코드
	String resnCode;	//비가동사유
	String resnDeta;	//비가동상세내역
	
	String eqmName;		//설비명
	String resnName;	//비가동사유명
	String gubun;		//구분
	
	String toDate;		//검색일자(시작)
	String fromDate;	//검색일자(종료)
	String searchId;	
	String searchIf;
	
	String eqmNonYn;	//비가동설비 체크
	
	String useYn;	//사용여부
		


}
