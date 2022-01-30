package com.gelato.app.prd.prdLine.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PrdLineMngController {

	//생산계획관리 페이지로 이동
	@RequestMapping("/prd/prdPlanLine.do")
	public String prdLineMng() {
		System.out.println("제품공정흐름도 페이지 이동");
	 return "tiles/prd/prdLineMng"; 
	}
}
