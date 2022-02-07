package com.gelato.app.com.emp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gelato.app.com.emp.dao.EmpMapper;
import com.gelato.app.com.emp.dao.EmpVO;
import com.gelato.app.com.emp.service.EmpService;

@Service
public class EmpServiceImpl implements EmpService {

	@Autowired EmpMapper mapper;
	
	@Override
	public List<EmpVO> findMber() {
		return mapper.findMber();
	}

	
}
