package com.gelato.app.prd.prdPrcsList.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class prdPrcsListController {

	// 공정관리로 이동
	@RequestMapping("/prd/prdPrcsMngList.do")
	public String prdPrcsNow() {
		System.out.println("공정관리 이동");
		return "tiles/prd/prdPrcsMngList";
	}
}
