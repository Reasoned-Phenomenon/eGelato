package com.gelato.app.com.vendCode.dao;

import lombok.Data;

@Data
public class VendCodeVO {

	String vendId;   // 거래처(업체) 코드.
	String vendName; // 거래처(업체)명.
	String bizno;    // 사업자 등록번호.
	String telno;    // 거래처(업체) 전화번호.
	String remk;     // 비고.
	String fg;       // 구분.(거래처 구분.)
	
	String fgCode;   // 
}
