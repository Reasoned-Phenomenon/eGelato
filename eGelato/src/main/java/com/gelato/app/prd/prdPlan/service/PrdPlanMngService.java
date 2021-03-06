package com.gelato.app.prd.prdPlan.service;

import java.util.HashMap;
import java.util.List;

import com.gelato.app.prd.prdPlan.dao.PrdPlanMngVO;
import com.gelato.app.vr.ModifyVO;

public interface PrdPlanMngService {
	
	//주문서 조회
	List<PrdPlanMngVO> OrderShtList();
	
	//검색결과 조회
	List<PrdPlanMngVO> SearchPlanList(PrdPlanMngVO vo);
	
	//제품 목록 조회
	List<PrdPlanMngVO> PrdtList();
	
	//상세생산계획 그리드에 출력
	List<PrdPlanMngVO> ChooseOrder(PrdPlanMngVO vo);
	
	//modify - 등록
	public int modifyPrdPlan(ModifyVO<PrdPlanMngVO> mvo);
	
	//modify - 취소
	PrdPlanMngVO modifyCanPrdPlan(PrdPlanMngVO mvo);
	
	//modify - 홀딩값
	public int modifyExcp(ModifyVO<PrdPlanMngVO> mvo);
	
	
	//임시
	//modify - 취소
	HashMap modifyCanPrdPlan(HashMap temp);
}
