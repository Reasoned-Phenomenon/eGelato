package com.gelato.app.eqm.eqmState.service;

import java.util.List;

import com.gelato.app.eqm.eqmState.dao.EqmStateVO;

public interface EqmStateService {
	List<EqmStateVO> temperature(EqmStateVO eqmStateVo);
	List<EqmStateVO> output(EqmStateVO eqmStateVo);
	List<EqmStateVO> uph(EqmStateVO eqmStateVo);
	
	List<EqmStateVO> findNowEqm(EqmStateVO eqmStateVo);
	List<EqmStateVO> selectNowEqm(EqmStateVO eqmStateVo);
	List<EqmStateVO> selectLastEqm(EqmStateVO eqmStateVo);
	
}
