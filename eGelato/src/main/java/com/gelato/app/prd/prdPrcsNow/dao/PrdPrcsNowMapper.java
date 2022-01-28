package com.gelato.app.prd.prdPrcsNow.dao;

import java.util.List;

import com.gelato.app.prd.prdPrcs.dao.PrdPrcsMngVO;

public interface PrdPrcsNowMapper {

	// 생산지시조회
	List<PrdPrcsMngVO> chooseIndicaDeta(PrdPrcsNowVO vo);
	
	// 공정목록 출력
	List<PrdPrcsNowVO> prcsList(PrdPrcsNowVO vo);
	
	// 공정별 실적
	List<PrdPrcsNowVO> prcsDetaList(PrdPrcsNowVO vo);
}
