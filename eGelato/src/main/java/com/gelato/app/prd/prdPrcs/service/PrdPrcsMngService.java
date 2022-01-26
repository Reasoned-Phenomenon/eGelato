package com.gelato.app.prd.prdPrcs.service;

import java.util.List;

import com.gelato.app.prd.prdPrcs.dao.PrdPrcsMngVO;

public interface PrdPrcsMngService {

	// 생산지시조회
	List<PrdPrcsMngVO> chooseIndica(PrdPrcsMngVO vo);
	
	// 진행할 생산지시 출력
	List<PrdPrcsMngVO> selectIndica(PrdPrcsMngVO vo);
	
	// 공정 출력
	List<PrdPrcsMngVO> prcsList(PrdPrcsMngVO vo);
}
