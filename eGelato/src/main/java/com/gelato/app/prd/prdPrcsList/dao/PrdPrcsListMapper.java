package com.gelato.app.prd.prdPrcsList.dao;

import java.util.List;

public interface PrdPrcsListMapper {

	// 그리드 출력
	List<PrdPrcsListVO> prcsMngList(PrdPrcsListVO vo);
}
