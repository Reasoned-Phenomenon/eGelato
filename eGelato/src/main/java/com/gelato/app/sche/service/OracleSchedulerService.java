package com.gelato.app.sche.service;

import com.gelato.app.sche.dao.OracleSchedulerVO;

public interface OracleSchedulerService {

	String startSche (OracleSchedulerVO vo);
	String stopSche (OracleSchedulerVO vo);
	String restartSche (OracleSchedulerVO vo);
	
}
