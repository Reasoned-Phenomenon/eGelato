package com.gelato.app.prd.prdLine.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.prd.prdLine.dao.PrdLineMngMapper;
import com.gelato.app.prd.prdLine.dao.PrdLineMngVO;
import com.gelato.app.prd.prdLine.service.PrdLineMngService;
import com.gelato.app.vr.ModifyVO;

@Service
public class PrdLineMngServiceImpl implements PrdLineMngService{

	@Autowired PrdLineMngMapper plMapper;

	@Override
	public List<PrdLineMngVO> lineGrid() {
		return plMapper.lineGrid();
	}

	@Override
	public List<PrdLineMngVO> linePrcsGrid(PrdLineMngVO vo) {
		return plMapper.linePrcsGrid(vo);
	}

	@Override
	public int modifyLine(ModifyVO<PrdLineMngVO> mvo) {
		PrdLineMngVO pvo = null;
		
		for(PrdLineMngVO vo : mvo.getCreatedRows()) {
			System.out.println(vo);
			System.out.println(vo.getLineId());

			pvo = mvo.getCreatedRows().get(0);
			System.out.println(pvo.getLineId());
			vo.setLineId(pvo.getLineId());
			
			if(pvo.getLineId() != "") {
				if (vo.getOrd() != null) {
					System.out.println("단건추가");
					plMapper.insertPrcsDeta(vo);
				}
				System.out.println("ord업데이트");
				plMapper.updateLineOrd(vo);
			} else {
				System.out.println("다중추가");
				plMapper.insertLineDeta(pvo);
				
				System.out.println("ord업데이트");
				plMapper.updateLineOrd(vo);
			}
		}
		
		for(PrdLineMngVO vo : mvo.getDeletedRows()) {
			System.out.println(vo);
			System.out.println("행삭제");
			plMapper.deleteLineDeta(vo);
			System.out.println("ord업데이트");
			plMapper.updateLineOrd(vo);
		}
		
		for(PrdLineMngVO vo : mvo.getUpdatedRows()) {
			System.out.println("공정수정");
			plMapper.updateLineDeta(vo);
			System.out.println("ord업데이트");
			plMapper.updateLineOrd(vo);
		}
		return 0;
	}
}
