package com.gelato.app.eqm.eqmIns.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.eqm.eqmIns.dao.EqmInsMapper;
import com.gelato.app.eqm.eqmIns.dao.EqmInsVO;
import com.gelato.app.eqm.eqmIns.service.EqmInsService;
import com.gelato.app.vr.ModifyVO;

@Service
public class EqmInsServiceImpl implements EqmInsService {

	@Autowired
	EqmInsMapper mapper;

	@Override
	public List<EqmInsVO> eqmChck(EqmInsVO eqmInsVo) {
		return mapper.eqmChck(eqmInsVo);
	}

	@Override
	public List<EqmInsVO> eqmInsList(EqmInsVO eqmInsVo) {
		return mapper.eqmInsList(eqmInsVo);
	}

	@Override
	public int modifyChck(ModifyVO<EqmInsVO> eqmInsVo) {
		if (eqmInsVo.getCreatedRows() != null) {
			for (EqmInsVO vo : eqmInsVo.getCreatedRows()) {
				mapper.insertChck(vo);
			}
		}
		if (eqmInsVo.getRows() != null) {
			for (EqmInsVO vo : eqmInsVo.getRows()) {
				mapper.deleteChck(vo);
			}
		}
		return 1;
	}

	@Override
	public List<EqmInsVO> eqmDayChck(EqmInsVO eqmInsVo) {
		return mapper.eqmDayChck(eqmInsVo);
	}

}
