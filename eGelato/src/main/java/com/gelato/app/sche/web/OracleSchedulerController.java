package com.gelato.app.sche.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.sche.dao.OracleSchedulerVO;
import com.gelato.app.sche.service.OracleSchedulerService;

@Controller
public class OracleSchedulerController {

	@Autowired OracleSchedulerService service;
	
	//테스트
	@RequestMapping("/com/schTest")
	public String schTest (OracleSchedulerVO vo) {
		
		return "aaa";
	}
	
}
