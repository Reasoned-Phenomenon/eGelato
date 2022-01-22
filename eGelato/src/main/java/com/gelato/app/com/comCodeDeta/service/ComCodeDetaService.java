package com.gelato.app.com.comCodeDeta.service;

import java.util.List;
import java.util.Map;

import com.gelato.app.com.comCodeDeta.dao.ComCodeDetaVO;
import com.gelato.app.vr.ModifyVO;

public interface ComCodeDetaService {

	List<ComCodeDetaVO> findComCodeDeta(ComCodeDetaVO vo);
	Map findComCodeProcedure(Map map);
	
	int modifyComCodeDeta (ModifyVO<ComCodeDetaVO> mvo);
}
