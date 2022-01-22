package com.gelato.app.com.comCode.dao;

import lombok.Data;

@Data
public class ComCodeVO {

	String codeId;
	String codeIdNm;  
	String codeIdDc;
	String useAt;      
	String clCode;       
	String frstRegistPnttm;         
	String frstRegisterId; 
	String lastUpdtPnttm;         
	String lastUpdusrId;
	
	//조인을 위한 필드
	String code;
	String codeNm;
	String codeDc;
	String codeIdUseAt;
	String codeUseAt;
	
}
