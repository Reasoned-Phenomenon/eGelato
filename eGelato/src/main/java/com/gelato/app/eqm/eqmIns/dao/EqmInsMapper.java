package com.gelato.app.eqm.eqmIns.dao;

import java.util.List;

public interface EqmInsMapper {
	//점검리스트 - 모달
	List<EqmInsVO> eqmChck(EqmInsVO eqmInsVo);
	
	//점검리스트 - 그리드
	List<EqmInsVO> eqmInsList(EqmInsVO eqmInsVo);
	
	//점검등록
	int insertChck(EqmInsVO eqmInsVo);
}
