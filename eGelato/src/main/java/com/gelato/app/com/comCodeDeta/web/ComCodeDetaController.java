package com.gelato.app.com.comCodeDeta.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.com.comCodeDeta.dao.ComCodeDetaVO;
import com.gelato.app.com.comCodeDeta.service.ComCodeDetaService;
import com.gelato.app.vr.ModifyVO;

@Controller
public class ComCodeDetaController {

	@Autowired ComCodeDetaService service;
	
	@RequestMapping("/com/findComCodeDeta.do")
	public String findComCodeDeta(Model model,ComCodeDetaVO vo) {
		System.out.println("read");
		model.addAttribute("datas",service.findComCodeDeta(vo));
		System.out.println(service.findComCodeDeta(vo));
		return "grid";
	}
	
	@PutMapping("/com/comCodeDetaModifyData.do")
	@ResponseBody
	public boolean modifyData (@RequestBody ModifyVO<ComCodeDetaVO> mvo) {
		
		System.out.println("수정");
		System.out.println(mvo);
		
		service.modifyComCodeDeta(mvo);
		
		return true;
	}
	
	@RequestMapping("/com/comCodeDetaCodeId.do")
	@ResponseBody
	public Object comCodeDetaCodeId (@RequestBody ComCodeDetaVO mvo) {
		Map param = new HashMap();
		param.put("codeId", mvo.getCodeId());
		service.findComCodeProcedure(param);
		return param.get("out_cursor_table");
		
	}
	
}
