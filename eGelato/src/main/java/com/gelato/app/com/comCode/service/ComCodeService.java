package com.gelato.app.com.comCode.service;

import java.util.List;

import com.gelato.app.com.comCode.dao.ComCodeVO;
import com.gelato.app.vr.ModifyVO;

public interface ComCodeService {
	
	List<ComCodeVO> findComCode (ComCodeVO vo);
	
	int modifyComCode (ModifyVO<ComCodeVO> mvo);
}
