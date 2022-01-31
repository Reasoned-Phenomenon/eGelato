package com.gelato.app.prd.prdPrcsList.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.prd.prdPrcsList.dao.PrdPrcsListVO;
import com.gelato.app.prd.prdPrcsList.service.PrdPrcsListService;
import com.gelato.app.vr.ModifyVO;

@Controller
public class prdPrcsListController {

	@Autowired PrdPrcsListService prdPrcsListService;
	
	// 공정관리로 이동
	@RequestMapping("/prd/prdPrcsMngList.do")
	public String prdPrcsNow() {
		System.out.println("공정관리 이동");
		return "tiles/prd/prdPrcsMngList";
	}
	
	// 공정목록 출력
	@RequestMapping("/prd/prcsMngList.do")
	public String prcsMngList(PrdPrcsListVO vo ,Model model) {
		System.out.println("공정목록 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdPrcsListService.prcsMngList(vo));
		return "grid";
	}
	
	// 지시목록 modal
	@RequestMapping("/prd/eqmDialog.do")
	public String indicaDialog() {
		System.out.println("미사용설비목록모달");
		return "prd/unUseEqmListModal"; 
	}
	
	//모달창 list
	@RequestMapping("/prd/unUseEqmList.do")
	public String unUseEqmList(Model model) {
		System.out.println("모달 출력");
		model.addAttribute("datas", prdPrcsListService.unUseEqmList());
		return "grid";
	}
	
	// 등록,수정,삭제
	@PutMapping("/prd/prcsModifyData.do")
	@ResponseBody
	public boolean modifyData (@RequestBody ModifyVO<PrdPrcsListVO> mvo) {
		System.out.println(mvo);
		prdPrcsListService.modifyPrcs(mvo);
		return true;
	}
}
