package com.gelato.app.com.vendCode.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class VendCodeController {

	// 거래처 코드관리 페이지로 이동.
	@RequestMapping("/com/vendCode.do")
	public String comBom() {
		System.out.println("거래처 코드 관리 페이지 이동");
		return "tiles/common/vendCode";
	}
}
