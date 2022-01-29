package com.gelato.app.prd.prdPlan.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.prd.prdPlan.dao.PrdPlanMngVO;
import com.gelato.app.prd.prdPlan.service.PrdPlanMngService;
import com.gelato.app.vr.ModifyVO;

@Controller
public class PrdPlanMngController {

	@Autowired PrdPlanMngService prdPlanMngService;
	
	//생산계획관리 페이지로 이동
	@RequestMapping("/prd/prdPlanMng.do")
	public String prdPlanMng() {
		System.out.println("생산계획관리 페이지 이동");
		
		// 생산계획관리 페이지
		 return "tiles/prd/prdPlanMng"; 
		
		// 생산계획관리에 들어갈 주문서 modal jsp.
		/* return "tiles/prd/orderShtModal"; */
		
		// 생산계획관리에 들어갈 검색창 modal jsp.
		/* return "tiles/prd/searchPlanModal"; */
		 
		// 생산계획관리에 들어갈 검색창 modal jsp.
		/* return "tiles/prd/prdtListModal"; */
	}
	
	//주문서 modal
	@RequestMapping("prd/orderShtDialog.do")
	public String orderShtDialog() {
		System.out.println("주문서 이동");
		// 생산계획관리에 들어갈 주문서 modal jsp.
		return "prd/orderShtModal"; 
	}
	
	//검색결과 modal
	@RequestMapping("prd/searchPlanDialog.do")
	public String searchPlanDialog() {
		System.out.println("검색창 이동");
		// 생산계획관리에 들어갈 검색창 modal jsp.
		return "prd/searchPlanModal"; 
	}
	
	//제품목록 modal
	@RequestMapping("prd/prdtDialog.do")
	public String prdtDialog() {
		System.out.println("제품목록");
		// 생산계획관리에 들어갈 검색창 modal jsp.
		return "prd/prdtListModal"; 
	}
	
	// 주문서 list 출력
	@RequestMapping("/prd/orderShtModal.do")
	public String OrderShtList(Model model) {
		System.out.println("주문서 list 출력");
		System.out.println(model);
		model.addAttribute("datas", prdPlanMngService.OrderShtList());
		return "grid";
	}
	
	// 검색결과 list 출력
	@RequestMapping("/prd/searchPlanList.do")
	public String SearchPlanList(PrdPlanMngVO vo, Model model) {
		System.out.println("검색결과 출력");
		System.out.println(vo);
		model.addAttribute("datas", prdPlanMngService.SearchPlanList(vo));
		System.out.println(prdPlanMngService.SearchPlanList(vo));
		return "grid";
	}
	
	// 제품목록 list 출력
	@RequestMapping("/prd/prdtList.do")
	public String PrdtList(Model model) {
		System.out.println("제품목록 출력");
		System.out.println(model);
		model.addAttribute("datas", prdPlanMngService.PrdtList());
		return "grid";
	}
	
	// 상세계획그리드에 출력
	@RequestMapping("/prd/chooseOrder.do")
	public String ChooseOrder(Model model, PrdPlanMngVO vo) {
		System.out.println("상세계획 출력");
		model.addAttribute("datas", prdPlanMngService.ChooseOrder(vo));
		System.out.println(prdPlanMngService.ChooseOrder(vo));
		return "grid";
	}
	
	// modify - 등록
	@PutMapping("/prd/modifyPrdPlan.do")
	@ResponseBody
	public boolean modifyPrdPlan (@RequestBody ModifyVO<PrdPlanMngVO> mvo) {
		System.out.println("modi 컨트롤러");
		System.out.println(mvo);
		prdPlanMngService.modifyPrdPlan(mvo);
		System.out.println("modi 컨트롤러2222");
		prdPlanMngService.modifyExcp(mvo);
		System.out.println("홀딩값 추가");
		return true;
	}
	
	// modify - 관리
	@RequestMapping("/prd/modifyCanPrdPlan.do")
	@ResponseBody
	public String modifyCanPrdPlan (@RequestBody PrdPlanMngVO mvo) {
		/*System.out.println("modi 컨트롤러3333");
		System.out.println(mvo);
		PrdPlanMngVO vvv = new PrdPlanMngVO();
		vvv = prdPlanMngService.modifyCanPrdPlan(mvo);
		
		System.out.println(vvv);
		System.out.println(vvv.getMsg());
		*/
		
		HashMap temp = new HashMap<String, String>();
		temp.put("planDetaId", mvo.getPlanDetaId());
		
		prdPlanMngService.modifyCanPrdPlan(temp);
		
		System.out.println(temp.get("msg"));
		return (String) temp.get("msg");
	}
}
