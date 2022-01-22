package com.gelato.app.com.bomCode.service;

import java.util.List;

import com.gelato.app.com.bomCode.dao.BomCodeVO;
import com.gelato.app.vr.ModifyVO;

public interface BomCodeService {

	// BOM 전체 조회.
		List<BomCodeVO> findBomList(BomCodeVO vo);
	
	// bom 모달창에서 제품 코드 및 제품명 조회	
		List<BomCodeVO> rwmatrList();
		
		
    // 등록, 수정, 삭제는 modify.
		public int modifyBomCode(ModifyVO<BomCodeVO> mvo);
			
}
