package com.gelato.app.biz.eprd.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.biz.eprd.dao.EproductVO;
import com.gelato.app.biz.eprd.service.EproductService;

@Controller
public class EproductController {
	
	@Autowired EproductService eproductService;
	
	
	//완제품 현재고 페이지로 이동
	@RequestMapping("/biz/eproductStc.do")
	public String eproductStc() {
		return "tiles/biz/eproductStc";
	}
	
	//완제품 현재고 조회
	@RequestMapping("/biz/eproductStcList.do")
	public String eproductStcList(EproductVO vo, Model model) {
		System.out.println("완제품 현재고 조회");
		model.addAttribute("datas", eproductService.EproductStcList(vo));
		System.out.println(eproductService.EproductStcList(vo));
		return "grid";
	}
	
	//완제품 입출고조회 페이지로 이동
	@RequestMapping("/biz/eproductIstOust.do")
	public String eproductIstOust() {
		return "tiles/biz/eproductIstOust";
	}
	
	//완제품 입고내역 조회
	@RequestMapping("/biz/rwmatrIstList.do")
	public String rwmatrIstList(EproductVO vo, Model model) {
		System.out.println("완제품 입고내역 조회");
		model.addAttribute("datas", eproductService.EproductIstList(vo));
		System.out.println(eproductService.EproductIstList(vo));
		return "grid";
	}
	
	//완제품 출고내역 조회
	@RequestMapping("/biz/rwmatrOustList.do")
	public String rwmatrOustList(EproductVO vo, Model model) {
		System.out.println("완제품 출고내역 조회");
		model.addAttribute("datas", eproductService.EproductOustList(vo));
		System.out.println(eproductService.EproductOustList(vo));
		return "grid";
	}
	
}
