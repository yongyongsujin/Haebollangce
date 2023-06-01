package com.sist.haebollangce.challenge.controller;

import com.sist.haebollangce.challenge.dto.ChallengeDTO;
import com.sist.haebollangce.challenge.service.InterChallengeService;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/challenge")
public class ChallengeController {

    @Autowired
    private InterChallengeService service;

 // 헤더의 챌린지 인증 페이지 클릭시 (참여중인 챌린지 목록)
    @RequestMapping(value="/certifyList")
    public ModelAndView challenge_certify(ModelAndView mav, HttpServletRequest request) {
    	
    	// 로그인 유저인지 확인
    	
    	int ing_count = 0;  // 초기값 설정
    	int before_count = 0;  // 초기값 설정
    	
    	List<ChallengeDTO> chaList = service.getJoinedChaList();
    	
    	
    	for (ChallengeDTO chaDTO : chaList) {
    	    
    	    String str_startDate = chaDTO.getStartDate(); // chaDTO에서 시작 날짜를 가져옴
    	    String str_endDate = chaDTO.getEnddate();
            String pattern = "yyyy-MM-dd"; // 시작 날짜의 형식에 맞는 패턴을 지정
            Date startDate = null;
            Date endDate = null;
            
            SimpleDateFormat sdf = new SimpleDateFormat(pattern);
            try {
                startDate = sdf.parse(str_startDate);
                endDate = sdf.parse(str_endDate);
            } catch (Exception e) {
                e.printStackTrace();
            }
    	    Date today = new Date();  // 현재 날짜

    	    // 현재 날짜와 챌린지의 시작일, 종료일을 비교하여 증가시킬 변수 값을 계산
    	    if (startDate.compareTo(today) <= 0 && endDate.compareTo(today) >= 0) {
    	    	ing_count++;
    	    } else if (startDate.compareTo(today) > 0) {
    	    	before_count++;
    	    }
    	}

    	mav.addObject("ing_count", ing_count);
    	mav.addObject("before_count", before_count);
    	mav.addObject("chaList", chaList);
    	
    	mav.setViewName("certify/certifyList.tiles1");
    	// /WEB-INF/views/tiles1/certify/certifyList.jsp
    	return mav;
    }
    
    // 챌린지 참가하는 페이지
    @RequestMapping(value="/join")
    public ModelAndView challenge_join(ModelAndView mav) {
    	
    	mav.setViewName("certify/join.tiles1");
    	// /WEB-INF/views/tiles1/certify/join.jsp
    	return mav;
    }
    
    // 참가하기 완료버튼 클릭시 팝업창 연결
    @RequestMapping(value="/joinEnd")
    public ModelAndView joinEnd(ModelAndView mav) {
    	
    	// 로그인 검사
    	// tbl_challenge_info 에 insert 
    	mav.setViewName("tiles1/certify/joinEnd");
    	return mav;
    }
 
    // 인증하기 버튼 클릭시
    @RequestMapping(value="/certify")
    public ModelAndView certify(ModelAndView mav) {

    	mav.setViewName("certify/certify.tiles1");
    	return mav;
    }
    
    // 참가중인 챌린지 클릭시 내 인증정보 페이지 이동
    @RequestMapping(value="/certifyMyInfo")
    public ModelAndView certifyMyInfo(ModelAndView mav) {

    	mav.setViewName("certify/certifyMyInfo.tiles1");
    	return mav;
    }
    
}
