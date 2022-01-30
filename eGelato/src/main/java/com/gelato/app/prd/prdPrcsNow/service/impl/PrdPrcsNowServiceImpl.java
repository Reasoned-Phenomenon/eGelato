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
	public List<PrdPrcsNowVO> prcsDialog(PrdPrcsNowVO vo) {
		return prdPrcsNowMapper.prcsDialog(vo);
	}

	@Override
	public List<PrdPrcsNowVO> indicaDialog(PrdPrcsNowVO vo) {
		return prdPrcsNowMapper.indicaDialog(vo);
	}
	

}
