package com.gelato.app.biz.oust.service;

import java.util.List;

import com.gelato.app.biz.oust.dao.OustVO;

public interface OustService {

	// 출고 조회
	List<OustVO> oustList();
	
	// 출고 관리 그리드2
	List<OustVO> oustLotList(OustVO vo);
}
