package com.gelato.app.sche.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.sche.dao.OracleSchedulerMapper;
import com.gelato.app.sche.dao.TestVO;

@Controller
public class SchedulerTestController {

	@Autowired OracleSchedulerMapper mapper;
	
	@RequestMapping("/com/schTest")
	public String schTest (TestVO vo) {
		
		mapper.proc(vo);
		return "aaa";
	}
}
