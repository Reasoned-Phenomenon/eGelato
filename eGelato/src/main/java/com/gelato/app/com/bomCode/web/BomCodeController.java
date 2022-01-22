package com.gelato.app.com.bomCode.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.com.bomCode.dao.BomCodeVO;
import com.gelato.app.com.bomCode.service.BomCodeService;
import com.gelato.app.vr.ModifyVO;

@Controller
public class BomCodeController {
	
	@Autowired BomCodeService bomcodeService;
	
	// 제품 BOM 관리 페이지로 이동.
	@RequestMapping("/com/comBom.do")
	public String comBom() {
		return "tiles/common/comBom";
	}
	
	// 제품BOM list 출력 조회.
	@RequestMapping("/com/findBomList.do")
	public String findBomList(Model model, BomCodeVO vo) {
		    System.out.println("vvvvv");
			model.addAttribute("datas", bomcodeService.findBomList(vo));
			return "grid";
	}
	
	// Modify 등록.
	@PutMapping("/com/bomCodeModifyData.do")
	@ResponseBody
	public boolean modifyData (@RequestBody ModifyVO<BomCodeVO> mvo) {
		System.out.println(mvo);
		bomcodeService.modifyBomCode(mvo);
		return true;
	}
	
	
	// 제품 검색 버튼 눌럿을때  모달 창 함수가 컨트롤러에 오고 리턴으로 모달창 띄울 jsp 적어줌.
	@RequestMapping("com/bomModal.do")
	public String vendModal(Model model) {
		System.out.println("모달모달모달");
		return "/common/bomModal"; // 모달 주소 적어야 한다.
	}
	
	// 모달창으로 원자재 제품코드 조회.
	@RequestMapping("/com/bomModalModal.do")
	public String vendList(Model model) {
		System.out.println("제품 검색");
		model.addAttribute("datas", bomcodeService.rwmatrList());
		return "grid"; 
	}
	
}
