package com.gelato.app.prd.prdIndica.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.prd.prdIndica.dao.PrdIndicaMngMapper;
import com.gelato.app.prd.prdIndica.dao.PrdIndicaMngVO;
import com.gelato.app.prd.prdIndica.service.PrdIndicaMngService;

@Service
public class PrdIndicaMngImpl implements PrdIndicaMngService{

	@Autowired PrdIndicaMngMapper pimMapper;
	
	@Override
	public List<PrdIndicaMngVO> nonIndicaList() {
		return pimMapper.nonIndicaList();
	}

	@Override
	public List<PrdIndicaMngVO> choosePlan(PrdIndicaMngVO vo) {
		return pimMapper.choosePlan(vo);
	}

	@Override
	public PrdIndicaMngVO choosePlanDetaId(PrdIndicaMngVO vo) {
		return pimMapper.choosePlanDetaId(vo);
	}

	@Override
	public List<PrdIndicaMngVO> chooseIndicaQy(PrdIndicaMngVO vo) {
		return pimMapper.chooseIndicaQy(vo);
	}

	@Override
	public List<PrdIndicaMngVO> chooseRwmatrId(PrdIndicaMngVO vo) {
		return pimMapper.chooseRwmatrId(vo);
	}

}
