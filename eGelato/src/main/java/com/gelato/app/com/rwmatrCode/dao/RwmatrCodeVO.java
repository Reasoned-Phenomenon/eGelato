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
	
	
	// join에 필요한 거.
	String useYn;     //사용 여부.
	String vendName;  // 업체 명.
	
 	
}
