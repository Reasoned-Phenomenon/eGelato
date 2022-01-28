package com.gelato.app.prd.prdPrcs.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.prd.prdPrcs.dao.PrdPrcsMngMapper;
import com.gelato.app.prd.prdPrcs.dao.PrdPrcsMngVO;
import com.gelato.app.prd.prdPrcs.service.PrdPrcsMngService;

@Service
public class PrdPrcsMngServiceImpl implements PrdPrcsMngService{

	@Autowired PrdPrcsMngMapper ppmMapper;

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
		
		// 리스트에 담아서 for문 돌리기
		// 뭔말이야
		// 무슨 말인지 모르겠어..ㅠㅠㅠㅠㅠㅠㅠ
		
		List<PrdPrcsMngVO> list =  new ArrayList<PrdPrcsMngVO>();
		
		list = ppmMapper.prcsList(vo);
		
		System.out.println(list);
		
		for(int i = 0; i < list.size() ; i++) {
			System.out.println("11112222211112222");
			System.out.println(list.get(i).getPrcsNowId());
			System.out.println(list.get(i).getPrcsNowId().substring(10));
			
			String lnn = "000"+Integer.toString(i+1);
			System.out.println(lnn);
			
			String pnId = list.get(i).getPrcsNowId().substring(0, 7) + "-" + lnn.substring(lnn.length()-3, lnn.length());
			System.out.println(pnId);
			
			list.get(i).setPrcsNowId(pnId);
		}
		
		return list;
	}

}
