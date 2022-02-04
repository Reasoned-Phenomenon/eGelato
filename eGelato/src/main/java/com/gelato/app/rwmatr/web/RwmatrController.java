package com.gelato.app.rwmatr.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.rwmatr.dao.RwmatrVO;
import com.gelato.app.rwmatr.service.RwmatrService;
import com.gelato.app.vr.ModifyVO;

@Controller
public class RwmatrController {

	@Autowired RwmatrService rwmatrService;
	
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
	@PutMapping("/rwmatr/rwmatrModifyData.do")
	@ResponseBody
	public boolean modifyData (@RequestBody ModifyVO<RwmatrVO> mvo) {
		System.out.println(mvo);
		rwmatrService.modifyRwmatr(mvo);
		return true;
	}
}
