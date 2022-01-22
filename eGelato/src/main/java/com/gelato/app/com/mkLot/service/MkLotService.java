package com.gelato.app.com.mkLot.service;

import com.gelato.app.com.mkLot.dao.MkLotVO;

public interface MkLotService {

	MkLotVO findSeq(String itemId);
	
	int insertGvLot(String itemId);
}
