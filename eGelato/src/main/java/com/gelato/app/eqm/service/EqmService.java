package com.gelato.app.eqm.service;

import java.util.List;

import com.gelato.app.eqm.dao.EqmNonVO;
import com.gelato.app.eqm.dao.EqmVO;

public interface EqmService {

	int insertEqm(EqmVO eqmVo);

	List<EqmVO> eqmList(EqmVO eqmVo);

	EqmVO eqmSelect(EqmVO eqmVo);

	//EqmVO eqmUpdate(EqmVO eqmVo);
	int eqmUpdate(EqmVO eqmVo);

	int eqmDelete(EqmVO eqmVo);
	
	List<EqmVO> eqmNonList(EqmVO eqmVo);
	
	//비가동관리 내역조회
	List<EqmNonVO> eqmNonSelect(EqmNonVO eqmNonVo);
	
	int insertNonEqm(EqmNonVO eqmNonVo);
	
}
