package com.sist.haebollangce.user.dao;

import java.util.List;
import java.util.Map;

import com.google.gson.JsonObject;
import com.sist.haebollangce.user.dto.DepositDTO;
import com.sist.haebollangce.user.dto.RewardDTO;
import com.sist.haebollangce.user.dto.UserDTO;

public interface InterMypageDAO {
	
	// 결제하기 시작
	int go_purchase(Map<String, String> paraMap);

	// 유저가 챌린지에 사용한 모든 예치금
	int user_challenge_deposit(String userid);
	
	// 상금 전환 테이블에 전환된 내용 넣기
	int reward_convert(Map<String, String> paraMap);

	// 사용자가 보유하고 있는 예치금 알아오기
	// int user_deposit(String userid);
	
	// 유저가 보유한 상금
	int user_reward(String userid);
	
	// 유저가 전환한 상금
	int user_convert(String userid);
	
	// 결제 취소하기
	int purchase_cancel(Map<String, String> paraMap);

	// 결제 현황 페이지에서 예치금 내역 알아오기
	List<Map<String, Object>> deposit_data(Map<String, String> paraMap);
	
	// 결제 현황 페이지에서 사용자가 챌린지 참여에 쓴 예치금 내역 알아오기
	List<Map<String, Object>> challenge_during_deposit(Map<String, String> paraMap);

	// 결제 현황 페이지에서 상금 내역 알아오기
	List<Map<String, Object>> reward_data(Map<String, String> paraMap);

	// 결제 현황 페이지에서 환전한 상금 내역 알아오기
	List<Map<String, Object>> convert_reward_data(Map<String, String> paraMap);
	
	// 결제 현황 페이지에서 예치금 내역 알아오기 -- 페이징처리
	List<Map<String, Object>> deposit_paging_data(Map<String, String> paraMap);
	int get_pagebar_purcahse(Map<String, String> paraMap);
	
	// 결제 현황페이지에서 챌린지 참여에 쓴 내역 알아오기 -- 페이징처리
	List<Map<String, Object>> challenge_paging_data(Map<String, String> paraMap);
	int get_pagebar_challenging(Map<String, String> paraMap);

	// 결제 현황페이지에서 얻은 상금 알아오기 -- 페이징처리
	List<Map<String, Object>> reward_paging_data(Map<String, String> paraMap);
	int get_pagebar_reward(Map<String, String> paraMap);

	// 결제 현황페이지에서 환전한 상금  알아오기 -- 페이징처리
	List<Map<String, Object>> convert_paging_data(Map<String, String> paraMap);
	int get_pagebar_convert(Map<String, String> paraMap);

	// 예치금 그래프 보여주기
	List<Map<String, String>> deposit_chart(Map<String, String> paraMap);
	
	// 상금 그래프 보여주기
	List<Map<String, String>> reward_chart(Map<String, String> paraMap);
	
	// 비밀번호 확인 후 회원 정보수정 페이지 가기
	UserDTO select_info(Map<String, String> paraMap);

	// 모든 관심태그 가지고오기
	List<Map<String, String>> all_interest();
	
	// 관심태그 가지고오기
	List<Map<String, String>> user_interest(String userid);
	
	// 챌린지 추천하기
	List<Map<String, String>> recommend(String userid);
	
	// 관심태그 추가하기
	int plus_interest(Map<String, String> paraMap);
		
	// 관심태그 삭제하기
	int del_interest(Map<String, String> paraMap);
	
	// 이메일 중복확인 하기
	int select_change_email(String change_email);

	// 사용자 정보 수정하기
	int mypage_info_edit(Map<String, Object> paraMap);

	// 회원 탈퇴하기
	int delete_user(Map<String, String> paraMap);

	// 찜한 챌린지 불러오기
	List<Map<String, Object>> select_like_challenge(String userid);
	
	// 찜한 라운지 불러오기
	List<Map<String, Object>> select_like_lounge(String userid);

	// 진행중인 챌린지 페이지 정보 가지고오기
	List<Map<String, String>> mypage_challenging(Map<String, String> paraMap);

	// 마이페이지 충전도 불러오기
	int user_exp(String userid);
	
	// 진행중인 챌린지 중 오늘 하루 인증했는지 여부
	List<Map<String, String>> mypage_certify_challenge(Map<String, String> paraMap);

	// 완료한 챌린지 갯수 불러오기
	int finish_count(Map<String, String> paraMap);
	
	// 마이페이지 100% 인증한 챌린지 갯수 불러오기
	int finish_100_count(Map<String, String> paraMap);

	// 마이페이지 홈 챌린지 그래프-챌린지 참여 횟수
	List<Map<String, String>> chart_challenging(Map<String, String> paraMap);
	List<Map<String, String>> chart_category(Map<String, String> paraMap);

	int user_deposit(Map<String, String> paraMap);

	RewardDTO all_reward(Map<String, String> paraMap);

	// 유저 보유 예치금
	DepositDTO depo_dto(Map<String, String> paraMap);

	void modifyPw(UserDTO udto);

	String image(String userid);

	int user_deposit(String userid);

	List<Map<String, Object>> selectList(Map<String, Object> paramMap);

	
}
