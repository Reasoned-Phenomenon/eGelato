package com.gelato.app.com.bomCode.dao;

import java.util.List;

public interface BomCodeMapper { //이 맵퍼 이름이 -mapper.xml 맵퍼 네임주소와 같아야 한다.
	
	// BOM 전체 조회.
	List<BomCodeVO> findBomList(BomCodeVO vo);
	
	
	// bom 모달창에서 제품 코드 및 제품명 조회	
	List<BomCodeVO> rwmatrList();
	
	// bom코드관리에서 그리드 셀 클릭하면 제품 코드 조회
	List<BomCodeVO> rwmatrCodeList();
	
	// bom코드관리에서 그리드 공정코드 셀 클릭하면 공정코드 조회.
	List<BomCodeVO> prcsCodeList();
	
	
	// 등록.
	int insertBomCode(BomCodeVO vo);
	
	// 수정.
	int updateBomCode(BomCodeVO vo); 
}
