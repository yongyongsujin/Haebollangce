package com.sist.haebollangce.messenger.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sist.haebollangce.messenger.service.InterMessengerService;


@Controller
@RequestMapping("/messenger")
public class MessengerController {
	
	// === 의존객체 주입 (Type 에 따라 알아서 Bean 을 주입해준다.)
	@Autowired 
	private InterMessengerService service;
	
	// === 메신저 페이지 띄우기 === 
	@GetMapping(value = "/messengerView")
	public ModelAndView messengerView(ModelAndView mav) {
	
		mav.setViewName("messenger/messengerView.tiles1");
		// => /WEB-INF/views/tiles1/messenger/messengerView.jsp view 단을 보여준다. 
		
		return mav;
	}

}
