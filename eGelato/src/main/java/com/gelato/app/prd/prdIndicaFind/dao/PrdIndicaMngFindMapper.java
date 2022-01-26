package com.gelato.app.prd.prdIndicaFind.dao;

import java.util.List;

public interface PrdIndicaMngFindMapper {

	//지시 조회
	List<PrdIndicaMngFindVO> indicaList(PrdIndicaMngFindVO vo);
}
