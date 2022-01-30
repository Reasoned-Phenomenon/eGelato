package com.gelato.app.prd.prdPrcsNow.dao;

import java.util.List;

public interface PrdPrcsNowMapper {

	// 모달1 조회
	List<PrdPrcsNowVO> prcsDialog(PrdPrcsNowVO vo);
	
	// 모달2 조회
	List<PrdPrcsNowVO> indicaDialog(PrdPrcsNowVO vo);
	
	// 그리드 출력
	List<PrdPrcsNowVO> prcsList(PrdPrcsNowVO vo);
	
	// 모달3 조회
	List<PrdPrcsNowVO> prdtInferCodeDialog(PrdPrcsNowVO vo);
	
	// 불량 update
	PrdPrcsNowVO updateInfer(PrdPrcsNowVO vo);
}
