package com.gelato.app.vr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.AbstractView;

import com.fasterxml.jackson.databind.ObjectMapper;

@Component("grid")
public class GridViewResolver extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		System.out.println("gridVR");
		ObjectMapper mapper = new ObjectMapper();
		Object obj = model.get("datas");
		
		System.out.println(obj);
		
		HashMap map = new HashMap();
		map.put("page", 1);
		map.put("totalCount", ((List)obj).size());
		
		HashMap map2 = new HashMap();
		map2.put("contents", obj);
		map2.put("pagination", map);
		
		HashMap map3 = new HashMap();
		map3.put("result", true);
		map3.put("data", map2);
		
		String s = mapper.writeValueAsString(map3);
		response.getWriter().print(s);
		
	}

}
