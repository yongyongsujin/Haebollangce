package com.sist.haebollangce.lounge.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sist.haebollangce.lounge.service.InterLoungeService;


@Controller
public class LoungeController {

	// === 1. 의존객체 주입 (Type 에 따라 알아서 Bean 을 주입해준다.)
	@Autowired 
	private InterLoungeService service;
	
	// === 2. 라운지 페이지 요청 ===
	@RequestMapping(value = "/loungeList.action")
	public ModelAndView list(ModelAndView mav, HttpServletRequest request) {
	
		
		
		return mav;
	}
	
}
