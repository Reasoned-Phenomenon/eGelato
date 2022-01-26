package com.gelato.app.com.prdtCode.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.com.prdtCode.dao.PrdtCodeMapper;
import com.gelato.app.com.prdtCode.dao.PrdtCodeVO;
import com.gelato.app.com.prdtCode.service.PrdtCodeService;

@Service
public class PrdtCodeServiceImpl implements PrdtCodeService  {

	@Autowired PrdtCodeMapper prdtcodeMapper;

	// prdtCode 전체 조회.
	@Override
	public List<PrdtCodeVO> PrditCodeList(PrdtCodeVO vo) {
		
		return prdtcodeMapper.PrditCodeList(vo);
	}
	
	
}
