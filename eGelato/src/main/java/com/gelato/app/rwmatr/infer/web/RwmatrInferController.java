package com.gelato.app.rwmatr.infer.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.rwmatr.infer.dao.RwmatrInferVO;
import com.gelato.app.rwmatr.infer.service.RwmatrInferService;
import com.gelato.app.vr.ModifyVO;

@Controller
public class RwmatrInferController {

	@Autowired RwmatrInferService rwmatrInferService;
	
	//원자재 불량 조회 페이지로 이동
	@RequestMapping("/rwmatr/inq/rwmatrInfer.do")
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
	
	//원자재 불합격 모달
	@RequestMapping("/rwmatr/rwmatrFailModal.do")
	public String rwmatrFailModal() {
		return "rwmatr/rwmatrFailModal";
	}
	
	//원자재 불합격 리스트
	@RequestMapping("/rwmatr/rwmatrFailList.do")
	public String rwmatrFailList(RwmatrInferVO vo, Model model) {
		System.out.println("자재불합격 리스트 조회");
		model.addAttribute("datas", rwmatrInferService.RwmatrFailList(vo));
		System.out.println(rwmatrInferService.RwmatrFailList(vo));
		return "grid";
	}
	
	//원자재 불량코드 모달
	@RequestMapping("/rwmatr/rwmatrInferCodeModal.do")
	public String rwmatrInferCodeModal() {
		return "rwmatr/rwmatrInferCodeModal";
	}
	
	//원자재 불량코드 리스트
	@RequestMapping("/rwmatr/rwmatrInferCodeList.do")
	public String rwmatrInferCodeList(RwmatrInferVO vo, Model model) {
		System.out.println("원자재 불량코드 조회");
		model.addAttribute("datas", rwmatrInferService.RmatrInferCodeList(vo));
		System.out.println(rwmatrInferService.RmatrInferCodeList(vo));
		return "grid";
	}
	
	//원자재 자재불량 내역 CUD
	@PutMapping("/rwmatr/rwmatrInferModifyData.do")
	@ResponseBody
	public boolean rwmatrInferModifyData (@RequestBody ModifyVO<RwmatrInferVO> mvo) {
		System.out.println(mvo);
		rwmatrInferService.modifyRwmatrInfer(mvo);
		return true;
	}
}
