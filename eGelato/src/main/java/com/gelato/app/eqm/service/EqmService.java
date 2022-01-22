package com.gelato.app.eqm.service;

import java.util.List;

import com.gelato.app.eqm.dao.EqmVO;
import com.gelato.app.eqm.eqmNon.dao.EqmNonVO;

public interface EqmService {

	int insertEqm(EqmVO eqmVo);

	List<EqmVO> eqmList(EqmVO eqmVo);

	EqmVO eqmSelect(EqmVO eqmVo);

	int eqmUpdate(EqmVO eqmVo);
	
	
}
