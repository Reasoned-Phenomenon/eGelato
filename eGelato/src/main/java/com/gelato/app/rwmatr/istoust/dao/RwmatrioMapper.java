package com.gelato.app.rwmatr.istoust.dao;

import java.util.List;

public interface RwmatrioMapper {

	//입고 관리 전체조회
	List<RwmatrioVO> RwmatrIstList(RwmatrioVO vo);
	
	//검수 완료 리스트 조회
	List<RwmatrioVO> RwmatrPassList(RwmatrioVO vo);
	
	//출고 관리 전체조회
	List<RwmatrioVO> RwmatrOustList(RwmatrioVO vo);
	
	//자재 현재고 전체조회
	List<RwmatrioVO> RwmatrStcList(RwmatrioVO vo);
	
	//자재 현재고 전체조회(모달)
	List<RwmatrioVO> RwmatrStcMList(RwmatrioVO vo);
	
	//자재입고관리 추가
	int insertRwmatrIst(RwmatrioVO vo);
	
	//자재입고관리 수정
	int updateRwmatrIst(RwmatrioVO vo);
	
	//자재입고관리 삭제
	int deleteRwmatrIst(RwmatrioVO vo);
	
	//자재출고관리 추가
	int insertRwmatrOust(RwmatrioVO vo);
	
	//자재출고관리 수정
	int updateRwmatrOust(RwmatrioVO vo);
	
	//자재출고관리 삭제
	int deleteRwmatrOust(RwmatrioVO vo);
	
	//현재고 추가
	int insertRwmatrStc(RwmatrioVO vo);
	
	//현재고 수정
	int updateRwmatrStc(RwmatrioVO vo);
	
	//현재고 수정
	int updateRwmatrStcD(RwmatrioVO vo);
	
	//현재고 삭제
	int deleteRwmatrStc(RwmatrioVO vo);
	
}
