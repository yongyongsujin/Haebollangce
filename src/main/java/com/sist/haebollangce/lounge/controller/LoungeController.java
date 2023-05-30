package com.sist.haebollangce.lounge.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sist.haebollangce.lounge.model.LoungeBoardVO;
import com.sist.haebollangce.lounge.service.InterLoungeService;


@Controller
@RequestMapping("/lounge")
public class LoungeController {

	// === 1. 의존객체 주입 (Type 에 따라 알아서 Bean 을 주입해준다.)
	@Autowired 
	private InterLoungeService service;
	
	// === 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI : Dependency Injection) ===  
	// @Autowired  
	// private FileManager fileManager;
	
	
	// === 라운지 글 1개 보는 페이지 요청 ===
	@RequestMapping(value = "/loungeView")
	public ModelAndView loungeView(ModelAndView mav, HttpServletRequest request) {
	
		mav.setViewName("lounge/loungeView.tiles1");
		// => /WEB-INF/views/tiles1/lounge/loungeView.jsp 페이지를 만들어야 한다. 
		
		return mav;
	}
	
	// === #1. 라운지 글 작성하는 form 페이지 요청 === (#51. aop 사용으로 수정 필요)
	@RequestMapping(value = "/loungeAdd", method= {RequestMethod.GET})
	public ModelAndView loungeAdd(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) {
	
		mav.setViewName("lounge/loungeAdd.tiles1");
		// => /WEB-INF/views/tiles1/lounge/loungeAdd.jsp 페이지를 만들어야 한다. 
		
		return mav;
	}
	
	// === #2. 라운지 글쓰기 완료 요청 === (#54.)
	@RequestMapping(value = "/loungeAddEnd", method= {RequestMethod.POST})
	public ModelAndView loungeAdd(ModelAndView mav, LoungeBoardVO lgboardvo) {
		
		int n = service.loungeAdd(lgboardvo);
		
		if(n==1) {
			mav.setViewName("redirect:/loungeList");
			// => /WEB-INF/views/tiles1/lounge/loungeList.jsp 
		}
		else {
			mav.setViewName("lounge/error/add_error.tiles1");
			// => /WEB-INF/views/tiles1/lounge/error/add_error.jsp 페이지를 만들어야 한다. 
		}
		
		return mav;
	}
	
	
	// === #3. 라운지 글목록 보기 페이지 요청 === (#58.)
	@RequestMapping(value = "/loungeList")
	public ModelAndView loungeList(ModelAndView mav) {
	
		List<LoungeBoardVO> lgboardList = null; // 글이 없을 수도 있으니까 default 값으로 null 설정
		
		// --- 페이징 처리 안한 검색어 없는 전체 글 목록 보기 ---
		lgboardList = service.lgboardListNoSearch();
		
		mav.addObject("lgboardList", lgboardList);
		mav.setViewName("lounge/loungeList.tiles1");
		// => /WEB-INF/views/tiles1/lounge/loungeList.jsp 페이지를 만들어야 한다. 
		
		return mav;
	}	
	
	
}
