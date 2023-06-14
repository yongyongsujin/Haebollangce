package com.sist.haebollangce.challenge.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

public interface InterCertifyService {

	String checkJoinedChall(HttpServletRequest request);
	// 이미 참가한 챌린지인지 확인
	
	ModelAndView getJoinedChaList(ModelAndView mav);
	// 참가중인 챌린지 리스트 가져오기

	int joinChallenge(HttpServletRequest request) throws Throwable;
	// 유저가 챌린지 참가했을 때 - tbl_challenge_info 에 insert

	int doCertify(ModelAndView mav, MultipartHttpServletRequest mrequest) throws Throwable;
	// 인증 기록 테이블에 insert

	ModelAndView checkTodayCertify(ModelAndView mav, HttpServletRequest request);
	// 오늘 인증하였는지 체크 / return 1이면 오늘 인증 한 것

	void userReport(HttpServletRequest request);
	// 유저를 신고했을때 신고테이블에 insert

	void certifyMyInfo(HttpServletRequest request);
	// 내 인증정보 가져오기









}
