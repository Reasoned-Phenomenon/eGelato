package com.gelato.app.com.emp.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.com.emp.dao.EmpVO;
import com.gelato.app.com.emp.service.EmpService;

@Controller
public class EmpController {

	@Autowired EmpService service;
	
	@RequestMapping("/com/empModal.do")
	public String getModal() {
		System.out.println("emp modal 호출");
		return "/common/empModal";
	}
	
	@RequestMapping("/com/findMber.do")
	public String findComCode(Model model, EmpVO vo) {
		model.addAttribute("datas",service.findMber(vo));
		return "grid";
	}
}
