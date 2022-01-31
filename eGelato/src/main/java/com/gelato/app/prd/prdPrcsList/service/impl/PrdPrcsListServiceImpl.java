package com.gelato.app.prd.prdPrcsList.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.prd.prdPrcsList.dao.PrdPrcsListMapper;
import com.gelato.app.prd.prdPrcsList.dao.PrdPrcsListVO;
import com.gelato.app.prd.prdPrcsList.service.PrdPrcsListService;
import com.gelato.app.vr.ModifyVO;

@Service
public class PrdPrcsListServiceImpl implements PrdPrcsListService{

	@Autowired PrdPrcsListMapper prdPrcsListMapper;

	@Override
	public List<PrdPrcsListVO> prcsMngList(PrdPrcsListVO vo) {
		return prdPrcsListMapper.prcsMngList(vo);
	}

	@Override
	public List<PrdPrcsListVO> unUseEqmList() {
		return prdPrcsListMapper.unUseEqmList();
	}

	@Override
	public int modifyPrcs(ModifyVO<PrdPrcsListVO> mvo) {
		
		for(PrdPrcsListVO vo : mvo.getCreatedRows()) {
			System.out.println("등록");
			prdPrcsListMapper.insertPrcsDeta(vo);
		}
		
		for(PrdPrcsListVO vo : mvo.getUpdatedRows()) {
			System.out.println("수정");
			prdPrcsListMapper.updatePrcsDeta(vo);
		}
		
		for(PrdPrcsListVO vo : mvo.getDeletedRows()) {
			System.out.println("삭제");
			prdPrcsListMapper.deletePrcsDeta(vo);
		}
		return 0;
	}
}
