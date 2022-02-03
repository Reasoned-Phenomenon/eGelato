package com.gelato.app.biz.oust.dao;

import java.util.List;

public interface OustMapper {
	
	// 출고 조회
	List<OustVO> OustList(OustVO vo);
}
