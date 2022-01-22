package com.gelato.app.com.comCode.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.com.comCode.dao.ComCodeVO;
import com.gelato.app.com.comCode.service.ComCodeService;
import com.gelato.app.vr.ModifyVO;

@Controller
public class ComCodeController {

	@Autowired ComCodeService service;
	
	@RequestMapping("/com/comCode.do")
	public String comCode () {
		return "tiles/common/comCode";
	}
	
	@RequestMapping("/com/findComCode.do")
	public String findComCode(Model model, ComCodeVO vo) {
		model.addAttribute("datas",service.findComCode(vo));
		return "grid";
	}
	
	@PutMapping("/com/comCodeModifyData.do")
	@ResponseBody
	public boolean modifyData (@RequestBody ModifyVO<ComCodeVO> mvo) {
		System.out.println(mvo);
		service.modifyComCode(mvo);
		return true;
	}
	
	@RequestMapping("/com/comModal.do")
	public String getModal() {
		System.out.println("modal");
		return "/common/comModal";
	}
	
}
