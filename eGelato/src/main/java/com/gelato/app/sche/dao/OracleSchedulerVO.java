package com.gelato.app.sche.dao;

import lombok.Data;

@Data
public class OracleSchedulerVO {

	String jobName;
	String programName;		//진행공정코드에서 '바'를 제외한 문자. ex) 	PRN-001-001 -> PRN001001
	
	String prcsNowId;
	String indicaDetaId;
	String ord;
	
}
