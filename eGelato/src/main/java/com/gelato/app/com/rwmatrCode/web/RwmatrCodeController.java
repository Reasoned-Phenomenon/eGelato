package com.gelato.app.com.rwmatrCode.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RwmatrCodeController {

	// 자재코드 관리 페이지로 이동.
	@RequestMapping("/com/rwmatrCode.do")
	public String comBom() {
		System.out.println("자재 코드 관리 페이지 이동");
		return "tiles/common/rwmatrCode";
	}
}
