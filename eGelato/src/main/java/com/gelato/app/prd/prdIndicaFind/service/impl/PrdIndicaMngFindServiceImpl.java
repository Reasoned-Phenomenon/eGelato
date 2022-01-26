package com.gelato.app.prd.prdIndicaFind.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.prd.prdIndicaFind.dao.PrdIndicaMngFindMapper;
import com.gelato.app.prd.prdIndicaFind.dao.PrdIndicaMngFindVO;
import com.gelato.app.prd.prdIndicaFind.service.PrdIndicaMngFindService;

@Service
public class PrdIndicaMngFindServiceImpl implements PrdIndicaMngFindService{

	@Autowired PrdIndicaMngFindMapper pifMapper;

	@Override
	public List<PrdIndicaMngFindVO> indicaList(PrdIndicaMngFindVO vo) {
		return pifMapper.indicaList(vo);
	}

	
	
	
}
