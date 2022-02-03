package com.gelato.app.rwmatr.service;

import java.util.List;

import com.gelato.app.rwmatr.dao.RwmatrVO;
import com.gelato.app.vr.ModifyVO;

public interface RwmatrService {
	
	List<RwmatrVO> rwmatrList(RwmatrVO vo);
	
	List<RwmatrVO> rwmatrSafStcList(RwmatrVO vo);
	
	List<RwmatrVO> rwmatrUphList(RwmatrVO vo);
	
	public int modifyRwmatr(ModifyVO<RwmatrVO> mvo);
}
