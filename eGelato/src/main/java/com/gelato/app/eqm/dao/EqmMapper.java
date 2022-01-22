package com.gelato.app.eqm.dao;

import java.util.List;

public interface EqmMapper {
	
	//설비등록
	int insertEqm(EqmVO eqmVo);
	
	//설비전제조회
	List<EqmVO> eqmList(EqmVO eqmVo);
	
	//설비단건조회
	EqmVO eqmSelect(EqmVO eqmVo);
	
	//설비수정
	int eqmUpdate(EqmVO eqmVo);
	
	//설비삭제
	int eqmDelete(EqmVO eqmVo);
	
	//설비비가동
	List<EqmVO> eqmNonList(EqmVO eqmVo);
	
	//설비비가동 내역조회
	List<EqmNonVO> eqmNonSelect(EqmNonVO eqmNonVo);
	
	//설비비가동 등록
	int insertNonEqm(EqmNonVO eqmNonVo);
}
