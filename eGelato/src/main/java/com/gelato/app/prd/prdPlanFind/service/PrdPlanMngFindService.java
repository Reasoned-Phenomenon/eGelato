package com.gelato.app.prd.prdPlanFind.service;

import java.util.List;

import com.gelato.app.prd.prdPlanFind.dao.PrdPlanMngFindVO;

public interface PrdPlanMngFindService {

	//제품 목록 조회
	List<PrdPlanMngFindVO> PrdtList();
	
	//계획 목록 조회
	List <PrdPlanMngFindVO> planList(PrdPlanMngFindVO vo);
}
