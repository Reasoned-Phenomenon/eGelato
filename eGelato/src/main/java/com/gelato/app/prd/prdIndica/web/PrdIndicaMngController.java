package com.gelato.app.prd.prdIndica.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	//상세갱산계획에서 선택한 값으로 line 가져오기 -> ajax 사용
	@RequestMapping("/prd/choosePlanDetaId.do")
	@ResponseBody
	public PrdIndicaMngVO choosePlanDetaId(PrdIndicaMngVO vo) {
		System.out.println("생산계획 선택값 출력");
		System.out.println(vo);
		System.out.println(111);
		
		return prdIndicaMngService.choosePlanDetaId(vo);
	}
	
	// 생산지시 선택값 -> 자재로 값 보여주기
	@RequestMapping("/prd/chooseIndicaQy.do")
	public String chooseIndicaQy(Model model, PrdIndicaMngVO vo) {
		System.out.println("생산지시 선택값 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdIndicaMngService.chooseIndicaQy(vo));
		return "grid";
	}
	
	//미지시생산계획 modal
	@RequestMapping("/prd/RwmatrLotDialog.do")
	public String rwmatrLotDialog() {
		System.out.println("자재Lot 이동");
		return "prd/rwmatrLotModal"; 
	}
		
	// 선택한 자재Lot 출력
	@RequestMapping("/prd/chooseRwmatrId.do")
	public String chooseRwmatrId(Model model, PrdIndicaMngVO vo) {
		System.out.println("자재Lot 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdIndicaMngService.chooseRwmatrId(vo));
		return "grid";
	}
	
	
	   
	
	
}
