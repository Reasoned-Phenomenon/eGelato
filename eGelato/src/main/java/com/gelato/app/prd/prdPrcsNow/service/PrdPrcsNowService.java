package com.gelato.app.prd.prdPrcsNow.service;

import java.util.List;

import com.gelato.app.prd.prdPrcsNow.dao.PrdPrcsNowVO;
import com.gelato.app.vr.ModifyVO;

public interface PrdPrcsNowService {
	
	// 모달1 조회
	List<PrdPrcsNowVO> prcsDialog(PrdPrcsNowVO vo);
	
	// 모달2 조회
	List<PrdPrcsNowVO> indicaDialog(PrdPrcsNowVO vo);

	// 그리드 출력
	List<PrdPrcsNowVO> prcsList(PrdPrcsNowVO vo);
	
	// 모달3 조회
	List<PrdPrcsNowVO> prdtInferCodeDialog(PrdPrcsNowVO vo);
	
	// 불량등록
	public int modifyPrdtPlan(ModifyVO<PrdPrcsNowVO> mvo);
}
