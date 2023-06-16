package com.sist.haebollangce.user.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.google.gson.JsonObject;
import com.sist.haebollangce.common.mapper.InterMypageMapper;
import com.sist.haebollangce.user.dto.DepositDTO;
import com.sist.haebollangce.user.dto.RewardDTO;
import com.sist.haebollangce.user.dto.UserDTO;

@Repository
public class MypageDAO implements InterMypageDAO {

	@Autowired
	private InterMypageMapper mapper;

	// 결제하기
	@Override
	public int go_purchase(Map<String, String> paraMap) {
		
		int n = mapper.go_purchase(paraMap);
		
		return n;
	}
	
	// 사용자가 보유하고 있는 예치금 알아오기
	/*
	@Override 
	public int user_deposit(Map<String, String> paraMap) {
	 
	int user_deposit = mapper.user_deposit(paraMap);
	 
	return user_deposit; }
	 */
	
	// 상금 전환 테이블에 전환된 내용 넣기
	@Override
	public int reward_convert(Map<String, String> paraMap) {
		
		int n = mapper.reward_convert(paraMap);
		
		return n;
	}

	// 결제 현황 페이지에서 내역 알아오기
	@Override
	public List<Map<String, Object>> deposit_data(Map<String, String> paraMap) {
		
		List<Map<String, Object>> search_list = mapper.deposit_data(paraMap);
		
		return search_list;
	}
	
	// 유저가 챌린지에 사용한 모든 예치금
	@Override
	public int user_challenge_deposit(String userid) {
		
		int user_challenge_deposit = mapper.user_challenge_deposit(userid);
		
		return user_challenge_deposit;
	}
	
	// 유저가 보유한 상금
	@Override
	public int user_reward(String userid) {
		
		int user_reward = mapper.user_reward(userid);
		
		return user_reward;
	}
	
	// 유저가 전환한 상금
	@Override
	public int user_convert(String userid) {
		
		int user_convert = mapper.user_convert(userid);
		
		return user_convert;
	}
	
	// 결제 취소하기
	@Override
	public int purchase_cancel(Map<String, String> paraMap) {
		
		int purchase_cancel = mapper.purchase_cancel(paraMap);
		
		return purchase_cancel;
	}
	
	// 결제 현황 페이지에서 사용자가 챌린지 참여에 쓴 예치금 내역 알아오기
	@Override
	public List<Map<String, Object>> challenge_during_deposit(Map<String, String> paraMap) {
		
		List<Map<String, Object>> during_deposit_list = mapper.challenge_during_deposit(paraMap);
		
		return during_deposit_list;
	}

	// 결제 현황 페이지에서 상금 내역 알아오기
	@Override
	public List<Map<String, Object>> reward_data(Map<String, String> paraMap) {
		
		List<Map<String, Object>> reward_list = mapper.reward_data(paraMap);
		
		return reward_list;
	}
	
	// 결제 현황 페이지에서 환전한 상금 내역 알아오기
	@Override
	public List<Map<String, Object>> convert_reward_data(Map<String, String> paraMap) {
		
		List<Map<String, Object>> convert_reward_list = mapper.convert_reward_data(paraMap);
		
		return convert_reward_list;
	}
	
	// 결제 현황 페이지에서 예치금 내역 알아오기 -- 페이징처리
	@Override
	public List<Map<String, Object>> deposit_paging_data(Map<String, String> paraMap) {
		
		List<Map<String, Object>> search_list = mapper.deposit_paging_data(paraMap);
		
		return search_list;
	}
	@Override
	public int get_pagebar_purcahse(Map<String, String> paraMap) {

		int total_count = mapper.get_pagebar_purcahse(paraMap);
		
		return total_count;
	}
	
	// 결제 현황페이지에서 챌린지 참여에 쓴 내역 알아오기 -- 페이징처리
	@Override
	public List<Map<String, Object>> challenge_paging_data(Map<String, String> paraMap) {
		
		List<Map<String, Object>> search_list = mapper.challenge_paging_data(paraMap);
		
		return search_list;
	}
	@Override
	public int get_pagebar_challenging(Map<String, String> paraMap) {

		int total_count = mapper.get_pagebar_challenging(paraMap);
		
		return total_count;
	}
	
	// 결제 현황페이지에서 얻은 상금 알아오기 -- 페이징처리
	@Override
	public List<Map<String, Object>> reward_paging_data(Map<String, String> paraMap) {

		List<Map<String, Object>> search_list = mapper.reward_paging_data(paraMap);
		
		return search_list;
	}
	@Override
	public int get_pagebar_reward(Map<String, String> paraMap) {

		int total_count = mapper.get_pagebar_reward(paraMap);
		
		return total_count;
	}
	
	// 결제 현황페이지에서 환전한 상금  알아오기 -- 페이징처리
	@Override
	public List<Map<String, Object>> convert_paging_data(Map<String, String> paraMap) {

		List<Map<String, Object>> search_list = mapper.convert_paging_data(paraMap);
		
		return search_list;
	}
	@Override
	public int get_pagebar_convert(Map<String, String> paraMap) {

		int total_count = mapper.get_pagebar_convert(paraMap);
		
		return total_count;
	}
	
	// 예치금 그래프 보여주기
	@Override
	public List<Map<String, String>> deposit_chart(Map<String, String> paraMap) {
		
		List<Map<String, String>> chart_list = mapper.deposit_chart(paraMap);
		
		return chart_list;
	}
	
