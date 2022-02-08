package com.gelato.app.prd.prdPrcs.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.prd.prdPrcs.dao.PrdPrcsMngVO;
import com.gelato.app.prd.prdPrcs.service.PrdPrcsMngService;
import com.gelato.app.vr.ModifyVO;

@Controller
public class PrdPrcsMngController {
	
	@Autowired PrdPrcsMngService prdPrcsMngService;

	//생산관리로 이동
	@RequestMapping("/prd/prdPrcsMng.do")
	public String prdPrcsMng() {
		System.out.println("생산관리 이동");
		return "tiles/prd/prdPrcsMng";
	}
	
	//모달창 이동
	@RequestMapping("/prd/nonPrcsDialog.do")
	public String nonPrcsDialog() {
		System.out.println("생산지시조회 모달");
		return "prd/indicaPrcsModal";
	}
	
	//모달창 list
	@RequestMapping("/prd/chooseIndica.do")
	public String chooseIndica(PrdPrcsMngVO vo ,Model model) {
		System.out.println("모달 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdPrcsMngService.chooseIndica(vo));
		return "grid";
	}
	
	//그리드1출력
	@RequestMapping("/prd/selectIndica.do")
	public String selectIndica(PrdPrcsMngVO vo ,Model model) {
		System.out.println("지시 선택값 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdPrcsMngService.selectIndica(vo));
		return "grid";
	}
	
	//그리드2출력
	@RequestMapping("/prd/prcsList.do")
	public String prcsList(PrdPrcsMngVO vo ,Model model) {
		System.out.println("공정리스트 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdPrcsMngService.prcsList(vo));
		return "grid";
	}
	
	//공정이동표 이동
	@RequestMapping("/prd/prcsMoveDialog.do")
	public String prcsMoveDialog() {
		return "prd/prcsMoveList";
	}
	
	//생산시작
	@PutMapping("/prd/modifyPrcs.do")
	@ResponseBody
	public boolean modifyPrcs(@RequestBody ModifyVO<PrdPrcsMngVO> mvo) {
		System.out.println("생산 시작");
		prdPrcsMngService.modifyPrcs(mvo);
		
		System.out.println(mvo);
		System.out.println(mvo.getUpdatedRows().size());
		
		for ( int i = 0 ; i < mvo.getUpdatedRows().size() ; i++) {
			System.out.println("공정돌리기" + i);
			prdPrcsMngService.startSche(mvo.getUpdatedRows().get(i));
		}
		
		return true;
	}
	
	//생산중지
	@RequestMapping( value = "/prd/prcsStStop.do", method = RequestMethod.POST)
	@ResponseBody
	public int prcsStStop(@RequestBody List<PrdPrcsMngVO> vo) {
		System.out.println("생산 중지");
		prdPrcsMngService.prcsStStop(vo);
		
		for (int i = 0 ; i < vo.size() ; i++) {
			System.out.println(vo.get(i));
			prdPrcsMngService.stopSche(vo.get(i));
		}
		return 0;
	}
	
	//생산재시작
	@RequestMapping( value = "/prd/prcsStRest.do", method = RequestMethod.POST)
	@ResponseBody
	public int prcsStRest(@RequestBody List<PrdPrcsMngVO> vo) {
		System.out.println("생산 재시작");
		prdPrcsMngService.prcsStRest(vo);

		for (int i = 0 ; i < vo.size() ; i++) {
			System.out.println(vo.get(i));
			prdPrcsMngService.restartSche(vo.get(i));
		}
		
		return 0;
	}
	
	// 생산량 가지고오기
	@PostMapping("/prd/selectQy.do")
	public String selectQy(PrdPrcsMngVO vo ,Model model) {
		System.out.println("생산량 가지고옴");
		System.out.println(vo);
		model.addAttribute("datas",prdPrcsMngService.selectQy(vo));
		return "grid";
	}
}
