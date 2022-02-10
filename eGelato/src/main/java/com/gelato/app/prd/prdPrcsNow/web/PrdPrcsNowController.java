package com.gelato.app.prd.prdPrcsNow.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.prd.prdPrcsNow.dao.PrdPrcsNowVO;
import com.gelato.app.prd.prdPrcsNow.service.PrdPrcsNowService;
import com.gelato.app.rwmatr.order.dao.RwmatroVO;
import com.gelato.app.vr.ModifyVO;

@Controller
public class PrdPrcsNowController {

	@Autowired PrdPrcsNowService prdPrcsNowService;
	
	// 공정실적으로 이동
	@RequestMapping("/prd/inq/prdPrcsNow.do")
	public String prdPrcsNow() {
		System.out.println("공정실적 이동");
		return "tiles/prd/prdPrcsNow";
	}
	
	// 공정목록 modal
	@RequestMapping("/prd/prcsDialog.do")
	public String prcsDialog() {
		System.out.println("공정목록모달");
		return "prd/prcsListModal"; 
	}
	
	// 지시목록 modal
	@RequestMapping("/prd/indicaDialog.do")
	public String indicaDialog() {
		System.out.println("지시목록모달");
		return "prd/indicaPrcsNowModal"; 
	}
	
	// 공정목록 modal 출력
	@RequestMapping("/prd/prcsDialogDeta.do")
	public String prcsDialogDeta(PrdPrcsNowVO vo ,Model model) {
		System.out.println("공정목록 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdPrcsNowService.prcsDialog(vo));
		return "grid";
	}
	
	// 지시목록 modal 출력
	@RequestMapping("/prd/indicaDialogDeta.do")
	public String indicaDialogDeta(PrdPrcsNowVO vo, Model model) {
		System.out.println("지시목록 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdPrcsNowService.indicaDialog(vo));
		return "grid";
	}
	
	// 공정실적 출력
	@RequestMapping("/prd/prcsListGrid.do")
	public String prcsList(PrdPrcsNowVO vo, Model model) {
		System.out.println("공정실적 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdPrcsNowService.prcsList(vo));
		return "grid";
	}
	
	// 불량목록 modal
	@RequestMapping("/prd/prdtInferCodeDialog.do")
	public String prdInferDialog() {
		System.out.println("불량목록모달");
		return "prd/prdtInferCodeModal"; 
	}
	
	// 불량목록 modal 출력
	@RequestMapping("/prd/prdtInferCodeGrid.do")
	public String prdInferCodeGrid(PrdPrcsNowVO vo ,Model model) {
		System.out.println("불량목록 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdPrcsNowService.prdtInferCodeDialog(vo));
		return "grid";
	}
	
	// 불량 내역 upd
	@PutMapping("/prd/updPrdtInferCode.do")
	@ResponseBody
	public boolean modifyData (@RequestBody ModifyVO<PrdPrcsNowVO> mvo) {
		System.out.println(mvo);
		prdPrcsNowService.modifyPrdtPlan(mvo);
		return true;
	}
}
