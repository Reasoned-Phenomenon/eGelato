package com.gelato.app.com.bomCode.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.com.bomCode.dao.BomCodeMapper;
import com.gelato.app.com.bomCode.dao.BomCodeVO;
import com.gelato.app.com.bomCode.service.BomCodeService;
import com.gelato.app.vr.ModifyVO;

@Service
public class BomCodeServiceImpl implements BomCodeService {

	@Autowired BomCodeMapper bomcodeMapper;
	
	// Bom 전체 조회.
	@Override
	public List<BomCodeVO> findBomList(BomCodeVO vo) {
		
		return bomcodeMapper.findBomList(vo);
	}
	
	// modify로 등록 수정 삭제 
	@Override
	public int modifyBomCode(ModifyVO<BomCodeVO> mvo) {
			for(BomCodeVO vo : mvo.getCreatedRows()) {
				System.out.println("등록");
				bomcodeMapper.insertBomCode(vo);
			}
		return 0;
	}

	// 모달창으로 원자재 제품코드 조회.
	@Override
	public List<BomCodeVO> rwmatrList() {
		
		return bomcodeMapper.rwmatrList();
	}

}
