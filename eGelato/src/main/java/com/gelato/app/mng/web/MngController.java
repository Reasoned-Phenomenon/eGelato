package com.gelato.app.mng.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MngController {

	@RequestMapping("/mng/egovMberManage.do")
	public String egovMberManage () {
		
		return "tiles/mng/mberManage";
	}
	
	@RequestMapping("/mng/egovRoleList.do")
	public String egovRoleList () {
		
		return "tiles/mng/egovRoleList";
	}
	
	@RequestMapping("/mng/egovAuthorList.do")
	public String egovAuthorList () {
		
		return "tiles/mng/egovAuthorList";
	}
	
	@RequestMapping("/mng/egovAuthorGroupList.do")
	public String egovAuthorGroupList () {
		
		return "tiles/mng/egovAuthorGroupList";
	}
	
	@RequestMapping("/mng/egovMenuCreatManageSelect.do")
	public String egovMenuCreatManageSelect () {
		
		return "tiles/mng/egovMenuCreatManageSelect";
	}
}
