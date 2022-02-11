package com.gelato.app.com.vendCode.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.com.vendCode.dao.VendCodeVO;
import com.gelato.app.com.vendCode.service.VendCodeService;
import com.gelato.app.vr.ModifyVO;

@Controller
public class VendCodeController {

	@Autowired VendCodeService vendcodeService;
	
	// 거래처 코드관리 페이지로 이동.
	@RequestMapping("/com/vendCode.do")
	public String comBom() {
		System.out.println("거래처 코드 관리 페이지 이동");
		return "tiles/common/vendCode";
	}
	
	// 거래처코드 vendCode list 출력 조회.
	@RequestMapping("/com/vendCodeList.do")
	public String vendCodeList(Model model, VendCodeVO vo) {
	    System.out.println("거래처 코드 list 조회.");
		model.addAttribute("datas", vendcodeService.vendCodeList(vo));
		System.out.println(vendcodeService.vendCodeList(vo));
		return "grid";
	}
	
	// Modify 등록, 수정.
	/*
	 * @PutMapping("/com/vendCodeModifyData.do")
	 * 
	 * @ResponseBody public boolean modifyData (@RequestBody ModifyVO<VendCodeVO>
	 * mvo) { System.out.println(mvo); vendcodeService.modifyVendCode(mvo); return
	 * true; }
	 */

	// 거래처 코드 등록.
	@PostMapping("/com/insertvendCode.do")
	public String insertvendCode(VendCodeVO vo) {
		vendcodeService.insertVendCode(vo);
		return "tiles/common/vendCode";
	}
	
	// 거래처 코드 수정.
	@PostMapping("/com/updatevendCode.do")
	public String updatevendCode(VendCodeVO vo) {
		System.out.println(vo);
		vendcodeService.updateVendCode(vo);
		return "tiles/common/vendCode";
	}
	
}
