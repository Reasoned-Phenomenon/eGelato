package com.gelato.app.prd.prdIndica.dao;

import java.util.List;

public interface PrdIndicaMngMapper {

	//미지시 생산계획 조회
	List<PrdIndicaMngVO> nonIndicaList();
	
	//생산계획디테일 그리드 출력
	List<PrdIndicaMngVO> choosePlan(PrdIndicaMngVO vo);
	
	//생산지시 그리드 출력
	List<PrdIndicaMngVO> choosePlanDetaId(PrdIndicaMngVO vo);
}
