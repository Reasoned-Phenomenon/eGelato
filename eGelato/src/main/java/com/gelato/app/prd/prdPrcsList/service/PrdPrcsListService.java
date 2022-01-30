package com.gelato.app.prd.prdPrcsList.service;

import java.util.List;

import com.gelato.app.prd.prdPrcsList.dao.PrdPrcsListVO;

public interface PrdPrcsListService {

	// 그리드 출력
	List<PrdPrcsListVO> prcsMngList(PrdPrcsListVO vo);
}
