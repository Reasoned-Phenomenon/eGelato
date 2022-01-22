package com.gelato.app.com.mkLot.dao;

public interface MkLotMapper {

	MkLotVO findSeq(String itemId);
	
	int insertGvLot(String itemId);
}
