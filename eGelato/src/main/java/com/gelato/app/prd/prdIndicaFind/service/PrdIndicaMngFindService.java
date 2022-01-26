package com.gelato.app.prd.prdIndicaFind.service;

import java.util.List;

import com.gelato.app.prd.prdIndicaFind.dao.PrdIndicaMngFindVO;

public interface PrdIndicaMngFindService {

	//지시 조회
	List<PrdIndicaMngFindVO> indicaList(PrdIndicaMngFindVO vo);
}
