package com.gelato.app.biz.eprd.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.biz.eprd.dao.EproductMapper;
import com.gelato.app.biz.eprd.dao.EproductVO;
import com.gelato.app.biz.eprd.service.EproductService;

@Service
public class EproductServiceImpl implements EproductService {

	@Autowired EproductMapper eproductMapper;
	
	@Override
	public List<EproductVO> EproductStcList(EproductVO vo) {
		return eproductMapper.EproductIstList(vo);
	}

	@Override
	public List<EproductVO> EproductIstList(EproductVO vo) {
		return eproductMapper.EproductIstList(vo);
	}

	@Override
	public List<EproductVO> EproductOustList(EproductVO vo) {
		return eproductMapper.EproductOustList(vo);
	}

}
