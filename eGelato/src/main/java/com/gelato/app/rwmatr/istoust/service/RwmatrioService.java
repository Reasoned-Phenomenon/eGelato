package com.gelato.app.rwmatr.istoust.service;

import java.util.List;

import com.gelato.app.rwmatr.istoust.dao.RwmatrioVO;

public interface RwmatrioService {

	// 입고 관리 전체조회
	List<RwmatrioVO> RwmatrIstList(RwmatrioVO vo);

	// 검수 완료 리스트 조회
	List<RwmatrioVO> RwmatrPassList(RwmatrioVO vo);
	
	//출고 관리 전체조회
	List<RwmatrioVO> RwmatrOustList(RwmatrioVO vo);
	
	//자재 현재고 전체조회
	List<RwmatrioVO> RwmatrStcList(RwmatrioVO vo);
	
	//자재 현재고 전체조회(모달)
	List<RwmatrioVO> RwmatrStcMList(RwmatrioVO vo);
}
