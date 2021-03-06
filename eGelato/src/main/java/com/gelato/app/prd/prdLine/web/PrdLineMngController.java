package com.gelato.app.prd.prdLine.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.prd.prdLine.dao.PrdLineMngVO;
import com.gelato.app.prd.prdLine.service.PrdLineMngService;
import com.gelato.app.prd.prdPrcs.dao.PrdPrcsMngVO;
import com.gelato.app.vr.ModifyVO;

@Controller
public class PrdLineMngController {

	@Autowired PrdLineMngService prdLineMngService;
	
	//생산계획관리 페이지로 이동
	@RequestMapping("/prd/prdPlanLine.do")
	public String prdLineMng() {
		System.out.println("제품공정흐름도 페이지 이동");
	 return "tiles/prd/prdLineMng"; 
	}
	
	// 그리드1 출력
	@RequestMapping("/prd/lineListGrid.do") 
	public String lineGrid(Model model) {
		System.out.println("라인 출력"); 
		model.addAttribute("datas", prdLineMngService.lineGrid()); 
	return "grid"; 
	}
	  
	// 그리드2 출력
	@RequestMapping("/prd/linePrcsGrid.do") 
	public String linePrcsGrid(PrdLineMngVO vo, Model model) {
		System.out.println("선택라인 공정 출력"); 
		model.addAttribute("datas",prdLineMngService.linePrcsGrid(vo)); 
	return "grid"; 
	}
	 
	// 등록,수정,삭제
	@PutMapping("/prd/modifyLine.do")
	@ResponseBody
	public boolean modifyLine (@RequestBody ModifyVO<PrdLineMngVO> mvo) {
		System.out.println("등록,수정,삭제");
		System.out.println(mvo);
		prdLineMngService.modifyLine(mvo);
		return true;
	}
	
	// 공정이동표 출력
	@RequestMapping("/prd/prdtMoveInfo.do")
	public String prdtMoveInfo(Model model, PrdLineMngVO vo) {
		System.out.println("공정이동표");
		System.out.println(vo);
		model.addAttribute("datas", prdLineMngService.prdtMoveInfo(vo));
		return "grid";
	}
	
	@RequestMapping("/prd/prdtPrcsMoveInfo.do")
	public String prdtPrcsMoveInfo(Model model, PrdPrcsMngVO vo) {
		System.out.println("공정정보");
		System.out.println(vo);
		model.addAttribute("datas", prdLineMngService.prdtPrcsMoveInfo(vo));
		return "grid";
	}
}
