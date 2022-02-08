package com.gelato.app.eqm.eqmState.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.eqm.eqmState.dao.EqmStateVO;
import com.gelato.app.eqm.eqmState.service.EqmStateService;

@Controller
public class EqmStateController {

	@Autowired
	EqmStateService service;
	
	//실시간설비상태 - 페이지
//	@GetMapping("/eqm/eqmState.do")
//	public String eqmMonitoring() {
//		return "tiles/eqm/eqmState";
//	}
//	
//	//실시간설비상태 - 온도(페이지)
//	@GetMapping("/eqm/temperature.do")
//	public String tempPage() {
//		return "tiles/eqm/temperature";
//	}
//	
//	//실시간설비상태 - 온도
//	@GetMapping("/eqm/findEqmTemp.do")
//	public String findTemp(Model model, EqmStateVO eqmStateVo) {
//		
//		System.out.println(eqmStateVo);
//		System.out.println(service.temperature(eqmStateVo));
//		model.addAttribute("datas", service.temperature(eqmStateVo));
//		return "grid";
//	}
//	
//	//실시간설비상태 - 생산량
//	@GetMapping("/eqm/findEqmOutput.do")
//	public String findOutPutTemp(Model model, EqmStateVO eqmStateVo) {
//		
//		System.out.println(eqmStateVo);
//		System.out.println(service.temperature(eqmStateVo));
//		model.addAttribute("datas", service.output(eqmStateVo));
//		return "grid";
//	}
	
	//실시간설비상태 - 페이지(sw)
	@GetMapping("/eqm/eqmState.do")
	public String eqmMonitoring() {
		return "tiles/eqm/eqmStateNow";
	}
	
	@RequestMapping("/eqm/findNowEqm.do")
	public String findComCode(Model model, EqmStateVO vo) {
		model.addAttribute("datas",service.findNowEqm(vo));
		return "grid";
	}
	
	//실시간설비상태 - 온도
	@GetMapping("/eqm/findEqmTemp.do")
	public String findTemp(Model model, EqmStateVO eqmStateVo) {
		
		System.out.println(eqmStateVo);
		System.out.println(service.temperature(eqmStateVo));
		model.addAttribute("datas", service.temperature(eqmStateVo));
		return "grid";
	}
	
}
