package com.gelato.app.prd.prdPrcs.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.prd.prdPrcs.dao.PrdPrcsMngMapper;
import com.gelato.app.prd.prdPrcs.dao.PrdPrcsMngVO;
import com.gelato.app.prd.prdPrcs.service.PrdPrcsMngService;

@Service
public class PrdPrcsMngServiceImpl implements PrdPrcsMngService{

	@Autowired PrdPrcsMngMapper ppmMapper;

	@Override
	public List<PrdPrcsMngVO> chooseIndica(PrdPrcsMngVO vo) {
		return ppmMapper.chooseIndica(vo);
	}

	@Override
	public List<PrdPrcsMngVO> selectIndica(PrdPrcsMngVO vo) {
		return ppmMapper.selectIndica(vo);
	}

	@Override
	public List<PrdPrcsMngVO> prcsList(PrdPrcsMngVO vo) {
		return ppmMapper.prcsList(vo);
	}
}
