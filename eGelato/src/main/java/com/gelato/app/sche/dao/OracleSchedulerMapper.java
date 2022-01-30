package com.gelato.app.sche.dao;

public interface OracleSchedulerMapper {

	void mkJob(OracleSchedulerVO vo);
	void startJob(OracleSchedulerVO vo);
	void stopJob(OracleSchedulerVO vo);
	
}
