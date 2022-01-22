package com.gelato.app.com.mkLot.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gelato.app.com.mkLot.dao.MkLotVO;
import com.gelato.app.com.mkLot.service.MkLotService;

@Controller
public class MkLotController {
 
	@Autowired MkLotService service;
	
	@RequestMapping("/com/mkLot.do")
	@ResponseBody
	public MkLotVO mkLot (MkLotVO vo) {
		System.out.println("여기로 오나");
		return service.findSeq(vo.getItemId());
	}
}
