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

	// rwmatrCode 전체 조회.
	@Override
	public List<RwmatrCodeVO> findRwmatrList(RwmatrCodeVO vo) {
		
		return rwmatrcodeMapper.findRwmatrList(vo);
	}
	
	// modal 거래처 조회.
	@Override
	public List<RwmatrCodeVO> vendModalList() {
		
		return rwmatrcodeMapper.vendModalList();
	}

	// 자재코드 등록
	@Override
	public int insertrwmatrCode(RwmatrCodeVO vo) {
		
		return rwmatrcodeMapper.insertrwmatrCode(vo);
	}
	
	// 자재코드 수정.
	@Override
	public int updaterwmatrCode(RwmatrCodeVO vo) {
		
		return rwmatrcodeMapper.updaterwmatrCode(vo);
	}

}
