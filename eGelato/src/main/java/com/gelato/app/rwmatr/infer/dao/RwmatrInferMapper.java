package com.gelato.app.rwmatr.infer.dao;

import java.util.List;

public interface RwmatrInferMapper {

	//자재 불량내역 전체조회
	List<RwmatrInferVO> RwmatrInferList(RwmatrInferVO vo);
	
	//불량내역 CUD
	int insertRwmatrInferDeta(RwmatrInferVO vo);
	int updateRwmatrInferDeta(RwmatrInferVO vo);
	int deleteRwmatrInferDeta(RwmatrInferVO vo);
	
}
