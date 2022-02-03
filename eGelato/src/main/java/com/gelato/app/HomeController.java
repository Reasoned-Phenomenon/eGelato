package com.gelato.app;

import java.util.List;
import java.util.Locale;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import egovframework.com.cmm.util.EgovUserDetailsHelper;

@Controller
public class HomeController {
	
	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model, ServletRequest request, ServletResponse response) {
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		HttpSession session = httpRequest.getSession();
		
		//세션에 권한 저장
		List<String> authList = (List<String>)EgovUserDetailsHelper.getAuthorities();
		session.setAttribute("gelatoRole", authList);
		System.out.println("HomeController 권한 저장"+authList);
		
		return "tiles/home/home";
	}
	
}
