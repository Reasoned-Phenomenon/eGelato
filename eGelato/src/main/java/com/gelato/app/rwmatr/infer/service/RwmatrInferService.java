package com.gelato.app.rwmatr.infer.service;

import java.util.List;

import com.gelato.app.rwmatr.infer.dao.RwmatrInferVO;
import com.gelato.app.vr.ModifyVO;

public interface RwmatrInferService {
	
	//자재 불량내역 전체조회
	List<RwmatrInferVO> RwmatrInferList(RwmatrInferVO vo);
	
	public int modifyRwmatrInfer(ModifyVO<RwmatrInferVO> mvo);
}
