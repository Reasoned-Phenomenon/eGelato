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
	
	// 공정목록 modal
	@RequestMapping("/prd/prcsDialog.do")
	public String prdtDialog() {
		System.out.println("공정목록모달");
		return "prd/prcsListModal"; 
	}
	
	// 공정목록 modal
	@RequestMapping("/prd/indicaDialog.do")
	public String indicaDialog() {
		System.out.println("공정목록모달");
		return "prd/indicaPrcsNowModal"; 
	}
}
