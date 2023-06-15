package com.sist.haebollangce.challenge.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.sist.haebollangce.challenge.service.InterCertifyService;

@Controller
public class CertifyController {

    @Autowired
    private InterCertifyService service;

    // 챌린지 참가하는 페이지
    @RequestMapping(value="/challenge/join")
    public String challenge_join(HttpServletRequest request) {
    	
    	service.checkJoinedChall(request);
    	// 이미 참가한 경우 - tiles1/certify/swal_msg
    	// 정상적으로 참가한 경우 - /WEB-INF/views/tiles1/certify/join.jsp
    	return service.checkJoinedChall(request);
    }
    
    // 참가하기 완료버튼 클릭시 팝업창 연결
    @RequestMapping(value="/challenge/joinEnd")
    public String challenge_joinEnd(HttpServletRequest request) {
    	
    	int n = 0;
    	try {
			n = service.joinChallenge(request);
		} catch (Throwable e) {
			e.printStackTrace();
		}
    	
    	if (n==1) {
    		return "tiles1/certify/joinEnd";
    	}
    	
    	String message = "참가중에 알 수 없는 에러가 발생했습니다.<br>관리자에게 문의하세요";
		String loc = request.getContextPath()+"/challenge/challenge_all";
		String icon = "info";
		
		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		request.setAttribute("icon", icon);
		
		return "tiles1/certify/swal_msg";
    }
    
    
    // 헤더의 챌린지 인증 페이지 클릭시 (참여중인 챌린지 목록)
    @RequestMapping(value="/challenge/certifyList")
    public ModelAndView certifyList(ModelAndView mav, HttpServletRequest request) {
    	
    	mav = service.getJoinedChaList(mav, request);
    	
    	mav.setViewName("certify/certifyList.tiles1");
    	// /WEB-INF/views/tiles1/certify/certifyList.jsp
    	
    	return mav;
    }
    
 
    // 인증하기 버튼 클릭시 (view페이지)
    @GetMapping(value="/challenge/certify")
    public ModelAndView certify(ModelAndView mav, HttpServletRequest request) {

    	mav = service.checkTodayCertify(mav, request);
    	// views/tiles1/certify/certify.jsp
    	return mav;
    }
    
    // 인증페이지에서 인증완료시
    @PostMapping(value="/challenge/certify")
    public ModelAndView certify(ModelAndView mav, MultipartHttpServletRequest mrequest) {

		int n = 0;
		
		try {
			n = service.doCertify(mav, mrequest);
			// 트랜잭션 처리
		} catch (Throwable e) {
			e.printStackTrace();
			// 인증이 실패되었을 경우 - challenge_info 테이블에 달성률의 체크제약 조건 0 ~ 100 안의 숫자만 가능 
			// 100%가 넘는 인증일 경우 종료된 챌린지이어야함
			
			String message = "모든 인증을 완료한 챌린지입니다.";
    		String loc = mrequest.getContextPath()+"/challenge/certifyList";
    		String icon = "info";
    		
    		mav.addObject("message", message);
    		mav.addObject("loc", loc);
    		mav.addObject("icon", icon);
    		
    		mav.setViewName("tiles1/certify/swal_msg");
    		
    		return mav;
		}
		
		if (n==1) {
			// 인증이 완료되었을 경우

			String message = "인증이 완료되었습니다 !";
    		String loc = mrequest.getContextPath()+"/challenge/certifyList";
    		String icon = "success";
    		
    		mav.addObject("message", message);
    		mav.addObject("loc", loc);
    		mav.addObject("icon", icon);
    		
    		mav.setViewName("tiles1/certify/swal_msg");
		} 
		
		return mav;
    }
    
    // 참가중인 챌린지 클릭시 내 인증정보 페이지 이동
    @RequestMapping(value="/challenge/certifyMyInfo")
    public String certifyMyInfo(HttpServletRequest request) {

    	service.certifyMyInfo(request);
    	return "certify/certifyMyInfo.tiles1";
    }
    
    
    // 유저가 신고했을 때
    @PostMapping(value="/challenge/userReport")
    public String userReport(HttpServletRequest request) {
    	
    	service.userReport(request);
    	return "tiles1/certify/swal_msg";
    }
    
    
}
