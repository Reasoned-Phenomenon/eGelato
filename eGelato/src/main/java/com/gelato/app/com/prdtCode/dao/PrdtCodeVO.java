package com.gelato.app.com.prdtCode.dao;

import lombok.Data;

@Data
public class PrdtCodeVO {
	
	String prdtId;   // 제품 코드.
	String prdtNm;   // 제품명.
	String spec;     // 규격.
	String unit;     // 단위.
	String safStc;   // 안전 재고.
	
	
	// join할 때 필요한거. 
	String specCode;  // 규격코드.
	String unitCode;  //단위코드.
}