	// 상금 그래프 보여주기
	@Override
	public List<Map<String, String>> reward_chart(Map<String, String> paraMap) {
		
		List<Map<String, String>> chart_list = mapper.reward_chart(paraMap);
		
		return chart_list;
	}
		
	// 비밀번호 확인 후 회원 정보수정 페이지 가기
	@Override
	public UserDTO select_info(Map<String, String> paraMap) {
		
		UserDTO udto = mapper.select_info(paraMap);
		
		return udto;
	}
	
	// 모든 관심태그 가지고오기
	@Override
	public List<Map<String, String>> all_interest() {

		List<Map<String, String>> all_interest_list = mapper.all_interest();
		
		return all_interest_list;
	}	
	@Override
	public List<Map<String, String>> user_interest(String userid) {
		
		List<Map<String,String>> interest_list = mapper.user_interest(userid);
		
		return interest_list;
	}

	// 챌린지 추천하기
	@Override
	public List<Map<String, String>> recommend(String userid) {

		List<Map<String, String>> recommend_list = mapper.recommend(userid);
		
		return recommend_list;
	}
	
	// 관심태그 추가하기
	@Override
	public int plus_interest(Map<String, String> paraMap) {
		
		int n = mapper.plus_interest(paraMap);
		
		return n;
	}

	// 관심태그 삭제하기
	@Override
	public int del_interest(Map<String, String> paraMap) {

		int n = mapper.del_interest(paraMap);
		
		return n;
	}
	
	// 이메일 중복확인 하기
	@Override
	public int select_change_email(String change_email) {
		
		int n = mapper.select_change_email(change_email);
		
		return n;
	}

	
	// 사용자 정보 수정하기
	@Override
	public int mypage_info_edit(Map<String, Object> paraMap) {
		 
		int n = mapper.mypage_info_edit(paraMap);
		
		return n;
	}

	// 회원 탈퇴하기
	@Override
	public int delete_user(Map<String, String> paraMap) {

		int n = mapper.delete_user(paraMap);
		
		return n;
	}
	
	// 찜한 챌린지 불러오기
	@Override
	public List<Map<String, Object>> select_like_challenge(String userid) {
		
		List<Map<String, Object>>  like_challenge_list = mapper.select_like_challenge(userid);
		
		return like_challenge_list;
	}
	
	// 찜한 라운지 불러오기
	@Override
	public List<Map<String, Object>> select_like_lounge(String userid) {
		
		List<Map<String, Object>>  like_lounge_list = mapper.select_like_lounge(userid);
		
		return like_lounge_list;
	}
	
	// 진행중인 챌린지 페이지 정보 가지고오기
	@Override
	public List<Map<String, String>> mypage_challenging(Map<String, String> paraMap) {

		List<Map<String, String>> mypage_challenging_list = mapper.mypage_challenging(paraMap);
		
		return mypage_challenging_list;
	}

	// 마이페이지 충전도 불러오기
	@Override
	public int user_exp(String userid) {

		int exp = mapper.user_exp(userid);
		
		return exp;
	}

	// 진행중인 챌린지 중 오늘 하루 인증했는지 여부
	@Override
	public List<Map<String, String>> mypage_certify_challenge(Map<String, String> paraMap) {

		List<Map<String, String>> certify_list = mapper.mypage_certify_challenge(paraMap);
		
		return certify_list;
	}

	// 완료한 챌린지 갯수 불러오기
	@Override
	public int finish_count(Map<String, String> paraMap) {
		
		int n = mapper.finish_count(paraMap);
		
		return n;
	}
	
	// 마이페이지 100% 인증한 챌린지 갯수 불러오기
	@Override
	public int finish_100_count(Map<String, String> paraMap) {
		
		int n = mapper.finish_100_count(paraMap);
		
		return n;
	}

	// 마이페이지 홈 챌린지 그래프-챌린지 참여 횟수
	@Override
	public List<Map<String, String>> chart_challenging(Map<String, String> paraMap) {

		List<Map<String, String>> chart_challenging_list = mapper.chart_challenging(paraMap);
		
		return chart_challenging_list;
	}
	@Override
	public List<Map<String, String>> chart_category(Map<String, String> paraMap) {

		List<Map<String, String>> category_list = mapper.chart_category(paraMap);
		
		// System.out.println("dao userid : " + paraMap.get("userid"));
		// System.out.println("dao userid : " + paraMap.get("month"));
		
		return category_list;
	}

	@Override
	public int user_deposit(Map<String, String> paraMap) {
		
		int user_deposit = mapper.user_deposit(paraMap);
		
		return user_deposit;
	}

	@Override
	public RewardDTO all_reward(Map<String, String> paraMap) {
		
		RewardDTO rdto = mapper.all_reward(paraMap);
		
		return rdto;
	}

	// 유저 보유 예치금
	@Override
	public DepositDTO depo_dto(Map<String, String> paraMap) {

		DepositDTO depo_dto = mapper.depo_dto(paraMap);
		
		return depo_dto;
	}

	@Override
	public void modifyPw(UserDTO udto) {

		mapper.modifyPw(udto);
		
	}

	@Override
	public String image(String userid) {
		String jsonobj = mapper.image(userid);
		
		return jsonobj;
	}
	
	@Override
	public int user_deposit(String userid) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Map<String, Object>> selectList(Map<String, Object> paramMap) {
		
		List<Map<String, Object>> result = mapper.selectList(paramMap);
		
		return result;
	}

	
}
