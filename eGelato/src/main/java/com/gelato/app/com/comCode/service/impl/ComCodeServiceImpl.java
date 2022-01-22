package com.gelato.app.com.comCode.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.com.comCode.dao.ComCodeMapper;
import com.gelato.app.com.comCode.dao.ComCodeVO;
import com.gelato.app.com.comCode.service.ComCodeService;
import com.gelato.app.vr.ModifyVO;

@Service
public class ComCodeServiceImpl implements ComCodeService {

	@Autowired ComCodeMapper mapper;
	
	@Override
	public List<ComCodeVO> findComCode(ComCodeVO vo) {
		return mapper.findComCode(vo);
	}

	@Override
	public int modifyComCode(ModifyVO<ComCodeVO> mvo) {
		
		for(ComCodeVO vo : mvo.getCreatedRows()) {
			mapper.insertComCode(vo);
		}
		
		for(ComCodeVO vo : mvo.getUpdatedRows()) {
			mapper.updateComCode(vo);
		}
		
		for(ComCodeVO vo : mvo.getDeletedRows()) {
			mapper.deleteComCode(vo);
		}
		
		return 0;
	}

	
}
