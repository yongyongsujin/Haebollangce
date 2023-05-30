package com.sist.haebollangce.lounge.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sist.haebollangce.lounge.service.InterLoungeService;


@Controller
@RequestMapping("/lounge")
public class LoungeController {

	// === 1. 의존객체 주입 (Type 에 따라 알아서 Bean 을 주입해준다.)
	@Autowired 
	private InterLoungeService service;
	
	// === 2. 라운지 페이지 요청 ===
	@RequestMapping(value = "/loungeList")
	public ModelAndView loungeList(ModelAndView mav, HttpServletRequest request) {
	
		mav.setViewName("lounge/loungeList.tiles1");
		// => /WEB-INF/views/tiles1/lounge/loungeList.jsp 페이지를 만들어야 한다. 
		
		return mav;
	}
	
	// === 3. 라운지 글 1개 보는 페이지 요청 ===
	@RequestMapping(value = "/loungeView")
	public ModelAndView loungeView(ModelAndView mav, HttpServletRequest request) {
	
		mav.setViewName("lounge/loungeView.tiles1");
		// => /WEB-INF/views/tiles1/lounge/loungeView.jsp 페이지를 만들어야 한다. 
		
		return mav;
	}
	
	// === 4. 라운지 글 작성하는 페이지 요청 ===
	@RequestMapping(value = "/loungeAdd")
	public ModelAndView loungeAdd(ModelAndView mav, HttpServletRequest request) {
	
		mav.setViewName("lounge/loungeAdd.tiles1");
		// => /WEB-INF/views/tiles1/lounge/loungeAdd.jsp 페이지를 만들어야 한다. 
		
		return mav;
	}
	
}
