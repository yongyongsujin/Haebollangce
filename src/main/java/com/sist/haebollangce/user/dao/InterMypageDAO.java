package com.sist.haebollangce.user.dao;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sist.haebollangce.user.dto.UserDTO;

public interface InterMypageDAO {
	
	// 결제하기 시작
	int go_purchase(Map<String, String> paraMap);

	// 결제한 예치금을 보유예치금에 추가하기
	int plus_deposit(Map<String, String> paraMap);
	
	// 전환한 상금 감소하기
	int reward_minus(Map<String, String> paraMap);

	// 상금 전환 테이블에 전환된 내용 넣기
	int reward_convert(Map<String, String> paraMap);

	// 결제 현황 페이지에서 예치금 내역 알아오기
	List<Map<String, Object>> search_data(Map<String, Object> paraMap);

	// 결제 현황 페이지에서 상금 내역 알아오기
	List<Map<String, Object>> search_reward(Map<String, Object> paraMap);

	// 비밀번호 확인 후 회원 정보수정 페이지 가기
	UserDTO select_info(Map<String, String> paraMap);

	// 이메일 중복확인 하기
	int select_change_email(String change_email);

	// 사용자 정보 수정하기
	int mypage_info_edit(Map<String, Object> paraMap);


}
