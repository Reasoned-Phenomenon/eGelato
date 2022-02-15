package com.gelato.app.prd.prdIndica.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.prd.prdIndica.dao.PrdIndicaMngMapper;
import com.gelato.app.prd.prdIndica.dao.PrdIndicaMngVO;
import com.gelato.app.prd.prdIndica.service.PrdIndicaMngService;
import com.gelato.app.vr.ModifyVO;

@Service
public class PrdIndicaMngImpl implements PrdIndicaMngService{

	@Autowired PrdIndicaMngMapper pimMapper;
	
	@Override
	public List<PrdIndicaMngVO> nonIndicaList() {
		return pimMapper.nonIndicaList();
	}

	@Override
	public List<PrdIndicaMngVO> choosePlan(PrdIndicaMngVO vo) {
		return pimMapper.choosePlan(vo);
	}

	@Override
	public PrdIndicaMngVO choosePlanDetaId(PrdIndicaMngVO vo) {
		return pimMapper.choosePlanDetaId(vo);
	}

	@Override
	public List<PrdIndicaMngVO> chooseIndicaQy(PrdIndicaMngVO vo) {
		return pimMapper.chooseIndicaQy(vo);
	}

	@Override
	public List<PrdIndicaMngVO> chooseRwmatrId(PrdIndicaMngVO vo) {
		return pimMapper.chooseRwmatrId(vo);
	}

	String indicaId = null;
	
	@Override
	public int insertPrdIndica(List<PrdIndicaMngVO> vo) {
		System.out.println(565656);
		System.out.println(vo);
		 
		// 생산지시T insert
		 /* for( i = 0 ; i < mvo.getUpdatedRows().size() ; i++) {
			  System.out.println(mvo.getUpdatedRows().get(i).getFg());
			  if(mvo.getUpdatedRows().get(i).getFg() != "") {
				  System.out.println("생산지시 추가"); 
				  ivo = mvo.getUpdatedRows().get(i);
				  System.out.println(ivo); 
				  pimMapper.insertPrdIndica(ivo);
				  System.out.println("지시 추가 완료");
		  
		    for( vo : mvo.getUpdatedRows()) { System.out.println(vo);
		  vo.setIndicaId(ivo.getIndicaId()); indicaId = vo.getIndicaId();
		  System.out.println(indicaId); } } else { System.out.println("생산지시 제외"); 
			  } 
		  }*/
		
		pimMapper.insertPrdIndica(vo.get(0).getPlanDetaId());
		System.out.println(vo);
		return 0;
	}

	@Override
	public int insertPrdIdicaDeta(List<PrdIndicaMngVO> vo) {
		int i = 0;
		//생산지시DT insert
		
		System.out.println(vo);
		for (i=0 ; i<vo.size() ; i++) {
			if(vo.get(i).getFg() != "") {
				System.out.println("생산지시디테일추가");
				System.out.println(vo.get(i).getFg());
				System.out.println(vo.get(i));
				pimMapper.insertPrdIdicaDeta(vo.get(i));
			} else {
				System.out.println("생산지시디테일제외");
				System.out.println(vo.get(i));
			}
		}
		return 0;
	}

	@Override
	public int insertInptRwmatr(List<PrdIndicaMngVO> vo) {
		System.out.println("원자재투입");
		System.out.println(vo);
		int i=0;
		
		//투입원자재 insert
		for(i=0 ; i<vo.size() ; i++) {
			System.out.println(vo.get(i));
			pimMapper.insertInptRwmatr(vo.get(i));
		}
		return 0;
	}

	@Override
	public int updateExcp(List<PrdIndicaMngVO> vo) {
		System.out.println("홀딩값 upd");
		System.out.println(vo);
		int i=0;
		
		for(i=0 ; i<vo.size() ; i++) {
			System.out.println(i);
			System.out.println(vo.get(i));
			pimMapper.updateExcp(vo.get(i));
		}
		return 0;
	}

	@Override
	public int updateRwmatrStc(List<PrdIndicaMngVO> vo) {
		System.out.println("현재고 upd");
		System.out.println(vo);
		int i=0;
		
		for(i=0 ; i<vo.size() ; i++) {
			System.out.println(i);
			System.out.println(vo.get(i));
			pimMapper.updateRwmatrStc(vo.get(i));
		}
		return 0;
	}

	@Override
	public int insertRwmatrIstOust(List<PrdIndicaMngVO> vo) {
		System.out.println("원자재 입출고 insert");
		int i=0;
		
		for(i=0 ; i<vo.size() ; i++) {
			System.out.println(i);
			System.out.println(vo.get(i));
			pimMapper.insertRwmatrIstOust(vo.get(i));
			System.out.println("------------------------------------------------------------");
		}
		return 0;
	}



}
