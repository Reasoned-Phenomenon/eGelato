package com.gelato.app.rwmatr.istInsp.dao;

import java.util.List;

public interface RwmatrIstInspMapper {

	//입고검사내역 전체조회
	List<RwmatrIstInspVO> RwmatrIstInspList(RwmatrIstInspVO vo);
	
	//입고검사할 발주디테일코드 리스트
	List<RwmatrIstInspVO> selectOrderDetail();
	
	//불량까지 등록완료시 구분자 변경
	int updateRwmatrIstInspInfer(RwmatrIstInspVO vo);
	//입고까지 등록완료시 구분자 변경
	int updateRwmatrIstInspIst(RwmatrIstInspVO vo);
	
	int insertRwmatrIstInsp(RwmatrIstInspVO vo);
	int updateRwmatrIstInsp(RwmatrIstInspVO vo);
	int deleteRwmatrIstInsp(RwmatrIstInspVO vo);
}
