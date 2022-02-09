package com.gelato.app.home.web;

import java.util.List;
import java.util.Locale;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gelato.app.home.dao.HomeMapper;
import com.gelato.app.home.dao.HomeVO;

import egovframework.com.cmm.util.EgovUserDetailsHelper;

@Controller
public class HomeController {
	
	@Autowired HomeMapper mapper;
	
	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model, ServletRequest request, ServletResponse response, HomeVO vo) {
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession();
		
		//세션에 권한 저장
		List<String> authList = (List<String>)EgovUserDetailsHelper.getAuthorities();
		session.setAttribute("gelatoRole", authList);
		System.out.println("HomeController 권한 저장"+authList);
		
		model.addAttribute("prodQy", mapper.findProd());
		System.out.println(mapper.findProd());
		
		return "tiles/home/home";
	}
	
}
