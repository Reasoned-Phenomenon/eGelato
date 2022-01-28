package com.gelato.app.prd.prdPrcsNow.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.prd.prdPrcs.dao.PrdPrcsMngVO;
import com.gelato.app.prd.prdPrcsNow.dao.PrdPrcsNowMapper;
import com.gelato.app.prd.prdPrcsNow.dao.PrdPrcsNowVO;
import com.gelato.app.prd.prdPrcsNow.service.PrdPrcsNowService;

@Service
public class PrdPrcsNowServiceImpl implements PrdPrcsNowService{

	@Autowired PrdPrcsNowMapper prdPrcsNowMapper;
	
	@Override
	public List<PrdPrcsNowVO> prcsList(PrdPrcsNowVO vo) {
		return prdPrcsNowMapper.prcsList(vo);
	}

	@Override
	public List<PrdPrcsNowVO> prcsDetaList(PrdPrcsNowVO vo) {
		// TODO Auto-generated method stub
		return prdPrcsNowMapper.prcsDetaList(vo);
	}

	@Override
	public List<PrdPrcsMngVO> chooseIndicaDeta(PrdPrcsNowVO vo) {
		return prdPrcsNowMapper.chooseIndicaDeta(vo);
	}

}
