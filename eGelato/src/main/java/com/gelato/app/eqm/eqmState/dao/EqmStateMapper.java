package com.gelato.app.eqm.eqmState.dao;

import java.util.List;

public interface EqmStateMapper {
	List<EqmStateVO> temperature(EqmStateVO eqmStateVo);
	List<EqmStateVO> output(EqmStateVO eqmStateVo);
	List<EqmStateVO> uph(EqmStateVO eqmStateVo);
}
