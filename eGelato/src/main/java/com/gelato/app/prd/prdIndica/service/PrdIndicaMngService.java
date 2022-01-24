package com.gelato.app.prd.prdIndica.service;

import java.util.List;

import com.gelato.app.prd.prdIndica.dao.PrdIndicaMngVO;
import com.gelato.app.prd.prdPlan.dao.PrdPlanMngVO;
import com.gelato.app.vr.ModifyVO;

public interface PrdIndicaMngService {

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
	
	//modify - 등록
	int insertPrdIndica(List<PrdIndicaMngVO> vo);
	
	//modify - 등록
	int insertPrdIdicaDeta(List<PrdIndicaMngVO> vo);
	
	//투입원자재 insert
	int insertInptRwmatr(List<PrdIndicaMngVO> vo);
}
