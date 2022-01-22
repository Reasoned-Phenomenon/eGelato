package com.gelato.app.rwmatr.infer.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.rwmatr.infer.dao.RwmatrInferMapper;
import com.gelato.app.rwmatr.infer.dao.RwmatrInferVO;
import com.gelato.app.rwmatr.infer.service.RwmatrInferService;
import com.gelato.app.rwmatr.istInsp.dao.RwmatrIstInspMapper;
import com.gelato.app.vr.ModifyVO;

@Service
public class RwmatrInferServiceImpl implements RwmatrInferService {

	@Autowired RwmatrInferMapper rwmatrInferMapper;
	@Autowired RwmatrIstInspMapper rwmatrIstInspMapper;
	
	@Override
	public List<RwmatrInferVO> RwmatrInferList(RwmatrInferVO vo) {
		return rwmatrInferMapper.RwmatrInferList(vo);
	}

	@Override
	public List<RwmatrInferVO> RwmatrFailList(RwmatrInferVO vo) {
		return rwmatrInferMapper.RwmatrFailList(vo);
	}
	
	@Override
	public List<RwmatrInferVO> RmatrInferCodeList(RwmatrInferVO vo) {
		return rwmatrInferMapper.RmatrInferCodeList(vo);
	}
	
	public int modifyRwmatrInfer(ModifyVO<RwmatrInferVO> mvo) {
		
		for(RwmatrInferVO vo : mvo.getCreatedRows()) {
			System.out.println("추가");
			rwmatrInferMapper.insertRwmatrInferDeta(vo);
		}
		
		for(RwmatrInferVO vo : mvo.getUpdatedRows()) {
			System.out.println("수정");
			rwmatrInferMapper.updateRwmatrInferDeta(vo);
		}
		
		for(RwmatrInferVO vo : mvo.getDeletedRows()) {
			System.out.println("삭제");
			rwmatrInferMapper.deleteRwmatrInferDeta(vo);
		}
		return 0;
	}

}
