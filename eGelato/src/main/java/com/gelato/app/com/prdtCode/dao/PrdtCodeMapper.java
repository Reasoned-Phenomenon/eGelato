package com.gelato.app.com.prdtCode.dao;

import java.util.List;

public interface PrdtCodeMapper {

	// PrdtCode 전체 조회.
	List<PrdtCodeVO> PrditCodeList(PrdtCodeVO vo);
	
	// PrdtCode 등록.
	int insertPrdtCode(PrdtCodeVO vo);
	
	// PrdtCode 수정.
	int updatePrdtCode(PrdtCodeVO vo);
}
