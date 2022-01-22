package com.gelato.app.rwmatr.order.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.rwmatr.order.dao.RwmatroMapper;
import com.gelato.app.rwmatr.order.dao.RwmatroVO;
import com.gelato.app.rwmatr.order.service.RwmatroService;
import com.gelato.app.vr.ModifyVO;

@Service
public class RwmatroServiceImpl implements RwmatroService {

	@Autowired RwmatroMapper rwmatroMapper;
	
	@Override
	public List<RwmatroVO> rwmatrOrderList(RwmatroVO vo) {
		return rwmatroMapper.rwmatrOrderList(vo);
	}
	
	@Override
	public List<RwmatroVO> selectVendList(RwmatroVO vo) {
		return rwmatroMapper.selectVendList(vo);
	}

	@Override
	public int modifyRwmatro(ModifyVO<RwmatroVO> mvo) {
		RwmatroVO oi = null;
		if(!mvo.getCreatedRows().isEmpty()) {
			System.out.println("발주번호 추가");
			oi = mvo.getCreatedRows().get(0);
			rwmatroMapper.insertRwmatro(oi);
		}
		for(RwmatroVO vo : mvo.getCreatedRows()) {
			vo.setOrderId(oi.getOrderId());
//			if(vo.getOrderId() == "") {
//				System.out.println("발주번호 추가");
//				rwmatroMapper.insertRwmatro(vo);
//			}
			System.out.println("발주디테일코드 추가");
			rwmatroMapper.insertRwmatroDeta(vo);
		}
		
		for(RwmatroVO vo : mvo.getUpdatedRows()) {
			System.out.println("수정");
			rwmatroMapper.updateRwmatro(vo);
			rwmatroMapper.updateRwmatroDeta(vo);
		}
		
		for(RwmatroVO vo : mvo.getDeletedRows()) {
			System.out.println("삭제");
			rwmatroMapper.deleteRwmatroDeta(vo);
		}
		
		return 0;
	}

}
