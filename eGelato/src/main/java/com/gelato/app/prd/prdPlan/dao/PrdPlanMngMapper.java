package com.gelato.app.prd.prdPlan.dao;

import java.util.HashMap;
import java.util.List;

public interface PrdPlanMngMapper {
	
	//주문서 조회
	List<PrdPlanMngVO> OrderShtList();
	
	//검색결과 조회
	List<PrdPlanMngVO> SearchPlanList(PrdPlanMngVO vo);
	
	//제품 목록 조회
	List<PrdPlanMngVO> PrdtList();
	
	//상세생산계획 그리드에 출력
	List<PrdPlanMngVO> ChooseOrder(PrdPlanMngVO vo);

	//계획 insert
	int insertPrdPlan(PrdPlanMngVO vo);
	
	//계획 디테일 insert
	int insertPrdPlanDeta(PrdPlanMngVO vo);
	
	//계획 취소 update
	PrdPlanMngVO updatePrdPlanDeta(PrdPlanMngVO mvo);
	
	//계획 등록 후 update
	int updateOrderSht(PrdPlanMngVO vo);
	
	//홀딩값 추가 insert
	int insertExcp(PrdPlanMngVO vo);
	
	//계획 취소시 홀딩값 삭제
	int deleteExcp(PrdPlanMngVO vo);
	
	//계획 취소 update - 임시
	HashMap updatePrdPlanDeta(HashMap temp);
}
