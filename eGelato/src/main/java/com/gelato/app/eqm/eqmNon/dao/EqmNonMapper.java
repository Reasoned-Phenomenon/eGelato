package com.gelato.app.eqm.eqmNon.dao;

import java.util.List;

import com.gelato.app.eqm.dao.EqmVO;


public interface EqmNonMapper {
	// 설비비가동
	List<EqmVO> eqmNonList(EqmVO eqmVo);

	// 설비비가동 내역 전체 조회
	List<EqmNonVO> eqmNonSelectAll(EqmNonVO eqmNonVo);
	
	// 설비비가동 내역조회(조건검색)
	List<EqmNonVO> eqmNonSelect(EqmNonVO eqmNonVo);

	// 설비비가동 등록
	int insertNonEqm(EqmNonVO eqmNonVo);
	
	// 설비비가동사유코드 검색 모달
	List<EqmNonVO> EqmNonResnSearch(EqmNonVO eqmNonVo);
	
}
