package com.gelato.app.rwmatr.order.dao;

import java.util.List;

public interface RwmatroMapper {

	List<RwmatroVO> rwmatrOrderList(RwmatroVO vo);
	List<RwmatroVO> selectVendList(RwmatroVO vo);
	
	//발주 Insert
	int insertRwmatro(RwmatroVO vo);
	int updateRwmatro(RwmatroVO vo);
	
	//발주 디테일
	int insertRwmatroDeta(RwmatroVO vo);
	int updateRwmatroDeta(RwmatroVO vo);
	int deleteRwmatroDeta(RwmatroVO vo);
}
