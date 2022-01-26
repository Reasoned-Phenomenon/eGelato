package com.gelato.app.eqm.eqmNon.service;

import java.util.List;

import com.gelato.app.eqm.dao.EqmVO;
import com.gelato.app.eqm.eqmNon.dao.EqmNonVO;

public interface EqmNonService {

	// 비가동설비 조회
	List<EqmVO> eqmNonList(EqmVO eqmVo);

	// 설비비가동 내역 전체 조회
	List<EqmNonVO> eqmNonSelectAll(EqmNonVO eqmNonVo);

	// 비가동관리 내역조회
	List<EqmNonVO> eqmNonSelect(EqmNonVO eqmNonVo);

	// 비가동관리 등록
	int insertNonEqm(EqmNonVO eqmNonVo);
	
	// 비가동사유코드 검색 모달
	List<EqmNonVO> EqmNonResnSearch(EqmNonVO eqmNonVo);
	
	//설비 비가동 등록 후 사용여부 업데이트
	int updateEqmNon(EqmNonVO eqmNonVo);

}
