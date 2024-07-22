package org.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin/*")
public class AdminHomeController {
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String adminIndex() throws Exception{
		
		return "redirect:/admin/goods/categoryList";
	}
	
}
