package com.gelato.app.rwmatr.istInsp.service;

import java.util.List;

import com.gelato.app.rwmatr.istInsp.dao.RwmatrIstInspVO;
import com.gelato.app.vr.ModifyVO;

public interface RwmatrIstInspService {

	//입고검사내역 전체조회
	List<RwmatrIstInspVO> RwmatrIstInspList(RwmatrIstInspVO vo);
	
	//입고검사할 발주디테일코드 리스트
	List<RwmatrIstInspVO> selectOrderDetail();
	
	
	public int modifyIstInsp(ModifyVO<RwmatrIstInspVO> mvo);
}
