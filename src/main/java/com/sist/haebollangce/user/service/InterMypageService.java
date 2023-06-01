package com.sist.haebollangce.user.service;

import java.util.Map;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sist.haebollangce.user.dto.UserDTO;

public interface InterMypageService {
	 
	// 결제하기 시작
	int go_purchase(Map<String, String> paraMap);
	
	// 결제한 예치금을 보유예치금에 추가하기
	int plus_deposit(Map<String, String> paraMap);
	
	// 전환한 상금 감소시키기
	int reward_minus(Map<String, String> paraMap);

	// 상금 테이블에 전환된 내용 넣기
	int reward_convert(Map<String, String> paraMap);

	// 결제 현황 페이지에서 내역 알아오기
	String search_data(Map<String, Object> paraMap);

	// 비밀번호 확인 후 회원 정보수정 페이지 가기
	UserDTO select_info(Map<String, String> paraMap);

	// 이메일 중복확인 하기
	String select_change_email(String change_email);

	// 사용자 정보 수정하기
	String mypage_info_edit(Map<String, Object> paraMap);

	// String profile_upload_ajax(UserDTO udto, MultipartHttpServletRequest mrequest, MultipartFile profile_pic_file);


	
	
	
}
