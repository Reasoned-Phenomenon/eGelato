package com.gelato.app.prd.prdPrcs.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.prd.prdPrcs.dao.OracleSchedulerMapper;
import com.gelato.app.prd.prdPrcs.dao.PrdPrcsMngMapper;
import com.gelato.app.prd.prdPrcs.dao.PrdPrcsMngVO;
import com.gelato.app.prd.prdPrcs.service.PrdPrcsMngService;
import com.gelato.app.vr.ModifyVO;

@Service
public class PrdPrcsMngServiceImpl implements PrdPrcsMngService{

	@Autowired PrdPrcsMngMapper ppmMapper;
	@Autowired OracleSchedulerMapper mapper;

	@Override
	public List<PrdPrcsMngVO> chooseIndica(PrdPrcsMngVO vo) {
		return ppmMapper.chooseIndica(vo);
	}

	@Override
	public List<PrdPrcsMngVO> selectIndica(PrdPrcsMngVO vo) {
		return ppmMapper.selectIndica(vo);
	}

	@Override
	public List<PrdPrcsMngVO> prcsList(PrdPrcsMngVO vo) {
		
		List<PrdPrcsMngVO> list =  new ArrayList<PrdPrcsMngVO>();
		
		list = ppmMapper.prcsList(vo);
		
		System.out.println(list);
		
		for(int i = 0; i < list.size() ; i++) {
			String lnn = "000"+Integer.toString(i+1);
			String pnId = list.get(i).getPrcsNowId().substring(0, 7) + "-" + lnn.substring(lnn.length()-3, lnn.length());
			list.get(i).setPrcsNowId(pnId);
		}
		
		return list;
	}

	@Override
	public int modifyPrcs(ModifyVO<PrdPrcsMngVO> mvo) {
		
		for(PrdPrcsMngVO vo : mvo.getUpdatedRows()) {
			System.out.println(vo);
			
			System.out.println("현재공정등록");
			ppmMapper.insertPrcsNow(vo);
			
			System.out.println("공정상태등록");
			ppmMapper.insertPrcsSt(vo);
			
		}
		return 0;
	}

	@Override
	public int prcsStStop(List<PrdPrcsMngVO> vo) {
		System.out.println("공정중지");
		System.out.println(vo);
		int i=0;
		
		for(i=0 ; i<vo.size() ; i++) {
			System.out.println(vo.get(i));
			ppmMapper.prcsStStop(vo.get(i));
		}
		
		return 0;
	}

	@Override
	public int prcsStRest(List<PrdPrcsMngVO> vo) {
		System.out.println("공정재시작");
		System.out.println(vo);
		int i=0;
		
		for(i=0 ; i<vo.size() ; i++) {
			System.out.println(vo.get(i));
			ppmMapper.prcsStRest(vo.get(i));
		}
		return 0;
	}

	@Override
	public String startSche(PrdPrcsMngVO vo) {
		
		// 라인에 있는 공정들 FOR문 돌리면 됨 
		mapper.mkJob(vo);
		//
		return null;
	}

	@Override
	public String stopSche(PrdPrcsMngVO vo) {
		
		//정지 시킬 잡 FOR문 + prcs_st
		//
		mapper.stopJob(vo);
		//
		
		return null;
	}

	@Override
	public String restartSche(PrdPrcsMngVO vo) {
		
		//시작시킬 잡 FOR문
		mapper.startJob(vo);
		//
				
		return null;
	}
	

}
