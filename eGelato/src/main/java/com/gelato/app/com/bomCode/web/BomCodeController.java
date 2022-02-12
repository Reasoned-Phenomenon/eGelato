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
		System.out.println("BOM 코드 관리 페이지 이동");
		return "tiles/common/comBom";
	}
	
	// 제품BOM list 출력 조회.
	@RequestMapping("/com/findBomList.do")
	public String findBomList(Model model, BomCodeVO vo) {
		    System.out.println("제품BOM list 조회.");
			model.addAttribute("datas", bomcodeService.findBomList(vo));
			return "grid";
	}
	
	// Modify 등록. 수정
	@PutMapping("/com/bomCodeModifyData.do")
	@ResponseBody
	public boolean modifyData (@RequestBody ModifyVO<BomCodeVO> mvo) {
		System.out.println(mvo);
		bomcodeService.modifyBomCode(mvo);
		return true;
	}
	
	
	// 제품 검색 버튼 눌럿을때  모달 창 함수가 컨트롤러에 오고 리턴으로 모달창 띄울 jsp 적어줌.
	@RequestMapping("/com/bomModal.do")
	public String vendModal(Model model) {
		System.out.println("BomModal");
		return "/common/bomModal"; // 모달 주소 적어야 한다.
	}
	
	// 모달창으로 원자재 제품코드 조회.
	@RequestMapping("/com/bomModalModal.do")
	public String vendList(Model model) {
		System.out.println("제품 검색");
		model.addAttribute("datas", bomcodeService.rwmatrList());
		return "grid"; 
	}
	
	// 그리드 셀 클릭 시 제품코드 명 모달창으로 조회.
	@RequestMapping("/com/searchRwmatrCode.do") 
	public String searchRwmatrCode() {
		System.out.println("제품코드명 모달");
		return "/common/searchRwmatrCodeModal";
	}
	
	// 제품코드 조회.
	@RequestMapping("/com/rwmatrCodeModal.do")
	public String srcModal(Model model) {
		System.out.println("제품코드 조회 확인");
		model.addAttribute("datas", bomcodeService.rwmatrCodeList());
		return "grid";
	}
	
	
	// 그리드 공정코드 셀 클릭시 공정코드 Modal 조회. 
	@RequestMapping("/com/searchPrcsCode.do") 
	public String searchPrcsCode() {
		System.out.println();
		return "/common/searchPrcsCodeModal";
	}
	
	// 공정코드 조회.
	@RequestMapping("/com/prcsCodeModal.do")
	public String prcsModal(Model model, BomCodeVO vo) {
		System.out.println("공정코드 조회 확인");
		System.out.println(vo);
		model.addAttribute("datas", bomcodeService.prcsCodeList(vo));
		return "grid";
	}
	
}
