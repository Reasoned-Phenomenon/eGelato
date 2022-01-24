package com.gelato.app.biz.web;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.biz.dao.OrderVO;
import com.gelato.app.biz.service.OrderService;

@Controller
public class OrderController {

	@Autowired OrderService ordService;
	
	// 주문서 관리 페이지로 이동.
	@GetMapping("/biz/ordSearch.do")
	public String ordSearch() {
		return "tiles/biz/ordSearch";
	}
	
	// 주문서 list 출력 조회.
	@RequestMapping("/biz/findOrderList.do")
	public String findOrderList(Model model, OrderVO vo) {
		System.out.println(vo);
		System.out.println("999999");
		model.addAttribute("datas", ordService.findOrderList(vo));
		return "grid";
	}
	
	// 거래처 모달로 조회.
	@RequestMapping("/biz/vendList.do")
	public String vendList(Model model) {
		System.out.println("거래처 검색");
		model.addAttribute("datas", ordService.vendList());
		return "grid";
	}
	// 거래처 버튼 눌럿을때  모달 창 함수가 컨트롤러에 오고 리턴으로 모달창 띄울 jsp 적어줌.
	@RequestMapping("/biz/vendModal.do")
	public String vendModal(Model model) {
		System.out.println("거래처 모달");
		return "/biz/vendList";
	}
	
	// 제품코드 모달로 조회. 
	@RequestMapping("/biz/prdtListModal.do")
	public String prdtList(Model model) {
		System.out.println("제품코드 검색");
		model.addAttribute("datas", ordService.prdtList());
		return "grid";
	}
	// 제품코드 버튼 눌럿을때  모달 창 함수가 컨트롤러에 오고 리턴으로 모달창 띄울 jsp 적어줌.
		@RequestMapping("/biz/prdtModal.do")
		public String prdtModal(Model model) {
			System.out.println("제품명 모달");
			return "/biz/prdtListModal";
		}
	
}
