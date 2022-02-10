package com.gelato.app.biz.oust.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.biz.oust.dao.OustMapper;
import com.gelato.app.biz.oust.dao.OustVO;
import com.gelato.app.biz.oust.service.OustService;
import com.gelato.app.vr.ModifyVO;

@Service
public class OustServiceImpl  implements OustService {
	
	@Autowired OustMapper oustMapper;

	// 출고페이지 조회.(그리드1)
	@Override
	public List<OustVO> oustList() {
		
		return oustMapper.oustList();
	}

	// 완제품 입출고 조회.(그리드2)
	@Override
	public List<OustVO> prdtInstOust(OustVO vo) {
		
		return oustMapper.prdtInstOust(vo);
	}

	// 완제품 재고 modal 조회.
	@Override
	public List<OustVO> prdtStcList(OustVO vo) {
		
		return oustMapper.prdtStcList(vo);
	}
    
	// modify - 완제품 재고 테이블과 주문서테이블, 입출고테이블,출고테이블 insert 및 update 프로시저.
	@Override
	public int modifyOust(ModifyVO<OustVO> mvo) {
		
		for(OustVO vo : mvo.getCreatedRows()) {
			System.out.println("등록");
			oustMapper.insertOust(vo);
		}
		
		for(OustVO vo : mvo.getUpdatedRows()) {
			System.out.println("수정");
			oustMapper.insertOust(vo);
		}
		
		return 0;
	}

	
	
	
	

}
