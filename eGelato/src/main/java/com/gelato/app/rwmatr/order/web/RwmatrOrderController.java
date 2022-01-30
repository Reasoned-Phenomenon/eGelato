package com.gelato.app.rwmatr.order.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.rwmatr.dao.RwmatrVO;
import com.gelato.app.rwmatr.order.dao.RwmatroVO;
import com.gelato.app.rwmatr.order.service.RwmatroService;
import com.gelato.app.rwmatr.service.RwmatrService;
import com.gelato.app.vr.ModifyVO;

@Controller
public class RwmatrOrderController {

	@Autowired RwmatroService rwmatroService;
	@Autowired RwmatrService rwmatrService;
	
	//발주 관리 페이지로 이동
	@RequestMapping("/rwmatr/rwmatrOrder.do")
	public String rwmatrOrder () {
		return "tiles/rwmatr/rwmatrOrder";
	}
	
	//발주 리스트 조회(마스터)
	@RequestMapping("/rwmatr/rwmatrOrderMasterList.do")
	public String rwmatrOrderMasterList(RwmatroVO vo, Model model) {
		System.out.println("발주리스트 조회");
		model.addAttribute("datas",rwmatroService.rwmatrOrderMasterList(vo));
		System.out.println(rwmatroService.rwmatrOrderMasterList(vo));
		return "grid";
	}
	
	//발주 리스트 조회(서브)
	@RequestMapping("/rwmatr/rwmatrOrderSubList.do")
	public String rwmatrOrderSubList(RwmatroVO vo, Model model) {
		System.out.println("발주디테일리스트 조회");
		model.addAttribute("datas",rwmatroService.rwmatrOrderSubList(vo));
		System.out.println(rwmatroService.rwmatrOrderSubList(vo));
		return "grid";
	}
	
	//발주 리스트 조회
	@RequestMapping("/rwmatr/rwmatrOrderList.do")
	public String rwmatrOrderList(RwmatroVO vo, Model model) {
		System.out.println("발주리스트디테일 조회");
		model.addAttribute("datas",rwmatroService.rwmatrOrderList(vo));
		return "grid";
	}
	
	//발주 조회 페이지로 이동
	@RequestMapping("/rwmatr/inq/rwmatrOrderR.do")
	public String rwmatrOrderR() {
		System.out.println("발주조회페이지로 이동");
		return "tiles/rwmatr/rwmatrOrderR";
	}
	
	//원자재 modal
	@RequestMapping("/rwmatr/searchRwmatrDialog.do")
	public String rwmatrDialog() {
		System.out.println("원자재 모달");
		return "rwmatr/searchRwmatrModal"; 
	}
	
	//원자재리스트 출력
	@RequestMapping("/rwmatr/searchRwmatrList.do")
	public String searchRwmatrList(RwmatrVO vo, Model model) {
		System.out.println("원자재리스트");
		model.addAttribute("datas", rwmatrService.rwmatrList(vo));
		System.out.println(rwmatrService.rwmatrList(vo));
		return "grid"; 
	}
	
	//거래처 modal
	@RequestMapping("/rwmatr/searchVendDialog.do")
	public String vendDialog() {
		System.out.println("거래처 모달");
		return "rwmatr/searchVendModal"; 
	}
	
	//거래처리스트 출력
	@RequestMapping("/rwmatr/searchVendList.do")
	public String searchVendDialog(RwmatroVO vo, Model model) {
		System.out.println("거래처리스트");
		model.addAttribute("datas", rwmatroService.selectVendList(vo));
		System.out.println(rwmatroService.selectVendList(vo));
		return "grid"; 
	}
	
	//원자재 발주관리 CUD
	@PutMapping("/rwmatr/rwmatroModifyData.do")
	@ResponseBody
	public boolean modifyData (@RequestBody ModifyVO<RwmatroVO> mvo) {
		System.out.println(mvo);
		rwmatroService.modifyRwmatro(mvo);
		return true;
	}
	
}
