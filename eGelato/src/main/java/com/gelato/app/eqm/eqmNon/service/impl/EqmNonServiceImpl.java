package com.gelato.app.eqm.eqmNon.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.eqm.dao.EqmVO;
import com.gelato.app.eqm.eqmNon.dao.EqmNonMapper;
import com.gelato.app.eqm.eqmNon.dao.EqmNonVO;
import com.gelato.app.eqm.eqmNon.service.EqmNonService;
@Service	
public class EqmNonServiceImpl implements EqmNonService {

	@Autowired EqmNonMapper eqmNonMapper;
	
	// 설비비가동 조회
	@Override
	public List<EqmVO> eqmNonList(EqmVO eqmVo) {
		return eqmNonMapper.eqmNonList(eqmVo);
	}

	@Override
	public List<EqmNonVO> eqmNonSelect(EqmNonVO eqmNonVo) {
		return eqmNonMapper.eqmNonSelect(eqmNonVo);
	}

	@Override
	public int insertNonEqm(EqmNonVO eqmNonVo) {
		return eqmNonMapper.insertNonEqm(eqmNonVo);
	}

	@Override
	public List<EqmNonVO> eqmNonSelectAll(EqmNonVO eqmNonVo) {
		return eqmNonMapper.eqmNonSelectAll(eqmNonVo);
	}

	@Override
	public List<EqmNonVO> EqmNonResnSearch(EqmNonVO eqmNonVo) {
		return eqmNonMapper.EqmNonResnSearch(eqmNonVo);
	}

}
