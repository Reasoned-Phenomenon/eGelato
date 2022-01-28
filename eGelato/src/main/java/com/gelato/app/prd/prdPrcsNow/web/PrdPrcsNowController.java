package com.gelato.app.prd.prdPrcsNow.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.prd.prdPrcs.dao.PrdPrcsMngVO;
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
	
	//모달창 이동
	@RequestMapping("/prd/chooseIndicaDialog.do")
	public String nonPrcsDialog() {
		System.out.println("생산지시조회 모달");
		return "prd/indicaPrcsNowModal";
	}
	
	//모달창 list
	@RequestMapping("/prd/chooseIndicaDeta.do")
	public String chooseIndica(PrdPrcsNowVO vo ,Model model) {
		System.out.println("모달 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdPrcsNowService.chooseIndicaDeta(vo));
		return "grid";
	}
		
	// 공정목록
	@RequestMapping("/prd/prcsNowList.do")
	public String prcsList(PrdPrcsNowVO vo, Model model) {
		System.out.println("공정목록 출력");
		model.addAttribute("datas", prdPrcsNowService.prcsList(vo));
		return "grid";
	}
	
	// 공정별 실적
	@RequestMapping("/prd/prcsDetaList.do")
	public String prcsDetaList(PrdPrcsNowVO vo, Model model) {
		System.out.println("공정별실적 출력");
		model.addAttribute("datas", prdPrcsNowService.prcsDetaList(vo));
		return "grid";
	}
}
