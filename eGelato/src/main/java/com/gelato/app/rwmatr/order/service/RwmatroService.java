package com.gelato.app.rwmatr.order.service;

import java.util.List;

import com.gelato.app.rwmatr.order.dao.RwmatroVO;
import com.gelato.app.vr.ModifyVO;

public interface RwmatroService {

	List<RwmatroVO> rwmatrOrderMasterList(RwmatroVO vo);
	
	List<RwmatroVO> rwmatrOrderSubList(RwmatroVO vo);
	
	List<RwmatroVO> rwmatrOrderList(RwmatroVO vo);
	
	List<RwmatroVO> selectVendList(RwmatroVO vo);
	
	public int modifyRwmatro(ModifyVO<RwmatroVO> mvo);
	
}
