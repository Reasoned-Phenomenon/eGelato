package com.gelato.app.prd.prdLine.service;

import java.util.List;

import com.gelato.app.prd.prdLine.dao.PrdLineMngVO;
import com.gelato.app.vr.ModifyVO;

public interface PrdLineMngService {

	// 그리드1
	List<PrdLineMngVO> lineGrid();
	
	// 그리드2
	List<PrdLineMngVO> linePrcsGrid(PrdLineMngVO vo);
	
	public int modifyLine(ModifyVO<PrdLineMngVO> mvo);
}
