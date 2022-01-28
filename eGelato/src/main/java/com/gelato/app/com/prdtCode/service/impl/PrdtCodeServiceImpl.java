package com.gelato.app.com.prdtCode.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.com.prdtCode.dao.PrdtCodeMapper;
import com.gelato.app.com.prdtCode.dao.PrdtCodeVO;
import com.gelato.app.com.prdtCode.service.PrdtCodeService;
import com.gelato.app.vr.ModifyVO;

@Service
public class PrdtCodeServiceImpl implements PrdtCodeService  {

	@Autowired PrdtCodeMapper prdtcodeMapper;

	// prdtCode 전체 조회.
	@Override
	public List<PrdtCodeVO> PrditCodeList(PrdtCodeVO vo) {
		
		return prdtcodeMapper.PrditCodeList(vo);
	}

	// modify로 등록 수정
	@Override
	public int modifyPrdtCode(ModifyVO<PrdtCodeVO> mvo) {
		
		for(PrdtCodeVO vo : mvo.getCreatedRows()) {
			System.out.println("등록.");
			prdtcodeMapper.insertPrdtCode(vo);
		}
		
		for(PrdtCodeVO vo : mvo.getUpdatedRows()) {
			System.out.println("수정.");
			prdtcodeMapper.updatePrdtCode(vo);
		}
		
		return 0;
	}
	
	
}
