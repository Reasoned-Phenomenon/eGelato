package com.gelato.app.rwmatr.infer.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gelato.app.rwmatr.infer.dao.RwmatrInferVO;
import com.gelato.app.rwmatr.infer.service.RwmatrInferService;

@Controller
public class RwmatrInferController {

	@Autowired RwmatrInferService rwmatrInferService;
	
	//원자재 불량 관리 페이지로 이동
	@RequestMapping("/rwmatr/rwmatrInfer.do")
	public String rwmatrInfer() {
		return "tiles/rwmatr/rwmatrInfer";
	}
	
	//원자재 불량리스트 조회
	@RequestMapping("/rwmatr/rwmatrInferList.do")
	public String rwmatrInferList(RwmatrInferVO vo, Model model) {
		System.out.println("원자재 입고내역 조회");
		model.addAttribute("datas", rwmatrInferService.RwmatrInferList(vo));
		System.out.println(rwmatrInferService.RwmatrInferList(vo));
		return "grid";
	}
}
