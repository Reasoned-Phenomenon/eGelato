package com.gelato.app.com.vendCode.service;

import java.util.List;

import com.gelato.app.com.vendCode.dao.VendCodeVO;
import com.gelato.app.vr.ModifyVO;

public interface VendCodeService {

	//VendCode 전체 조회.
	List<VendCodeVO> vendCodeList(VendCodeVO vo);
	
	//VendCode 등록, 수정 modify.
	public int modifyVendCode(ModifyVO<VendCodeVO> mvo);
}
