package com.gelato.app.com.comCodeDeta.dao;

import lombok.Data;

@Data
public class ComCodeDetaVO {

	String codeId;
	String code;
	String codeNm;
	String codeDc;
	String useAt;
	String frstRegistPnttm;
	String frstRegisterId;
	String lastUpdtPnttm;
	String lastUPdusrId;
	
	//update를 위한 코드
	String bcode;
	
}
