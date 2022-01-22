package com.gelato.app.rwmatr.istInsp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.rwmatr.istInsp.dao.RwmatrIstInspMapper;
import com.gelato.app.rwmatr.istInsp.dao.RwmatrIstInspVO;
import com.gelato.app.rwmatr.istInsp.service.RwmatrIstInspService;
import com.gelato.app.vr.ModifyVO;

@Service
public class RwmatrIstInspServiceImpl implements RwmatrIstInspService {

	@Autowired RwmatrIstInspMapper rwmatrIstInspMapper;

	@Override
	public List<RwmatrIstInspVO> RwmatrIstInspList(RwmatrIstInspVO vo) {
		return rwmatrIstInspMapper.RwmatrIstInspList(vo);
	}
	
	@Override
	public List<RwmatrIstInspVO> selectOrderDetail() {
		return rwmatrIstInspMapper.selectOrderDetail();
	}

	@Override
	public int modifyIstInsp(ModifyVO<RwmatrIstInspVO> mvo) {
		for(RwmatrIstInspVO vo : mvo.getCreatedRows()) {
			System.out.println("추가");
			rwmatrIstInspMapper.insertRwmatrIstInsp(vo);
		}
		
		for(RwmatrIstInspVO vo : mvo.getUpdatedRows()) {
			System.out.println("수정");
			rwmatrIstInspMapper.updateRwmatrIstInsp(vo);
		}
		
		for(RwmatrIstInspVO vo : mvo.getDeletedRows()) {
			System.out.println("삭제");
			rwmatrIstInspMapper.deleteRwmatrIstInsp(vo);
		}
		
		return 0;
	}
	
}
