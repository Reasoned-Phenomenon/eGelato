package com.gelato.app.biz.eprd.dao;

import java.util.List;

public interface EproductMapper {

	//완제품 현재고
	List<EproductVO> EproductStcList(EproductVO vo);
	
	//완제품 입고
	List<EproductVO> EproductIstList(EproductVO vo);
	
	//완제품 출고
	List<EproductVO> EproductOustList(EproductVO vo);
}
