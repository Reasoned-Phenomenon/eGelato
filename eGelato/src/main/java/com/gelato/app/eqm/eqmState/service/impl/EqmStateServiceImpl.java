package com.gelato.app.eqm.eqmState.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.eqm.eqmState.dao.EqmStateMapper;
import com.gelato.app.eqm.eqmState.dao.EqmStateVO;
import com.gelato.app.eqm.eqmState.service.EqmStateService;

@Service
public class EqmStateServiceImpl implements EqmStateService{
	
	@Autowired EqmStateMapper eqmStateMapper;

	@Override
	public List<EqmStateVO> temperature(EqmStateVO eqmStateVo) {
		return eqmStateMapper.temperature(eqmStateVo);
	}

	@Override
	public List<EqmStateVO> output(EqmStateVO eqmStateVo) {
		return eqmStateMapper.output(eqmStateVo);
	}

	@Override
	public List<EqmStateVO> uph(EqmStateVO eqmStateVo) {
		return eqmStateMapper.uph(eqmStateVo);
	}

}
