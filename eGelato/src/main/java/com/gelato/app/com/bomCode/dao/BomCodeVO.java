package com.gelato.app.com.bomCode.dao;

import lombok.Data;

@Data
public class BomCodeVO {

		String bomId;  // 제품 BOM코드.
		String prdtId; // 제품 코드.
		String rwmatrId; // 자재 코드.
		String qy;       // 소모량.
		String prcsId;   // 공정 코드.
		String fg;       // 단계 구분.
		String remk;     // 비고. 
		String useYn;    // 사용 여부.
		
		
		// join에 필요한 거 있으면 vo에 추가하기.
		String nm;      // 자재명.
		String spec;    // 자재 규격.
		String wkUnit;  // 작업 단위.
		
		String vendName;       // 업체명.
		String prdtNm;		  // 완제품 명.
		String prcsNm;		  // 공정 명.
		
		// 
		String lineId; 
		String ord;
		
		//
		String fgCode; // 구분 코드
		String specCode;
		String unitCode;
		
		String unit;
}
