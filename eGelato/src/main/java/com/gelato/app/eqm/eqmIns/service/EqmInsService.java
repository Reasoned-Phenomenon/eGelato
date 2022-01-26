package com.gelato.app.eqm.eqmIns.service;

import java.util.List;

import com.gelato.app.eqm.eqmIns.dao.EqmInsVO;
import com.gelato.app.vr.ModifyVO;

public interface EqmInsService {
	
	List<EqmInsVO> eqmChck(EqmInsVO eqmInsVo);
	List<EqmInsVO> eqmInsList(EqmInsVO eqmInsVo);
	List<EqmInsVO> eqmDayChck(EqmInsVO eqmInsVo);
	
	public int modifyChck(ModifyVO<EqmInsVO> eqmInsVo);
}
