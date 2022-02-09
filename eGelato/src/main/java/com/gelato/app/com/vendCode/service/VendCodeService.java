package com.gelato.app.com.vendCode.service;

import java.util.List;

import com.gelato.app.com.vendCode.dao.VendCodeVO;


public interface VendCodeService {

	//VendCode 전체 조회.
	List<VendCodeVO> vendCodeList(VendCodeVO vo);
	
	//VendCode 등록, 수정 modify.
	//public int modifyVendCode(ModifyVO<VendCodeVO> mvo);
	
	// VendCode 등록.
	int insertVendCode(VendCodeVO vo);
		
	// VendCode 수정.
	int updateVendCode(VendCodeVO vo);
}
