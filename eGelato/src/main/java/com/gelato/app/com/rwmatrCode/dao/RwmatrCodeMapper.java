package com.gelato.app.com.rwmatrCode.dao;

import java.util.List;

public interface RwmatrCodeMapper {
		
	// rwmatr 전체 조회.
	List<RwmatrCodeVO> findRwmatrList(RwmatrCodeVO vo);
}
