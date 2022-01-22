package com.gelato.app.rwmatr.dao;

import java.util.List;

public interface RwmatrMapper {

	//원자재 리스트
	List<RwmatrVO> rwmatrList(RwmatrVO vo);
}
