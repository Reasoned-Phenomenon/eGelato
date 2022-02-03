package com.gelato.app.prd.prdPrcs.dao;

import java.util.List;

public interface PrdPrcsMngMapper {

	// 생산지시조회
	List<PrdPrcsMngVO> chooseIndica(PrdPrcsMngVO vo);
	
	// 진행할 생산지시 출력
	List<PrdPrcsMngVO> selectIndica(PrdPrcsMngVO vo);
	
	// 공정 출력
	List<PrdPrcsMngVO> prcsList(PrdPrcsMngVO vo);
	
	// modify
	int insertPrcsNow (PrdPrcsMngVO vo);
	int insertPrcsSt (PrdPrcsMngVO vo);
	
	// 프로시저 호출
	int eqmProcedure(PrdPrcsMngVO vo);
	//HashMap eqmProcedure(HashMap temp);
	
	// 일시정지
	int prcsStStop (PrdPrcsMngVO vo);
	
	// 재시작
	int prcsStRest (PrdPrcsMngVO vo);
}
