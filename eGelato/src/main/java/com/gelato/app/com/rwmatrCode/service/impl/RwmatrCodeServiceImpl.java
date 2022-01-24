package com.gelato.app.com.rwmatrCode.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.com.rwmatrCode.dao.RwmatrCodeMapper;
import com.gelato.app.com.rwmatrCode.dao.RwmatrCodeVO;
import com.gelato.app.com.rwmatrCode.service.RwmatrCodeService;

@Service
public class RwmatrCodeServiceImpl implements RwmatrCodeService {
	
	@Autowired RwmatrCodeMapper rwmatrcodeMapper;

	// rwmatr 전체 조회.
	@Override
	public List<RwmatrCodeVO> findRwmatrList(RwmatrCodeVO vo) {
		
		return rwmatrcodeMapper.findRwmatrList(vo);
	}
	
}
