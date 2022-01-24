package com.gelato.app.prd.prdIndica.dao;

import java.util.List;

public interface PrdIndicaMngMapper {

	//미지시 생산계획 조회
	List<PrdIndicaMngVO> nonIndicaList();
	
	//생산계획디테일 그리드 출력
	List<PrdIndicaMngVO> choosePlan(PrdIndicaMngVO vo);
	
	//생산지시 그리드 - ajax
	PrdIndicaMngVO choosePlanDetaId(PrdIndicaMngVO vo);
	
	//생산지시 선택 -> 자재
	List<PrdIndicaMngVO> chooseIndicaQy(PrdIndicaMngVO vo);
	
	//자재 선택 -> lot결정하기
	List<PrdIndicaMngVO> chooseRwmatrId(PrdIndicaMngVO vo);
	
	//생산지시 insert
	int insertPrdIndica(String string);
	
	//생산지시디테일 insert
	int insertPrdIdicaDeta(PrdIndicaMngVO vo);
	
	//투입원자재 insert
	int insertInptRwmatr(PrdIndicaMngVO vo);
}
