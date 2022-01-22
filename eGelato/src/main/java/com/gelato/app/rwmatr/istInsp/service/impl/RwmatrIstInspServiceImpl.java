package com.gelato.app.rwmatr.istInsp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.rwmatr.infer.dao.RwmatrInferMapper;
import com.gelato.app.rwmatr.infer.dao.RwmatrInferVO;
import com.gelato.app.rwmatr.istInsp.dao.RwmatrIstInspMapper;
import com.gelato.app.rwmatr.istInsp.dao.RwmatrIstInspVO;
import com.gelato.app.rwmatr.istInsp.service.RwmatrIstInspService;
import com.gelato.app.vr.ModifyVO;

@Service
public class RwmatrIstInspServiceImpl implements RwmatrIstInspService {

	@Autowired RwmatrIstInspMapper rwmatrIstInspMapper;
	@Autowired RwmatrInferMapper rwmatrInferMapper;

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
			RwmatrInferVO rwmatrInferVO = new RwmatrInferVO();
			rwmatrInferVO.setRwmatrOrderDetaId(vo.getRwmatrOrderDetaId());
			rwmatrInferVO.setInferId(vo.getInferId());
			rwmatrInferVO.setDeta(vo.getDeta());
			rwmatrInferVO.setRwmatrId(vo.getRwmatrId());
			rwmatrInferVO.setQy(vo.getInferQy());
			rwmatrInferMapper.insertRwmatrInferDeta(rwmatrInferVO);
			rwmatrIstInspMapper.insertRwmatrIstInsp(vo);
			rwmatrIstInspMapper.updateRwmatrIstInspInfer(vo);
		}
		
		for(RwmatrIstInspVO vo : mvo.getUpdatedRows()) {
			System.out.println("수정");
			rwmatrIstInspMapper.updateRwmatrIstInsp(vo);
		}
		
		for(RwmatrIstInspVO vo : mvo.getDeletedRows()) {
			System.out.println("삭제");
			RwmatrInferVO rwmatrInferVO = new RwmatrInferVO();
			rwmatrInferVO.setRwmatrOrderDetaId(vo.getRwmatrOrderDetaId());
			rwmatrInferMapper.deleteRwmatrInferDeta(rwmatrInferVO);
			rwmatrIstInspMapper.deleteRwmatrIstInsp(vo);
		}
		
		return 0;
	}

	
	
}
