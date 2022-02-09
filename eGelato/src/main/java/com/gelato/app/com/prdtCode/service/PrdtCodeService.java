package com.gelato.app.com.prdtCode.service;

import java.util.List;

import com.gelato.app.com.prdtCode.dao.PrdtCodeVO;

public interface PrdtCodeService {

	// PrdtCode 전체 조회.
	List<PrdtCodeVO> PrditCodeList(PrdtCodeVO vo);
	
	// PrdtCode 등록 수정은 modify.
	//public int modifyPrdtCode(ModifyVO<PrdtCodeVO> mvo);
	
	// PrdtCode 등록.
	int insertPrdtCode(PrdtCodeVO vo);
		
	// PrdtCode 수정.
	int updatePrdtCode(PrdtCodeVO vo);
}
