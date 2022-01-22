package com.gelato.app.eqm.eqmIns.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.eqm.eqmIns.dao.EqmInsMapper;
import com.gelato.app.eqm.eqmIns.dao.EqmInsVO;
import com.gelato.app.eqm.eqmIns.service.EqmInsService;

@Service
public class EqmInsServiceImpl implements EqmInsService{

	@Autowired EqmInsMapper mapper;

	@Override
	public List<EqmInsVO> eqmChck(EqmInsVO eqmInsVo) {
		return mapper.eqmChck(eqmInsVo);
	}
	
}
