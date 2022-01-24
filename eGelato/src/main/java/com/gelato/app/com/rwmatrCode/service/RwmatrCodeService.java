package com.gelato.app.com.rwmatrCode.service;

import java.util.List;

import com.gelato.app.com.rwmatrCode.dao.RwmatrCodeVO;

public interface RwmatrCodeService {

	// rwmatr 전체 조회.
	List<RwmatrCodeVO> findRwmatrList(RwmatrCodeVO vo);
}
