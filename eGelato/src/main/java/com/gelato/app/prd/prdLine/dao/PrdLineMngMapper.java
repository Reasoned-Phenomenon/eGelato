package com.gelato.app.prd.prdLine.dao;

import java.util.List;

import com.gelato.app.prd.prdPrcs.dao.PrdPrcsMngVO;

public interface PrdLineMngMapper {

	// 그리드1
	List<PrdLineMngVO> lineGrid();
	
	// 그리드2
	List<PrdLineMngVO> linePrcsGrid(PrdLineMngVO vo);
	
	//modify
	int insertLineDeta(PrdLineMngVO vo);
	int deleteLineDeta(PrdLineMngVO vo);
	List<PrdLineMngVO> updateLineOrd(PrdLineMngVO vo);
	int insertPrcsDeta(PrdLineMngVO vo);
	int updateLineDeta(PrdLineMngVO vo);
	
	// 공정이동표
	List<PrdLineMngVO> prdtMoveInfo(PrdLineMngVO vo);
 	List<PrdPrcsMngVO> prdtPrcsMoveInfo(PrdPrcsMngVO vo);
}
