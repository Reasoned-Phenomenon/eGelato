package com.gelato.app.biz.oust.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.biz.oust.dao.OustMapper;
import com.gelato.app.biz.oust.dao.OustVO;
import com.gelato.app.biz.oust.service.OustService;

@Service
public class OustServiceImpl  implements OustService {
	
	@Autowired OustMapper oustMapper;

	// 출고페이지 조회.
	@Override
	public List<OustVO> oustList() {
		
		return oustMapper.oustList();
	}

	@Override
	public List<OustVO> oustLotList(OustVO vo) {
		
		return oustMapper.oustLotList(vo);
	}
	
	
	

}
