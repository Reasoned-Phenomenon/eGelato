package com.gelato.app.com.prdtCode.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.com.prdtCode.dao.PrdtCodeVO;
import com.gelato.app.com.prdtCode.service.PrdtCodeService;

@Controller
public class PrdtCodeController {

	@Autowired PrdtCodeService prdtcodeService;
	
	// 완제품코드 관리 페이지로 이동.
	@RequestMapping("/com/prdtCode.do")
	public String comBom() {
		System.out.println("완제품 코드 관리 페이지 이동");
		return "tiles/common/prdtCode";
	}
	
	// 완제품코드 prdtCode list 출력 조회.
	@RequestMapping("/com/prdtCodeList.do")
	public String prdtCodeList(Model model, PrdtCodeVO vo) {
		    System.out.println("완제품 코드 list 조회.");
			model.addAttribute("datas", prdtcodeService.PrditCodeList(vo));
			return "grid";
	}
	
}
