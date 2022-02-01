package com.gelato.app.prd.prdPrcs.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.prd.prdPrcs.dao.PrdPrcsMngVO;
import com.gelato.app.prd.prdPrcs.service.PrdPrcsMngService;

@Controller
public class PrdPrcsMngController {
	
	@Autowired PrdPrcsMngService prdPrcsMngService;

	//생산관리로 이동
	@RequestMapping("/prd/prdPrcsMng.do")
	public String prdPrcsMng() {
		System.out.println("생산관리 이동");
		return "tiles/prd/prdPrcsMng";
	}
	
	//모달창 이동
	@RequestMapping("/prd/nonPrcsDialog.do")
	public String nonPrcsDialog() {
		System.out.println("생산지시조회 모달");
		return "prd/indicaPrcsModal";
	}
	
	//모달창 list
	@RequestMapping("/prd/chooseIndica.do")
	public String chooseIndica(PrdPrcsMngVO vo ,Model model) {
		System.out.println("모달 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdPrcsMngService.chooseIndica(vo));
		return "grid";
	}
	
	//그리드1출력
	@RequestMapping("/prd/selectIndica.do")
	public String selectIndica(PrdPrcsMngVO vo ,Model model) {
		System.out.println("지시 선택값 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdPrcsMngService.selectIndica(vo));
		return "grid";
	}
	
	//그리드2출력
	@RequestMapping("/prd/prcsList.do")
	public String prcsList(PrdPrcsMngVO vo ,Model model) {
		System.out.println("공정리스트 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdPrcsMngService.prcsList(vo));
		return "grid";
	}
	
	//공정이동표
	@RequestMapping("/prd/prcsMoveDialog.do")
	public String prcsMoveDialog() {
		System.out.println("생산지시조회 모달");
		return "prd/prcsMoveList";
	}
}
