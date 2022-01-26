package com.gelato.app.prd.prdPrcsNow.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PrdPrcsNowController {

	// 공정실적으로 이동
	@RequestMapping("/prd/prdPrcsNow.do")
	public String prdPrcsNow() {
		System.out.println("공정실적 이동");
		return "tiles/prd/prdPrcsNow";
	}
}
