package com.gelato.app.biz.oust.web;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.biz.oust.dao.OustVO;
import com.gelato.app.biz.oust.service.OustService;
import com.gelato.app.vr.ModifyVO;


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
		
		// TODO 연습이요~ 서버옆에 있는 Tasks에 기록이 남아짐. 보고 체크 할 수 있음.
		return "grid";
	}
	
	// 그리드 우측 출력 조회. (입출고 테이블)
	@RequestMapping("/biz/prdtInstOust.do")
	public String prdtInstOust(Model model, OustVO vo) {
		
		System.out.println(vo);
		System.out.println("출고 list 조회.");
		System.out.println(oustService.prdtInstOust(vo));
		model.addAttribute("datas", oustService.prdtInstOust(vo));
		return "grid";
	}
	
	// 완제품 재고 modal 조회.
	@RequestMapping("/biz/prdtStcList.do")
	public String prdtStcList(Model model, OustVO vo) {
		System.out.println("=============111111=========11111========111");
		System.out.println("완제품 재고");
		System.out.println(vo);
		model.addAttribute("datas", oustService.prdtStcList(vo));
		System.out.println(oustService.prdtStcList(vo));
		return "grid";
	}
	
	@RequestMapping("/biz/prdtStcGrid.do")
	public String vendModal(Model model) {
		System.out.println("완제품 재고");
		return "/biz/prdtStcModal";
	}
	
	// modify 
	@PutMapping("/biz/modifyPrdtInstOust.do")
	@ResponseBody
	public boolean modifyPrdtInstOust (@RequestBody ModifyVO<OustVO> mvo) {
		System.out.println("modify 확인");
		System.out.println(mvo);
		oustService.modifyOust(mvo);
		return true;
	}
}
