package com.gelato.app.prd.prdIndica.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.prd.prdIndica.dao.PrdIndicaMngVO;
import com.gelato.app.prd.prdIndica.service.PrdIndicaMngService;

@Controller
public class PrdIndicaMngController {
	
	 @Autowired PrdIndicaMngService prdIndicaMngService;
	
	//생산지시관리로 이동
	@RequestMapping("/prd/prdIndicaMng.do")
	public String prdIndicaMng() {
		System.out.println("생산지시관리 페이지 이동");
		return "tiles/prd/prdIndicaMng";
	}
	
	//미지시생산계획 modal
	@RequestMapping("/prd/nonIndicaDialog.do")
	public String nonIndicaDialog() {
		System.out.println("미지시생산계획 이동");
		// 미지시생산계획 들어갈 주문서 modal jsp.
		return "prd/nonIndicaModal"; 
	}
	
	//미지시생산계획 출력
	@RequestMapping("/prd/nonIndicaList.do")
	public String nonIndicaList(Model model) {
		System.out.println("미지시 생산계획 리스트 출력");
		System.out.println(model);
		model.addAttribute("datas" , prdIndicaMngService.nonIndicaList());
		return "grid";
	}
	
	//미지시에서 선택한 값을 그리드1에 출력
	@RequestMapping("/prd/choosePlan.do")
	public String choosePlan(Model model, PrdIndicaMngVO vo) {
		System.out.println("미지시 선택값 출력");
		System.out.println(vo);
		System.out.println(model);
		model.addAttribute("datas", prdIndicaMngService.choosePlan(vo));
		return "grid";
	}
}
