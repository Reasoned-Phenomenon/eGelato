package com.gelato.app.prd.prdPrcsNow.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.prd.prdPrcsNow.dao.PrdPrcsNowVO;
import com.gelato.app.prd.prdPrcsNow.service.PrdPrcsNowService;

@Controller
public class PrdPrcsNowController {

	@Autowired PrdPrcsNowService prdPrcsNowService;
	
	// 공정실적으로 이동
	@RequestMapping("/prd/prdPrcsNow.do")
	public String prdPrcsNow() {
		System.out.println("공정실적 이동");
		return "tiles/prd/prdPrcsNow";
	}
	
	// 공정목록 modal
	@RequestMapping("/prd/prcsDialog.do")
	public String prcsDialog() {
		System.out.println("공정목록모달");
		return "prd/prcsListModal"; 
	}
	
	// 지시목록 modal
	@RequestMapping("/prd/indicaDialog.do")
	public String indicaDialog() {
		System.out.println("지시목록모달");
		return "prd/indicaPrcsNowModal"; 
	}
	
	// 공정목록 modal 출력
	@RequestMapping("/prd/prcsDialogDeta.do")
	public String prcsDialogDeta(PrdPrcsNowVO vo ,Model model) {
		System.out.println("공정목록 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdPrcsNowService.prcsDialog(vo));
		return "grid";
	}
	
	// 지시목록 modal 출력
	@RequestMapping("/prd/indicaDialogDeta.do")
	public String indicaDialogDeta(PrdPrcsNowVO vo, Model model) {
		System.out.println("지시목록 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdPrcsNowService.indicaDialog(vo));
		return "grid";
	}
}
