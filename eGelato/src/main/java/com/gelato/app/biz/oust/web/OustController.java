package com.gelato.app.biz.oust.web;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.biz.oust.dao.OustVO;
import com.gelato.app.biz.oust.service.OustService;


@Controller
public class OustController {
	
	@Autowired OustService oustService;
	
	// 출고 관리페이지로 이동.
	@GetMapping("/biz/oustSearch.do")
	public String oustSearch() {
		return "tiles/biz/oustSearch";
	}
	
	// 출고list 출력 조회.
	@RequestMapping("/biz/findOustList.do")
	public String findOustList(Model model) {
		
		System.out.println("출고 list 조회.");
		System.out.println(oustService.oustList());
		model.addAttribute("datas", oustService.oustList());
		return "grid";
	}
	
	// 그리드 우측 출력 조회.
	@RequestMapping("/biz/oustLotList.do")
	public String oustLotList(Model model, OustVO vo) {
		
		System.out.println("출고 list 조회.");
		System.out.println(oustService.oustLotList(vo));
		model.addAttribute("datas", oustService.oustLotList(vo));
		return "grid";
	}
}
