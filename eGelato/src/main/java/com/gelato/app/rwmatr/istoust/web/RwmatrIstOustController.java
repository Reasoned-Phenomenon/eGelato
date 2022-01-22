package com.gelato.app.rwmatr.istoust.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.rwmatr.istoust.dao.RwmatrioVO;
import com.gelato.app.rwmatr.istoust.service.RwmatrioService;
import com.gelato.app.vr.ModifyVO;

@Controller
public class RwmatrIstOustController {

	@Autowired RwmatrioService rwmatrioService;
	
	//원자재 입고 관리 페이지로 이동
	@RequestMapping("/rwmatr/rwmatrIst.do")
	public String rwmatrIst() {
		return "tiles/rwmatr/rwmatrIst";
	}
	
	//원자재 입고내역 조회
	@RequestMapping("/rwmatr/rwmatrIstList.do")
	public String rwmatrIstList(RwmatrioVO vo, Model model) {
		System.out.println("원자재 입고내역 조회");
		model.addAttribute("datas", rwmatrioService.RwmatrIstList(vo));
		System.out.println(rwmatrioService.RwmatrIstList(vo));
		return "grid";
	}
	
	//원자재 출고 관리 페이지로 이동
	@RequestMapping("/rwmatr/rwmatrOust.do")
	public String rwmatrOust() {
		return "tiles/rwmatr/rwmatrOust";
	}
	
	//원자재 출고내역 조회
	@RequestMapping("/rwmatr/rwmatrOustList.do")
	public String rwmatrOustList(RwmatrioVO vo, Model model) {
		System.out.println("원자재 출고내역 조회");
		model.addAttribute("datas", rwmatrioService.RwmatrOustList(vo));
		System.out.println(rwmatrioService.RwmatrOustList(vo));
		return "grid";
	}
	
	//원자재 검수완료 내역 모달
	@RequestMapping("/rwmatr/rwmatrPassModal.do")
	public String rwmatrPassModal() {
		return "rwmatr/rwmatrPassModal";
	}
	
	//원자재 검수완료 내역 리스트
	@RequestMapping("/rwmatr/rwmatrPassList.do")
	public String rwmatrPassList(RwmatrioVO vo, Model model) {
		System.out.println("자재검수완료 리스트 조회");
		model.addAttribute("datas", rwmatrioService.RwmatrPassList(vo));
		System.out.println(rwmatrioService.RwmatrPassList(vo));
		return "grid";
	}
	
	//원자재 LOT번호 모달(보류)
	@RequestMapping("/rwmatr/rwmatrLotNoModal.do")
	public String rwmatrLotNoModal() {
		return "rwmatr/rwmatrLotNoModal";
	}
	
	//원자재 현재고 모달
	@RequestMapping("/rwmatr/rwmatrStcModal.do")
	public String rwmatrStcModal() {
		return "rwmatr/rwmatrStcModal";
	}
	
	//원자재 현재고 페이지로 이동
	@RequestMapping("/rwmatr/rwmatrStc.do")
	public String rwmatrStc() {
		return "tiles/rwmatr/rwmatrStc";
	}
	
	//원자재 현재고 리스트
	@RequestMapping("/rwmatr/rwmatrStcList.do")
	public String rwmatrStcList(RwmatrioVO vo, Model model) {
		System.out.println("현재고 리스트 조회");
		model.addAttribute("datas", rwmatrioService.RwmatrStcList(vo));
		System.out.println(rwmatrioService.RwmatrStcList(vo));
		return "grid";
	}
	
	//원자재 현재고 리스트(모달)
	@RequestMapping("/rwmatr/rwmatrStcMList.do")
	public String rwmatrStcMList(RwmatrioVO vo, Model model) {
		System.out.println("현재고 리스트 조회");
		model.addAttribute("datas", rwmatrioService.RwmatrStcMList(vo));
		System.out.println(rwmatrioService.RwmatrStcMList(vo));
		return "grid";
	}
	
	//원자재 입고관리 CUD
	@PutMapping("/rwmatr/rwmatrIstModifyData.do")
	@ResponseBody
	public boolean modifyIstData (@RequestBody ModifyVO<RwmatrioVO> mvo) {
		System.out.println(mvo);
		//rwmatroService.modifyRwmatro(mvo); //수정해야함
		return true;
	}
	
	//원자재 출고관리 CUD
	@PutMapping("/rwmatr/rwmatrOustModifyData.do")
	@ResponseBody
	public boolean modifyOustData (@RequestBody ModifyVO<RwmatrioVO> mvo) {
		System.out.println(mvo);
		//rwmatroService.modifyRwmatro(mvo); //수정해야함
		return true;
	}
	
	//원자재 재고관리 CUD
	@PutMapping("/rwmatr/rwmatrStcModifyData.do")
	@ResponseBody
	public boolean modifyStcData (@RequestBody ModifyVO<RwmatrioVO> mvo) {
		System.out.println(mvo);
		//rwmatroService.modifyRwmatro(mvo); //수정해야함
		return true;
	}
	
}
