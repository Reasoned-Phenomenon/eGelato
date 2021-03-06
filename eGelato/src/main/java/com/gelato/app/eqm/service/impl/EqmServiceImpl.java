package com.gelato.app.eqm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.eqm.dao.EqmVO;
import com.gelato.app.eqm.eqmNon.dao.EqmNonVO;
import com.gelato.app.eqm.dao.EqmMapper;
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

	
}
