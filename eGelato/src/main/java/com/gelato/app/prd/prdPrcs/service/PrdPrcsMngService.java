package com.gelato.app.prd.prdPrcs.service;

import java.util.List;

import com.gelato.app.prd.prdPrcs.dao.PrdPrcsMngVO;
import com.gelato.app.vr.ModifyVO;

public interface PrdPrcsMngService {

	// 생산지시조회
	List<PrdPrcsMngVO> chooseIndica(PrdPrcsMngVO vo);
	
	// 진행할 생산지시 출력
	List<PrdPrcsMngVO> selectIndica(PrdPrcsMngVO vo);
	
	// 공정 출력
	List<PrdPrcsMngVO> prcsList(PrdPrcsMngVO vo);
	
	// 공정시작
	public int modifyPrcs(ModifyVO<PrdPrcsMngVO> mvo);
	
	// 일시정지
	int prcsStStop (List<PrdPrcsMngVO> vo);
	
	// 재시작
	int prcsStRest (List<PrdPrcsMngVO> vo);
	
	// 스케줄러
	String startSche (PrdPrcsMngVO vo);
	String stopSche (PrdPrcsMngVO vo);
	String restartSche (PrdPrcsMngVO vo);
}
