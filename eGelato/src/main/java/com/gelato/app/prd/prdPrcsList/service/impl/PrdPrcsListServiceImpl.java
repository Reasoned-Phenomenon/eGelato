package com.gelato.app.prd.prdPrcsList.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.prd.prdPrcsList.dao.PrdPrcsListMapper;
import com.gelato.app.prd.prdPrcsList.dao.PrdPrcsListVO;
import com.gelato.app.prd.prdPrcsList.service.PrdPrcsListService;

@Service
public class PrdPrcsListServiceImpl implements PrdPrcsListService{

	@Autowired PrdPrcsListMapper prdPrcsListMapper;

	@Override
	public List<PrdPrcsListVO> prcsMngList(PrdPrcsListVO vo) {
		return prdPrcsListMapper.prcsMngList(vo);
	}
}
