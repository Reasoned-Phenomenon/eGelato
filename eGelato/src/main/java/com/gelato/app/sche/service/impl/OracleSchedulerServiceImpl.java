package com.gelato.app.sche.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.sche.dao.OracleSchedulerMapper;
import com.gelato.app.sche.dao.OracleSchedulerVO;
import com.gelato.app.sche.service.OracleSchedulerService;

@Service
public class OracleSchedulerServiceImpl implements OracleSchedulerService {

	@Autowired OracleSchedulerMapper mapper;

	@Override
	public String startSche(OracleSchedulerVO vo) {
		
		// 라인에 있는 공정들 FOR문 돌리면 됨 
		mapper.mkJob(vo);
		//
		
		return null;
	}

	@Override
	public String stopSche(OracleSchedulerVO vo) {
		
		//정지 시킬 잡 FOR문
		mapper.stopJob(vo);
		//
		
		return null;
	}

	@Override
	public String restartSche(OracleSchedulerVO vo) {
		
		//시작시킬 잡 FOR문
		mapper.startJob(vo);
		//
				
		return null;
	}

	
	
	

}
