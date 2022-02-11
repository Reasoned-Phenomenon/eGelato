package com.gelato.app.com.rwmatrCode.dao;

import lombok.Data;

@Data
public class RwmatrCodeVO {
		
	String rwmatrId;  // 자재 코드.
	String vendId;    // 업체 코드.
	String nm;        // 자재 명.
	String spec;	  // 규격.
	String wkUnit;	  // 작업 단위.
	String safStc;    // 안전 재고.
	String fg;        // 구분 (원자재인지 반제품인지 완제품인지).
	
	// join에 필요한 거.
	String useYn;     //사용 여부.
	String vendName;  // 업체 명.
	String bizno;     // 사업자 등록번호.
	String telno;     // 전화번호.
 	
	// 
	String fgCode;  // 제품구분코드.
	String specCode; // 규격구분코드.
	String wkUnitCode; // 작업단위코드.
}
