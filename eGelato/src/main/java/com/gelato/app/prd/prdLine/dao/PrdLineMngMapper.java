package com.gelato.app.prd.prdLine.dao;

import java.util.List;

public interface PrdLineMngMapper {

	// 그리드1
	List<PrdLineMngVO> lineGrid();
	
	// 그리드2
	List<PrdLineMngVO> linePrcsGrid(PrdLineMngVO vo);
}
