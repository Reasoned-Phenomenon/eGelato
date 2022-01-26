package com.gelato.app.prd.prdIndicaFind.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.prd.prdIndicaFind.dao.PrdIndicaMngFindVO;
import com.gelato.app.prd.prdIndicaFind.service.PrdIndicaMngFindService;

@Controller
public class PrdIndicaMngFindController {

	@Autowired PrdIndicaMngFindService prdIndicaMngFindService;
	
	//생산지시조회로 이동
	@RequestMapping("/prd/prdIndicaMngFind.do")
	public String prdIndicaMng() {
		System.out.println("생산지시조회 페이지 이동");
		return "tiles/prd/prdIndicaMngFind";
	}
	
	//생산지시조회
	@RequestMapping("/prd/indicaList.do")
	public String indicaList(PrdIndicaMngFindVO vo, Model model) {
		System.out.println("지시조회");
		System.out.println(vo);
		model.addAttribute("datas", prdIndicaMngFindService.indicaList(vo));
		System.out.println(222);
		return "grid";
	}
}
