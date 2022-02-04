package com.gelato.app.prd.prdPrcs.dao;

public interface OracleSchedulerMapper {

	void mkJob(PrdPrcsMngVO vo);
	void startJob(PrdPrcsMngVO vo);
	void stopJob(PrdPrcsMngVO vo);
	
}
