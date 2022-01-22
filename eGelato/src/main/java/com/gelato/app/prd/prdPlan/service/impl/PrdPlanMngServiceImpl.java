package com.gelato.app.prd.prdPlan.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gelato.app.prd.prdPlan.dao.PrdPlanMngMapper;
import com.gelato.app.prd.prdPlan.dao.PrdPlanMngVO;
import com.gelato.app.prd.prdPlan.service.PrdPlanMngService;
import com.gelato.app.rwmatr.order.dao.RwmatroVO;
import com.gelato.app.vr.ModifyVO;

@Service
public class PrdPlanMngServiceImpl implements PrdPlanMngService{

	@Autowired PrdPlanMngMapper ppmMapper;

	@Override
	public List<PrdPlanMngVO> OrderShtList() {
		return ppmMapper.OrderShtList();
	}

	@Override
	public List<PrdPlanMngVO> SearchPlanList(PrdPlanMngVO vo) {
		return ppmMapper.SearchPlanList(vo);
	}

	@Override
	public List<PrdPlanMngVO> ChooseOrder(PrdPlanMngVO vo) {
		return ppmMapper.ChooseOrder(vo);
	}

	@Override
	public List<PrdPlanMngVO> PrdtList() {
		return ppmMapper.PrdtList();
	}

	@Override
	public int modifyPrdPlan(ModifyVO<PrdPlanMngVO> mvo) {
		PrdPlanMngVO pvo = null;
		// 주문서 - 테이블 insert
		if(!mvo.getUpdatedRows().isEmpty()) {
			System.out.println("주문코드 추가");
			pvo = mvo.getUpdatedRows().get(0);
			System.out.println(pvo);
			ppmMapper.insertPrdPlan(pvo);
			//ppmMapper.updateOrderSht(pvo);
			System.out.println("성공");
		}
		for(PrdPlanMngVO vo : mvo.getUpdatedRows()) {
			/*
			 * System.out.println(9999); System.out.println(mvo.getUpdatedRows());
			 * System.out.println(pvo.getPlanId());
			 */
			System.out.println(vo);
			vo.setPlanId(pvo.getPlanId());
			System.out.println("주문디테일코드 추가");
			ppmMapper.insertPrdPlanDeta(vo);
		}
		
		// 안전재고 - insert
		if(!mvo.getCreatedRows().isEmpty()) {
			System.out.println("주문코드 추가 - 재고추가");
			pvo = mvo.getCreatedRows().get(0);
			System.out.println(pvo);
			ppmMapper.insertPrdPlan(pvo);
			System.out.println("성공");
		}
		for(PrdPlanMngVO vo : mvo.getCreatedRows()) {
			/*
			 * System.out.println(9999); System.out.println(mvo.getUpdatedRows());
			 * System.out.println(pvo.getPlanId());
			 */
			System.out.println(vo);
			vo.setPlanId(pvo.getPlanId());
			System.out.println("주문디테일코드 - 재고추가");
			ppmMapper.insertPrdPlanDeta(vo);
		}
		
		return 0;
	}

	@Override
	public int modifyCanPrdPlan(ModifyVO<PrdPlanMngVO> mvo) {
		PrdPlanMngVO pvo = null;

		// 계획취소 - update
		if(!mvo.getUpdatedRows().isEmpty()) {
			System.out.println("계획취소");
			ppmMapper.updatePrdPlanDeta(mvo.getUpdatedRows().get(0));
			System.out.println("계획취소impl 끝");
			System.out.println("홀딩값 삭제");
			ppmMapper.deleteExcp(mvo.getUpdatedRows().get(0));
			System.out.println("홀딩값 삭제 끝");
		}
		
		return 0;
		
	}

	@Override
	public int modifyExcp(ModifyVO<PrdPlanMngVO> mvo) {
		System.out.println("홀딩값 추가22222");
		if(!mvo.getUpdatedRows().isEmpty()) {
			ppmMapper.insertExcp(mvo.getUpdatedRows().get(0));
		}
		if(!mvo.getCreatedRows().isEmpty()) {
			ppmMapper.insertExcp(mvo.getCreatedRows().get(0));
		}
		return 0;
	}

	
	
}
