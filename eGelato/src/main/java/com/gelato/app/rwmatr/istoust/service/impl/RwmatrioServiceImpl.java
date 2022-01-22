package com.gelato.app.rwmatr.istoust.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.rwmatr.istInsp.dao.RwmatrIstInspMapper;
import com.gelato.app.rwmatr.istInsp.dao.RwmatrIstInspVO;
import com.gelato.app.rwmatr.istoust.dao.RwmatrioMapper;
import com.gelato.app.rwmatr.istoust.dao.RwmatrioVO;
import com.gelato.app.rwmatr.istoust.service.RwmatrioService;
import com.gelato.app.vr.ModifyVO;

@Service
public class RwmatrioServiceImpl implements RwmatrioService {

	@Autowired RwmatrioMapper rwmatrioMapper;
	@Autowired RwmatrIstInspMapper rwmatrIstInspMapper;

	@Override
	public List<RwmatrioVO> RwmatrIstList(RwmatrioVO vo) {
		return rwmatrioMapper.RwmatrIstList(vo);
	}

	@Override
	public List<RwmatrioVO> RwmatrPassList(RwmatrioVO vo) {
		return rwmatrioMapper.RwmatrPassList(vo);
	}

	@Override
	public List<RwmatrioVO> RwmatrOustList(RwmatrioVO vo) {
		return rwmatrioMapper.RwmatrOustList(vo);
	}

	@Override
	public List<RwmatrioVO> RwmatrStcList(RwmatrioVO vo) {
		return rwmatrioMapper.RwmatrStcList(vo);
	}

	@Override
	public List<RwmatrioVO> RwmatrStcMList(RwmatrioVO vo) {
		return rwmatrioMapper.RwmatrStcMList(vo);
	}

	@Override
	public int modifyIst(ModifyVO<RwmatrioVO> mvo) {
		for(RwmatrioVO vo : mvo.getCreatedRows()) {
			System.out.println("추가");
			RwmatrIstInspVO rwmatrIstInspVO = new RwmatrIstInspVO();
			rwmatrIstInspVO.setRwmatrOrderDetaId(vo.getRwmatrOrderDetaId());
			//입고검사 구분자 업데이트
			rwmatrIstInspMapper.updateRwmatrIstInspIst(rwmatrIstInspVO);
			
			//입고내역 추가
			rwmatrioMapper.insertRwmatrIst(vo);
		}
		
		for(RwmatrioVO vo : mvo.getUpdatedRows()) {
			System.out.println("수정");
			rwmatrioMapper.updateRwmatrIst(vo);
		}
		
		for(RwmatrioVO vo : mvo.getDeletedRows()) {
			System.out.println("삭제");
			//입고내역 삭제
			rwmatrioMapper.deleteRwmatrIst(vo);
		}
		return 0;
	}

	@Override
	public int modifyStc(ModifyVO<RwmatrioVO> mvo) {
		for(RwmatrioVO vo : mvo.getCreatedRows()) {
			System.out.println("추가");
			vo.setQy(vo.getIstQy());
			rwmatrioMapper.insertRwmatrStc(vo);
		}
		
		for(RwmatrioVO vo : mvo.getUpdatedRows()) {
			System.out.println("수정");
			rwmatrioMapper.updateRwmatrStc(vo);
		}
		
		for(RwmatrioVO vo : mvo.getDeletedRows()) {
			System.out.println("삭제");
			rwmatrioMapper.deleteRwmatrStc(vo);
		}
		return 0;
	}

	@Override
	public int modifyOust(ModifyVO<RwmatrioVO> mvo) {
		for(RwmatrioVO vo : mvo.getCreatedRows()) {
			System.out.println("추가");
			rwmatrioMapper.insertRwmatrOust(vo);
			//현재고 업데이트
			RwmatrioVO rwmatrioVO = new RwmatrioVO();
			rwmatrioVO.setRwmatrId(vo.getRwmatrId());
			rwmatrioVO.setExpdate(vo.getExpdate());
			rwmatrioVO.setQy(vo.getExcpQy());
			System.out.println("현재고 업데이트!");
			System.out.println(rwmatrioMapper.updateRwmatrStc(rwmatrioVO));
		}
		
		for(RwmatrioVO vo : mvo.getUpdatedRows()) {
			System.out.println("수정");
			rwmatrioMapper.updateRwmatrOust(vo);
		}
		
		for(RwmatrioVO vo : mvo.getDeletedRows()) {
			System.out.println("삭제");
			rwmatrioMapper.deleteRwmatrOust(vo);
			//현재고 업데이트
			RwmatrioVO rwmatrioVO = new RwmatrioVO();
			rwmatrioVO.setRwmatrId(vo.getRwmatrId());
			rwmatrioVO.setExpdate(vo.getExpdate());
			rwmatrioVO.setQy(vo.getExcpQy());
			rwmatrioMapper.updateRwmatrStcD(rwmatrioVO);
		}
		return 0;
	}
}
