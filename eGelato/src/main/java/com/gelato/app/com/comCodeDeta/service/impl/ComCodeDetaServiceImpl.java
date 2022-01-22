package com.gelato.app.com.comCodeDeta.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.com.comCodeDeta.dao.ComCodeDetaMapper;
import com.gelato.app.com.comCodeDeta.dao.ComCodeDetaVO;
import com.gelato.app.com.comCodeDeta.service.ComCodeDetaService;
import com.gelato.app.vr.ModifyVO;

@Service
public class ComCodeDetaServiceImpl implements ComCodeDetaService {

	@Autowired ComCodeDetaMapper detaMapper;
	
	@Override
	public List<ComCodeDetaVO> findComCodeDeta(ComCodeDetaVO vo) {
		return detaMapper.findComCodeDeta(vo);
	}

	@Override
	public Map findComCodeProcedure(Map map) {
		return detaMapper.findComCodeProcedure(map);
	}

	@Override
	public int modifyComCodeDeta(ModifyVO<ComCodeDetaVO> mvo) {
		
		for(ComCodeDetaVO vo : mvo.getCreatedRows()) {
			detaMapper.insertComCodeDeta(vo);
		}
		
		for(ComCodeDetaVO vo : mvo.getUpdatedRows()) {
			System.out.println(vo.getCode());
			detaMapper.updateComCodeDeta(vo);
		}
		
		for(ComCodeDetaVO vo : mvo.getDeletedRows()) {
			detaMapper.deleteComCodeDeta(vo);
		}
		
		return 0;
	}

}
