package com.gelato.app.prd.prdPlanFind.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.prd.prdPlanFind.dao.PrdPlanMngFindVO;
import com.gelato.app.prd.prdPlanFind.service.PrdPlanMngFindService;

@Controller
public class PrdPlanMngFindController {

	@Autowired PrdPlanMngFindService prdPlanMngFindService;
	
	// 생산계획조회 페이지로 이동
	@RequestMapping("/prd/prdPlanMngFind.do")
	public String prdPlanMngFind() {
		System.out.println("생산계획조회 페이지 이동");
		
		// 생산계획관리 페이지
		 return "tiles/prd/prdPlanMngFind"; 
	}
	
	//제품목록 modal
	@RequestMapping("/prd/prdtDialogPF.do")
	public String prdtDialog() {
		System.out.println("제품목록");
		// 생산계획관리에 들어갈 검색창 modal jsp.
		return "prd/prdtListModal"; 
	}
	
	//계획조회
	@RequestMapping("/prd/planListPF.do")
	public String planListPF(PrdPlanMngFindVO vo, Model model) {
		System.out.println(111111111);
		System.out.println(vo);
		System.out.println("계획조회");
		model.addAttribute("datas", prdPlanMngFindService.planList(vo));
		System.out.println(222222);
		return "grid";
	}
}
