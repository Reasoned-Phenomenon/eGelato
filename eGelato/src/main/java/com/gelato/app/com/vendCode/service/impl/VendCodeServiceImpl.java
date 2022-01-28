package com.gelato.app.com.vendCode.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.com.vendCode.dao.VendCodeMapper;
import com.gelato.app.com.vendCode.dao.VendCodeVO;
import com.gelato.app.com.vendCode.service.VendCodeService;
import com.gelato.app.vr.ModifyVO;

@Service
public class VendCodeServiceImpl implements VendCodeService {

	@Autowired VendCodeMapper vendcodeMapper;
	
	// VendCode 전체 조회.
	@Override
	public List<VendCodeVO> vendCodeList(VendCodeVO vo) {
		
		return vendcodeMapper.vendCodeList(vo);
	}
	
	// modify로 등록, 수정
	@Override
	public int modifyVendCode(ModifyVO<VendCodeVO> mvo) {
		
		for(VendCodeVO vo : mvo.getCreatedRows()) {
			System.out.println("등록.");
			vendcodeMapper.insertVendCode(vo);
		}
		
		for(VendCodeVO vo : mvo.getUpdatedRows()) {
			System.out.println("수정.");
			vendcodeMapper.updateVendCode(vo);
		}
		
		return 0;
	}

}
