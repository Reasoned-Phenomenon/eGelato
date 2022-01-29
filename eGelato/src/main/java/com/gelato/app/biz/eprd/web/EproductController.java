package com.gelato.app.biz.eprd.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.gelato.app.biz.eprd.service.EproductService;

@Controller
public class EproductController {
	
	@Autowired EproductService eproductService;
	
	
}
