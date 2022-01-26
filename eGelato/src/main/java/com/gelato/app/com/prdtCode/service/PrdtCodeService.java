package com.gelato.app.com.prdtCode.service;

import java.util.List;

import com.gelato.app.com.prdtCode.dao.PrdtCodeVO;

public interface PrdtCodeService {

	// PrdtCode 전체 조회.
	List<PrdtCodeVO> PrditCodeList(PrdtCodeVO vo);
}
