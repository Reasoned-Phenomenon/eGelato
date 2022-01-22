package com.gelato.app.prd.prdPlanFind.dao;

import java.util.List;

import com.gelato.app.prd.prdPlan.dao.PrdPlanMngVO;

public interface PrdPlanMngFindMapper {
	
	//제품 목록 모달
	List<PrdPlanMngFindVO> PrdtList();
	
	//계획 목록 조회
	List <PrdPlanMngFindVO> planList(PrdPlanMngFindVO vo);
}
