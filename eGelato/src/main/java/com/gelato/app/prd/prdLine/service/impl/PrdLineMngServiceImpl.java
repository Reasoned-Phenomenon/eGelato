package com.gelato.app.prd.prdLine.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.prd.prdLine.dao.PrdLineMngMapper;
import com.gelato.app.prd.prdLine.dao.PrdLineMngVO;
import com.gelato.app.prd.prdLine.service.PrdLineMngService;

@Service
public class PrdLineMngServiceImpl implements PrdLineMngService{

	@Autowired PrdLineMngMapper plMapper;

	@Override
	public List<PrdLineMngVO> lineGrid() {
		return plMapper.lineGrid();
	}

	@Override
	public List<PrdLineMngVO> linePrcsGrid(PrdLineMngVO vo) {
		return plMapper.linePrcsGrid(vo);
	}
}
