package com.gelato.app.eqm.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.com.comCode.dao.ComCodeVO;
import com.gelato.app.com.comCode.service.ComCodeService;
import com.gelato.app.eqm.dao.EqmNonVO;
import com.gelato.app.eqm.dao.EqmVO;
import com.gelato.app.eqm.service.EqmService;

@Controller
public class EqmController {

	@Autowired
	EqmService service;
	@Autowired ComCodeService cservice;
	// 등록 페이지
	@GetMapping("/eqm/eqmRegister.do")
	public String insertForm() {  
		return "tiles/eqm/eqmRegister";
	}

	// 등록
	@PostMapping("/eqm/insertEqm.do")
	public String insert(EqmVO eqmVo) {
		service.insertEqm(eqmVo);
		return "tiles/eqm/eqmManagement";
	}

	// 설비 등록 모달(설비구분)
	@RequestMapping("/eqm/searchFg.do")
	public String getModal() {
		return "/eqm/searchFg";
	}
	
	//설비등록 모달(설비구분)
	@RequestMapping("/eqm/findSeolbi.do")
	public String getSeolbi(Model model, EqmVO eqmVo) {
		ComCodeVO vo = new ComCodeVO();
		vo.setCodeId(eqmVo.getCodeId());
		System.out.println(cservice.findComCode(vo));
		model.addAttribute("datas",cservice.findComCode(vo));
		return "grid";
	}

	// 설비관리 페이지
	@RequestMapping("/eqm/eqmManagement.do")
	public String eqmList() {
		return "tiles/eqm/eqmManagement";
	}

	// 설비관리(조회 그리드)
	@GetMapping("/eqm/eqmList.do")
	public String findEqm(Model model, EqmVO eqmVo) {
		System.out.println(service.eqmList(eqmVo));
		model.addAttribute("datas", service.eqmList(eqmVo));
		return "grid";
	}

	// 설비관리(단건조회)
	@GetMapping("/eqm/eqmSelect.do")
	public String eqmSelectList(Model model, EqmVO eqmVo) {
		System.out.println(service.eqmSelect(eqmVo));
		model.addAttribute(service.eqmSelect(eqmVo));
		return "tiles/eqm/eqmManagement";
	}

	// 설비수정
	@GetMapping("/eqm/eqmUpdate.do")
	public String eqmUpdate(EqmVO eqmVo) {
		int r = service.eqmUpdate(eqmVo);
		return "tiles/eqm/eqmManagement";
	}

	// 설비비가동관리 페이지
	@GetMapping("/eqm/eqmNonMoving.do")
	public String eqmNonMoving(Model model, EqmVO eqmVo) {
		model.addAttribute("datas", eqmVo);
		System.out.println(eqmVo);
		return "tiles/eqm/eqmNonMoving";
	}
	
	// 설비비가동관리(설비전체조회 그리드)
	@GetMapping("/eqm/eqmNonMovingList.do")
	public String findEqmNon(Model model, EqmVO eqmVo) {
		model.addAttribute("datas", service.eqmNonList(eqmVo));
		return "grid";
	}
	
	// 설비비가동관리(내역조회)=========날짜검색결과 추가하기==========
	@GetMapping("eqm/eqmNonSelect.do")
	public String eqmNonSelect(Model model, EqmNonVO eqmNonVo) {
		System.out.println(eqmNonVo);
		model.addAttribute("datas",service.eqmNonSelect(eqmNonVo));
		return "grid";
	}
	
	// 설비비가동 등록 
	@RequestMapping("/eqm/eqmNonInsert.do")
	public String eqmNonInsert(Model model, EqmNonVO eqmNonVo) {
		model.addAttribute("datas",service.insertNonEqm(eqmNonVo));
		return "tiles/eqm/eqmNonMoving";
	}
	
	//설비코드(명) 모달
	@RequestMapping("/eqm/searchEqm.do")
	public String getEqmModal() {
		return "/eqm/searchEqm";
	}	

}

