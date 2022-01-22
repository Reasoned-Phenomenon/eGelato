package com.gelato.app.eqm.eqmNon.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import com.gelato.app.eqm.dao.EqmVO;
import com.gelato.app.eqm.eqmNon.dao.EqmNonVO;
import com.gelato.app.eqm.eqmNon.service.EqmNonService;

@Controller
public class EqmNonController {

	@Autowired
	EqmNonService service;

	// 설비비가동관리 - 페이지
	@GetMapping("/eqm/eqmNonMoving.do")
	public String eqmNonMoving(Model model, EqmVO eqmVo) {
		model.addAttribute("datas", eqmVo);
		System.out.println(eqmVo);
		return "tiles/eqm/eqmNonMoving";
	}

	// 설비비가동관리 - 좌측 설비전체조회 그리드
	@GetMapping("/eqm/eqmNonMovingList.do")
	public String findEqmNon(Model model, EqmVO eqmVo) {
		model.addAttribute("datas", service.eqmNonList(eqmVo));
		return "grid";
	}

	// 설비비가동관리 - 비가동내역조회
	@GetMapping("eqm/eqmNonSelectAll.do")
	public String eqmNonSelectAll(Model model, EqmNonVO eqmNonVo) {
		model.addAttribute("datas", service.eqmNonSelectAll(eqmNonVo));
		return "grid";
	}

	// 설비비가동관리 - 비가동내역조회
	@GetMapping("eqm/eqmNonSelect.do")
	public String eqmNonSelect(Model model, EqmNonVO eqmNonVo) {
		System.out.println(eqmNonVo);
		model.addAttribute("datas", service.eqmNonSelect(eqmNonVo));
		return "grid";
	}

	// 설비비가동관리 - 등록
	@PostMapping("/eqm/eqmNonInsert.do")
	public String eqmNonInsert(Model model, EqmNonVO eqmNonVo) {
		 service.insertNonEqm(eqmNonVo);
		return "tiles/eqm/eqmNonMoving";
	}

	// 설비비가동관리 - 설비코드 모달
	@RequestMapping("/eqm/searchEqmModal.do")
	public String getModal() {
		return "/eqm/searchEqmModal";
	}

	// 설비비가동관리 - 비가동사유코드 모달 (페이지)
	@RequestMapping("/eqm/eqmNonResnModal.do")
	public String getEqmRsnModal() {
		return "/eqm/searchEqmNonModal";
	}

	// 설비비가동관리 - 비가동사유코드 모달
	@RequestMapping("/eqm/eqmNonResnGrid.do")
	public String getSeolbi(Model model, EqmNonVO eqmNonVo) {
		model.addAttribute("datas", service.EqmNonResnSearch(eqmNonVo));
		return "grid";
	}

}
