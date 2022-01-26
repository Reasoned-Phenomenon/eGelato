package com.gelato.app.eqm.eqmState.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gelato.app.eqm.eqmState.dao.EqmStateVO;
import com.gelato.app.eqm.eqmState.service.EqmStateService;

@Controller
public class EqmStateController {

	@Autowired
	EqmStateService service;
	
	//실시간설비상태 - 페이지
	@GetMapping("/eqm/eqmState.do")
	public String eqmMonitoring() {
		return "tiles/eqm/eqmState";
	}
}
