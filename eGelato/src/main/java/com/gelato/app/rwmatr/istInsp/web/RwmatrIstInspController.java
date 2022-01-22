package com.gelato.app.rwmatr.istInsp.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.rwmatr.istInsp.dao.RwmatrIstInspVO;
import com.gelato.app.rwmatr.istInsp.service.RwmatrIstInspService;
import com.gelato.app.vr.ModifyVO;

@Controller
public class RwmatrIstInspController {

	@Autowired RwmatrIstInspService rwmatrIstInspService;
	
	//원자재 검사 페이지로 이동
	@RequestMapping("/rwmatr/rwmatrIstInsp.do")
	public String rwmatrIstInsp () {
		return "tiles/rwmatr/rwmatrIstInsp";
	}
	
	//원자재 입고검사내역 조회
	@RequestMapping("/rwmatr/rwmatrIstInspList.do")
	public String rwmatrIstInspList(RwmatrIstInspVO vo, Model model) {
		System.out.println("원자재 입고검사내역 조회");
		model.addAttribute("datas",rwmatrIstInspService.RwmatrIstInspList(vo));
		return "grid";
	}
	
	//발주 modal
	@RequestMapping("/rwmatr/searchOrderDialog.do")
	public String rwmatrOrderDialog() {
		System.out.println("발주리스트 모달");
		return "rwmatr/searchOrderModal"; 
	}
	
	//발주리스트 출력
	@RequestMapping("/rwmatr/orderDetailList.do")
	public String searchOrderList(Model model) {
		System.out.println("원자재리스트");
		model.addAttribute("datas", rwmatrIstInspService.selectOrderDetail());
		System.out.println(rwmatrIstInspService.selectOrderDetail());
		return "grid"; 
	}
	
	
	@PutMapping("/rwmatr/rwmatrIstInspModifyData.do")
	@ResponseBody
	public boolean modifyData (@RequestBody ModifyVO<RwmatrIstInspVO> mvo) {
		System.out.println(mvo);
		rwmatrIstInspService.modifyIstInsp(mvo);
		return true;
	}
}
