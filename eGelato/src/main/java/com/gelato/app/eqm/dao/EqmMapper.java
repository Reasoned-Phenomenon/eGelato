package com.gelato.app.eqm.dao;

import java.util.List;
  
public interface EqmMapper {
	
	//설비등록
	int insertEqm(EqmVO eqmVo);
	
	//설비전제조회
	List<EqmVO> eqmList(EqmVO eqmVo);
	
	//설비단건조회
	EqmVO eqmSelect(EqmVO eqmVo);
	
	//설비수정
	int eqmUpdate(EqmVO eqmVo);
	
	//설비삭제
	int eqmDelete(EqmVO eqmVo);
	
	
}
