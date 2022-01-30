package com.gelato.app.biz.oust.web;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;



@Controller
public class OustController {
	
	
	
	// 출고 관리페이지로 이동.
	@GetMapping("/biz/oustSearch.do")
	public String oustSearch() {
		return "tiles/biz/oustSearch";
	}

}
