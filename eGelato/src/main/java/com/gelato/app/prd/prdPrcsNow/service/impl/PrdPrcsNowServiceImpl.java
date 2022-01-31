package com.gelato.app.prd.prdPrcsNow.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.prd.prdPrcs.dao.PrdPrcsMngVO;
import com.gelato.app.prd.prdPrcsNow.dao.PrdPrcsNowMapper;
import com.gelato.app.prd.prdPrcsNow.dao.PrdPrcsNowVO;
import com.gelato.app.prd.prdPrcsNow.service.PrdPrcsNowService;
import com.gelato.app.rwmatr.order.dao.RwmatroVO;
import com.gelato.app.vr.ModifyVO;

@Service
public class PrdPrcsNowServiceImpl implements PrdPrcsNowService{

	@Autowired PrdPrcsNowMapper prdPrcsNowMapper;

	@Override
	public List<PrdPrcsNowVO> prcsDialog(PrdPrcsNowVO vo) {
		return prdPrcsNowMapper.prcsDialog(vo);
	}

	@Override
	public List<PrdPrcsNowVO> indicaDialog(PrdPrcsNowVO vo) {
		return prdPrcsNowMapper.indicaDialog(vo);
	}

	@Override
	public List<PrdPrcsNowVO> prcsList(PrdPrcsNowVO vo) {
		return prdPrcsNowMapper.prcsList(vo);
	}

	@Override
	public List<PrdPrcsNowVO> prdtInferCodeDialog(PrdPrcsNowVO vo) {
		return prdPrcsNowMapper.prdtInferCodeDialog(vo);
	}

	@Override
	public int modifyPrdtPlan(ModifyVO<PrdPrcsNowVO> mvo) {
		for(PrdPrcsNowVO vo : mvo.getUpdatedRows()) {
			System.out.println("수정");
			prdPrcsNowMapper.updateInfer(vo);
		}
		
		return 0;
	}



	

}
