package com.sist.haebollangce.user.service;

import java.util.List;
import java.util.Map;

import com.google.gson.JsonObject;
import com.sist.haebollangce.user.dto.DepositDTO;
import com.sist.haebollangce.user.dto.RewardDTO;
import com.sist.haebollangce.user.dto.UserDTO;

public interface InterMypageService {
	 
	// 결제하기 시작
	int go_purchase(Map<String, String> paraMap);
	
	// 유저가 보유하고 있는 예치금 알아오기
	// JsonObject user_deposit(String userid);
	
	// 상금 테이블에 전환된 내용 넣기
	int reward_convert(Map<String, String> paraMap);

	// 결제 현황 페이지에서 내역 알아오기
	String search_data(Map<String, String> paraMap);

	// 결제 더보기 페이징 처리하기
	String search_paging_data(Map<String, String> paraMap);
	String get_pagebar(Map<String, String> paraMap);
	
	// 예치금 그래프 보여주기
	String deposit_chart(Map<String, String> paraMap);
	
	// 상금 그래프 보여주기
	String reward_chart(Map<String, String> paraMap);
	
	// 취소 가능 건 알아오기
	String cancel_data(Map<String, String> paraMap);
	
	// 결제 취소하기
	String purchase_cancel(Map<String, String> paraMap);
	
	// 비밀번호 확인 후 회원 정보수정 페이지 가기
	UserDTO select_info(Map<String, String> paraMap);
	
	// 모든 관심태그 가지고오기
	String all_interest(String userid);
	
	// 관심태그 추가하기
	String plus_interest(Map<String, String> paraMap);

	// 관심태그 삭제하기
	String del_interest(Map<String, String> paraMap);

	// 이메일 중복확인 하기
	String select_change_email(String change_email);

	// 사용자 정보 수정하기
	String mypage_info_edit(Map<String, Object> paraMap);
	
	// 회원 탈퇴하기
	int delete_user(Map<String, String> paraMap);
	
	// 찜한 챌린지 불러오기
	String like_challenge(String userid);

	// 찜한 라운지 불러오기
	String like_lounge(String userid);
	
	// 진행중인 챌린지 페이지 정보 가지고오기
	String mypage_challenging(Map<String, String> paraMap);
	
	// 챌린지 추천하기
	String recommend(String userid);

	// 진행중인 챌린지 페이지에서 그래프 그리기
	String graph_challenge_during(String userid);

	// 마이페이지 홈화면 충전도 알아오기
	String user_exp(String userid);

	// 마이페이지 인증 필요한 챌린지 불러오기
	String mypage_certify_challenging(Map<String, String> paraMap);

	// 마이페이지 100% 인증한 챌린지들 불러오기
	String finish_100_count(Map<String, String> paraMap);

	// 마이페이지 홈 챌린지 그래프-챌린지 참여 횟수
	String chart_challenging(Map<String, String> paraMap);
	String chart_category(Map<String, String> paraMap);

	// 엑셀을 만들기 위한 예치금 불러오기
	List<Map<String, String>> deposit_excel(Map<String, String> paraMap);

	// 엑셀을 만들기 위한 상금 불러오기
	List<Map<String, String>> reward_excel(Map<String, String> paraMap);

	// 유저 보유 예치금 총 합만 가져오기
	int user_deposit(Map<String, String> paraMap);

	// 유저 보유 상금 가지고 오기
	RewardDTO all_reward(Map<String, String> paraMap);

	// 유저 보유 예치금
	DepositDTO depo_dto(Map<String, String> paraMap);

	// 비밀번호 변경하기
	void modifyPw(UserDTO udto);

	String image(String userid);




}
