package com.gelato.app.com.vendCode.dao;

import java.util.List;

public interface VendCodeMapper {

	//VendCode 전체 조회.
	List<VendCodeVO> vendCodeList(VendCodeVO vo);
	
	// VendCode 등록.
	int insertVendCode(VendCodeVO vo);
	
	// VendCode 수정.
	int updateVendCode(VendCodeVO vo);
	
}
