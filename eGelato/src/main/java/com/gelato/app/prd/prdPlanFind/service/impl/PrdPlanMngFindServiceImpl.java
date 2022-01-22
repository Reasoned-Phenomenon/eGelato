package com.gelato.app.prd.prdPlanFind.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.prd.prdPlanFind.dao.PrdPlanMngFindMapper;
import com.gelato.app.prd.prdPlanFind.dao.PrdPlanMngFindVO;
import com.gelato.app.prd.prdPlanFind.service.PrdPlanMngFindService;

@Service
public class PrdPlanMngFindServiceImpl implements PrdPlanMngFindService{

	@Autowired PrdPlanMngFindMapper ppfMapper;
	
	@Override
	public List<PrdPlanMngFindVO> PrdtList() {
		return ppfMapper.PrdtList();
	}

	@Override
	public List<PrdPlanMngFindVO> planList(PrdPlanMngFindVO vo) {
		return ppfMapper.planList(vo);
	}
	
}
