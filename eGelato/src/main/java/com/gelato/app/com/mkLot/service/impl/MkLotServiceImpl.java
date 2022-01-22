package com.gelato.app.com.mkLot.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.com.mkLot.dao.MkLotMapper;
import com.gelato.app.com.mkLot.dao.MkLotVO;
import com.gelato.app.com.mkLot.service.MkLotService;

@Service
public class MkLotServiceImpl implements MkLotService {

	@Autowired MkLotMapper mapper;
	
	@Override
	public MkLotVO findSeq(String itemId) {
		return mapper.findSeq(itemId);
	}

	@Override
	public int insertGvLot(String itemId) {
		return mapper.insertGvLot(itemId);
	}

}
