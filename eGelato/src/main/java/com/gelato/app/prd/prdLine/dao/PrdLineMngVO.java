package com.gelato.app.prd.prdLine.dao;

import lombok.Data;

@Data
public class PrdLineMngVO {

	// 그리드1
	String prdtId;
	String prdtNm;
	String lineId;
	
	// 그리드2
	String prcsId;
	String nm;
	String eqmId;
	String eqmName;
}
