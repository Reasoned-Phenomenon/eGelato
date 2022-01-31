package com.gelato.app.prd.prdPrcsList.service;

import java.util.List;

import com.gelato.app.prd.prdPrcsList.dao.PrdPrcsListVO;
import com.gelato.app.vr.ModifyVO;

public interface PrdPrcsListService {

	// 그리드 출력
	List<PrdPrcsListVO> prcsMngList(PrdPrcsListVO vo);
	
	// 그리드 출력
	List<PrdPrcsListVO> unUseEqmList();
	
	// 등록 수정 삭제
	public int modifyPrcs(ModifyVO<PrdPrcsListVO> mvo);
}
