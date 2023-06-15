package com.sist.haebollangce.challenge.dao;

import java.util.List;
import java.util.Map;

import com.sist.haebollangce.challenge.dto.CertifyDTO;
import com.sist.haebollangce.challenge.dto.ChallengeDTO;
import com.sist.haebollangce.challenge.dto.ChallengeInfoDTO;

public interface InterCertifyDAO {

	List<ChallengeDTO> getJoinedChaList(String fk_userid);
	// 참가중인 챌린지 리스트 가져오기

	ChallengeDTO getOneChallengeInfo(String challenge_code);
	// 챌린지 코드를 받아  그 챌린지의 정보 가져오기

	int joinChallenge(Map<String, String> paraMap);
	// 유저가 챌린지 참가했을 때 - tbl_challenge_info 에 insert

	Map<String, String> checkJoinedChall(Map<String, String> paraMap);
	// 이미 참가한 챌린지인지 확인

	Map<String, String> getCertifyInfo(Map<String, String> paraMap);
	// 인증하려는 챌린지의 인증예시 데이터 가져오기

	String getUserDeposit(String userid);
	// 로그인한 유저의 보유 예치금 알아오기

	int doCertify(Map<String, String> paraMap);
	// 인증 기록 테이블에 insert

	int updateMemberCount(Map<String, String> paraMap);
	// 챌린지 테이블에 참가인원수 update

	Map<String, String> getJoinedChallengeInfo(Map<String, String> paraMap);
	// 유저아이디와 챌린지 코드를 받아  그 챌린지의 참가중인 정보 가져오기 (챌린지 정보 view용)

	List<CertifyDTO> getMyCertifyHistory(Map<String, String> paraMap);
	// 내 인증기록 가져오기

	Map<String, String> getUserAchieveCharts(String challenge_code);
	// 해당 챌린지의 유저들의 달성률 통계 가져오기

	Map<String, String> getUserAchievePct(Map<String, String> paraMap);
	// 아이디와 챌린지 코드로 해당 유저의 달성률(%) 가져오기

	int updateAchievePct(Map<String, String> paraMap);
	// 참여중인 챌린지 정보에서 유저의 달성률 update

	int checkTodayCertify(Map<String, String> paraMap);
	// 오늘 인증하였는지 체크 / return 1이면 오늘 인증 한 것

	int userReport(Map<String, String> paraMap);
	// 유저를 신고했을때 신고테이블에 insert

	List<ChallengeDTO> getAllChallengeList();
	// 전체 챌린지 리스트 가져오기 

	List<ChallengeInfoDTO> getParticipantList(String challenge_code);
	// 챌린지 코드를 받아 해당 챌린지의 참가하고 있는 참가자의 정보 리스트를 가져온다.

	void userRewardAdd(ChallengeInfoDTO chaInfoDTO);
	// 분배된 상금 insert 하기

	int addUserExp(Map<String, String> paraMap);
	// 인증할때마다 유저 경험치 증가시키기

	Map<String, String> checkReport(Map<String, String> paraMap);
	// 로그인한 유저가 신고했던 인증인지 체크하는 메소드

	List<CertifyDTO> getAllCertifyHistory(Map<String, String> paraMap);
	// 모든유저의 인증기록 가져오기 (인증샷)











}
