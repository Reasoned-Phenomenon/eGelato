package com.gelato.app.com.rwmatrCode.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.com.rwmatrCode.dao.RwmatrCodeVO;
import com.gelato.app.com.rwmatrCode.service.RwmatrCodeService;

@Controller
public class RwmatrCodeController {

	@Autowired RwmatrCodeService rwmatrcodeService;
	
	// 자재코드 관리 페이지로 이동.
	@RequestMapping("/com/rwmatrCode.do")
	public String comBom() {
		System.out.println("자재 코드 관리 페이지 이동");
		return "tiles/common/rwmatrCode";
	}
	
	// 자재 코드 list 출력 조회.
	@RequestMapping("/com/findRwmatrList.do")
	public String findBomList(Model model, RwmatrCodeVO vo) {
	    System.out.println("자재코드 조회");
		model.addAttribute("datas", rwmatrcodeService.findRwmatrList(vo));
		return "grid";
    }
	
	
}
