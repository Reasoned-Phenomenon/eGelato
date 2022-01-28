package com.gelato.app.sche.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.sche.dao.SchedulerVO;

@Controller
public class SchedulerTestController {

	
	@RequestMapping("/com/schTest")
	public String schTest (SchedulerVO vo) {
		
		
		
		return "aaa";
	}
}
