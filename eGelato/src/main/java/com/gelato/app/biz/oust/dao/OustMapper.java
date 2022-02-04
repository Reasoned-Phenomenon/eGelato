package com.gelato.app.biz.oust.dao;

import java.util.List;

public interface OustMapper {
	
	// 출고 조회 (그리드1)
	List<OustVO> oustList();
	
	// 출고 관리 그리드2
	List<OustVO> oustLotList(OustVO vo);
	
	// 완제품 재고 조회 modal.
	List<OustVO> prdtStcList(OustVO vo);
}
