package com.gelato.app.eqm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.eqm.dao.EqmVO;
import com.gelato.app.eqm.dao.EqmMapper;
import com.gelato.app.eqm.dao.EqmNonVO;
import com.gelato.app.eqm.service.EqmService;

@Service	
public class EqmServiceImpl implements EqmService{
	
	@Autowired EqmMapper eqmMapper;
	
	//설비 등록
	@Override
	public int insertEqm(EqmVO eqmVo) {
		return eqmMapper.insertEqm(eqmVo);
	}
	
	//전체 설비 목록조회
	@Override
	public List<EqmVO> eqmList(EqmVO eqmVo) {
		return eqmMapper.eqmList(eqmVo);
	}
	
	//설비 한건조회
	@Override
	public EqmVO eqmSelect(EqmVO eqmVo) {
		return eqmMapper.eqmSelect(eqmVo);
	}
	
	//설비수정
	@Override
	public int eqmUpdate(EqmVO eqmVo) {
		return eqmMapper.eqmUpdate(eqmVo);
	}

	/*
	 * public EqmVO eqmUpdate(EqmVO eqmVo) { return eqmMapper.eqmUpdate(eqmVo); }
	 */	
	//설비삭제
	@Override
	public int eqmDelete(EqmVO eqmVo) {
		return eqmMapper.eqmDelete(eqmVo);
	}

	//설비비가동 조회
	@Override
	public List<EqmVO> eqmNonList(EqmVO eqmVo) {
		return eqmMapper.eqmNonList(eqmVo);
	}

	@Override
	public List<EqmNonVO> eqmNonSelect(EqmNonVO eqmNonVo) {
		return eqmMapper.eqmNonSelect(eqmNonVo);
	}

	@Override
	public int insertNonEqm(EqmNonVO eqmNonVo) {
		return eqmMapper.insertNonEqm(eqmNonVo);
	}
	
}
