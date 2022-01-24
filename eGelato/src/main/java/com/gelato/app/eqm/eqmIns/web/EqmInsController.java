package com.gelato.app.eqm.eqmIns.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.eqm.eqmIns.dao.EqmInsVO;
import com.gelato.app.eqm.eqmIns.service.EqmInsService;
import com.gelato.app.vr.ModifyVO;

@Controller
public class EqmInsController {

	@Autowired 
	EqmInsService service;
	
	// 설비점검관리 - 페이지
	@GetMapping("/eqm/eqmInspection.do")
	public String eqmIns() {
		return"tiles/eqm/eqmInspection";
	}
	
	//설비점검관리 - 설비검색 모달
	@RequestMapping("/eqm/eqmCkModal.do")
	public String getEqmCkModal() {
		return "/eqm/eqmCkModal";
	}
		
	//설비점검관리 - 설비검색 모달(페이지)
	@GetMapping("/eqm/eqmCkDate.do")
	public String eqmCkDate(Model model, EqmInsVO eqmInsVo) {
		model.addAttribute("datas", service.eqmChck(eqmInsVo));
		return "grid";
	}
	
	//설비점검관리 - 점검 할 설비 내역 그리드(하단)
	@GetMapping("/eqm/eqmInspectionList.do")
	public String eqmInspectionList(Model model, EqmInsVO eqmInsVo) {
		model.addAttribute("datas", service.eqmInsList(eqmInsVo));
		return "grid";
	}
	
	//설비점검관리 - 설비 점검 내역 그리드에서 등록
	@PutMapping("/eqm/chckModifyData.do")
	@ResponseBody
	public boolean modifyData (@RequestBody ModifyVO<EqmInsVO> eqmInsVo) {
		System.out.println(eqmInsVo);
		service.modifyChck(eqmInsVo);
		return true;
	}
}
