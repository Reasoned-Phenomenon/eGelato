package com.gelato.app.biz.oust.dao;

import java.util.List;



public interface OustMapper {
	
	// 출고 조회 (그리드1)(주문서 테이블 + 주문서 디테일 테이블)
	List<OustVO> oustList();
	
	// 출고 관리 그리드2 (입출고 테이블)
	List<OustVO> prdtInstOust(OustVO vo);
	
	// 완제품 재고 조회 modal.(완제품 재고 테이블)
	List<OustVO> prdtStcList(OustVO vo);
	
	// 완제품 재고 테이블과 주문서테이블, 입출고테이블,출고테이블 insert 및 update 프로시저. 
	int insertOust(OustVO vo);
	

}
