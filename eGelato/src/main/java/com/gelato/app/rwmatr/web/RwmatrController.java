package com.gelato.app.rwmatr.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.rwmatr.dao.RwmatrMapper;
import com.gelato.app.rwmatr.dao.RwmatrVO;
import com.gelato.app.rwmatr.service.RwmatrService;

@Controller
public class RwmatrController {

	@Autowired RwmatrService rwmatrService;
	@Autowired RwmatrMapper rwmatrMapper;
	
	//안전재고 관리 페이지로 이동
	@RequestMapping("/rwmatr/rwmatrSafStc.do")
	public String rwmatrSafStc () {
		return "tiles/rwmatr/rwmatrSafStc";
	}
	
	//안전재고 리스트 조회
	@RequestMapping("/rwmatr/rwmatrSafStcList.do")
	public String rwmatrSafStcList(RwmatrVO vo, Model model) {
		System.out.println("안전재고 조회");
		model.addAttribute("datas", rwmatrService.rwmatrSafStcList(vo));
		System.out.println(rwmatrService.rwmatrSafStcList(vo));
		return "grid";
	}
	
	//uph 리스트 검색
	@RequestMapping("/rwmatr/rwmatrUphList.do")
	public String rwmatrUphList(RwmatrVO vo, Model model) {
		System.out.println("uph 조회");
		model.addAttribute("datas", rwmatrService.rwmatrUphList(vo));
		System.out.println(rwmatrService.rwmatrUphList(vo));
		return "grid";
	}
	
	//안전재고 수정
	@PostMapping("/rwmatr/rwmatrModifyData.do")
	@ResponseBody
	public String modifyData(RwmatrVO vo) {
		System.out.println(vo);
		rwmatrMapper.updateRwmatr(vo);
		return "grid";
	}
}
