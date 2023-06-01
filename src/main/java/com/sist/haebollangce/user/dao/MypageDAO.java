package com.sist.haebollangce.user.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sist.haebollangce.common.mapper.InterMypageMapper;
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
	
	// 결제한 예치금을 보유예치금에 추가하기
	@Override
	public int plus_deposit(Map<String, String> paraMap) {

		int plus = mapper.plus_deposit(paraMap);
		
		return plus;
	}

	// 전환한 상금 감소시키기
	@Override
	public int reward_minus(Map<String, String> paraMap) {
		
		int n = mapper.reward_minus(paraMap);
		
		return n;
	}

	// 상금 전환 테이블에 전환된 내용 넣기
	@Override
	public int reward_convert(Map<String, String> paraMap) {
		
		int n = mapper.reward_convert(paraMap);
		
		return n;
	}

	// 결제 현황 페이지에서 내역 알아오기
	@Override
	public List<Map<String, Object>> search_data(Map<String, Object> paraMap) {
		
		List<Map<String, Object>> search_list = mapper.search_data(paraMap);
		
		return search_list;
	}

	// 결제 현황 페이지에서 상금 내역 알아오기
	@Override
	public List<Map<String, Object>> search_reward(Map<String, Object> paraMap) {
		
		List<Map<String, Object>> search_list = mapper.search_reward(paraMap);
		
		return search_list;
	}

	// 비밀번호 확인 후 회원 정보수정 페이지 가기
	@Override
	public UserDTO select_info(Map<String, String> paraMap) {
		
		UserDTO udto = mapper.select_info(paraMap);
		
		return udto;
	}

	// 이메일 중복확인 하기
	@Override
	public int select_change_email(String change_email) {
		
		int n = mapper.select_change_email(change_email);
		
		return n;
	}

	/*
	 * @Override public UserDTO mypage_info_edit(Map<String, String> paraMap) {
	 * 
	 * UserDTO udto = mapper.mypage_info_edit(paraMap);
	 * 
	 * System.out.println(paraMap.get("userid"));
	 * System.out.println(paraMap.get("pw"));
	 * System.out.println(paraMap.get("mobile"));
	 * System.out.println(paraMap.get("email"));
	 * System.out.println(paraMap.get("profile_pic"));
	 * 
	 * 
	 * // System.out.println("mapper n : " + n);
	 * 
	 * return udto; }
	 */
	// 사용자 정보 수정하기
	@Override
	public int mypage_info_edit(Map<String, Object> paraMap) {
		 
		int n = mapper.mypage_info_edit(paraMap);
		
		return n;
	}

	
}
