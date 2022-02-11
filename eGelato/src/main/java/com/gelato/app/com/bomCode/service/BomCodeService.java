package com.gelato.app.com.bomCode.service;

import java.util.List;

import com.gelato.app.com.bomCode.dao.BomCodeVO;
import com.gelato.app.vr.ModifyVO;

public interface BomCodeService {

	// BOM 전체 조회.
		List<BomCodeVO> findBomList(BomCodeVO vo);
	
	// bom 모달창에서 제품 코드 및 제품명 조회	
		List<BomCodeVO> rwmatrList();
	
	// bom코드관리에서 그리드 셀 클릭하면 제품 코드 조회
		List<BomCodeVO> rwmatrCodeList();	
		
	// bom코드관리에서 그리드 공정코드 셀 클릭하면 공정코드 조회.
	  List<BomCodeVO> prcsCodeList(BomCodeVO vo);
		
		
    // 등록, 수정, 삭제는 modify.
		public int modifyBomCode(ModifyVO<BomCodeVO> mvo);
			
}
