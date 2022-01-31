package com.gelato.app.rwmatr.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.rwmatr.dao.RwmatrMapper;
import com.gelato.app.rwmatr.dao.RwmatrVO;
import com.gelato.app.rwmatr.service.RwmatrService;
import com.gelato.app.vr.ModifyVO;

@Service
public class RwmatrServiceImpl implements RwmatrService {

	@Autowired RwmatrMapper rwmatrMapper;
	
	@Override
	public List<RwmatrVO> rwmatrList(RwmatrVO vo) {
		return rwmatrMapper.rwmatrList(vo);
	}

	@Override
	public List<RwmatrVO> rwmatrSafStcList(RwmatrVO vo) {
		return rwmatrMapper.rwmatrSafStcList(vo);
	}

	@Override
	public int modifyRwmatr(ModifyVO<RwmatrVO> mvo) {
		
		for(RwmatrVO vo : mvo.getUpdatedRows()) {
			System.out.println("수정");
			rwmatrMapper.updateRwmatr(vo);
		}
		
		return 0;
	}

}
