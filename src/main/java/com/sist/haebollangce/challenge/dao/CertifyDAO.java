package com.sist.haebollangce.challenge.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.haebollangce.challenge.dto.CertifyDTO;
import com.sist.haebollangce.challenge.dto.ChallengeDTO;
import com.sist.haebollangce.challenge.dto.ChallengeInfoDTO;
import com.sist.haebollangce.common.mapper.InterCertifyMapper;

@Repository
public class CertifyDAO implements InterCertifyDAO {

    @Autowired
    private InterCertifyMapper mapper;

    // 참가중인 챌린지 리스트 가져오기
	@Override
	public List<ChallengeDTO> getJoinedChaList(String fk_userid) {
		List<ChallengeDTO> chaList = mapper.getJoinedChaList(fk_userid);
		return chaList;
	}

	// 챌린지 코드를 받아  그 챌린지의 정보 가져오기
	@Override
	public ChallengeDTO getOneChallengeInfo(String challenge_code) {
		ChallengeDTO chaDTO = mapper.getOneChallengeInfo(challenge_code);
		return chaDTO;
	}

	// 유저가 챌린지 참가했을 때 - tbl_challenge_info 에 insert
	@Override
	public int joinChallenge(Map<String, String> paraMap) {
		int n = mapper.joinChallenge(paraMap);
		return n;
	}

	// 이미 참가한 챌린지인지 확인
	@Override
	public Map<String, String> checkJoinedChall(Map<String, String> paraMap) {
		Map<String, String> resultMap = mapper.checkJoinedChall(paraMap);
		return resultMap;
	}

	// 인증하려는 챌린지의 인증예시 데이터 가져오기
	@Override
	public Map<String, String> getCertifyInfo(Map<String, String> paraMap) {
		Map<String, String> oneExample = mapper.getCertifyInfo(paraMap);
		return oneExample;
	}

	// 로그인한 유저의 보유 예치금 알아오기
	@Override
	public String getUserDeposit(String fk_userid) {
		String userDeposit = mapper.getUserDeposit(fk_userid);
		return userDeposit;
	}

	// 인증 기록 테이블에 insert
	@Override
	public int doCertify(Map<String, String> paraMap) {
		int n = mapper.doCertify(paraMap);
		return n;
	}

	
	// 챌린지 테이블에 참가인원수 update
	@Override
	public int updateMemberCount(Map<String, String> paraMap) {
		int n = mapper.updateMemberCount(paraMap);
		return n;
	}

	// 유저아이디와 챌린지 코드를 받아  그 챌린지의 참가중인 정보 가져오기 (챌린지 정보 view용)
	@Override
	public Map<String, String> getJoinedChallengeInfo(Map<String, String> paraMap) {
		Map<String, String> joinedChallInfo = mapper.getJoinedChallengeInfo(paraMap);
		return joinedChallInfo;
	}

	// 내 인증기록 가져오기
	@Override
	public List<CertifyDTO> getMyCertifyHistory(Map<String, String> paraMap) {
		List<CertifyDTO> myCertifyHistory = mapper.getMyCertifyHistory(paraMap);
		return myCertifyHistory;
	}

	// 해당 챌린지의 유저들의 달성률 통계 가져오기
	@Override
	public Map<String, String> getUserAchieveCharts(String challenge_code) {
		Map<String, String> userAchieveCharts = mapper.getUserAchieveCharts(challenge_code);
		return userAchieveCharts;
	}

	// 아이디와 챌린지 코드로 해당 유저의 달성률(%) 가져오기
	@Override
	public Map<String, String> getUserAchievePct(Map<String, String> paraMap) {
		Map<String, String> userAchievePct = mapper.getUserAchievePct(paraMap);
		return userAchievePct;
	}

	// 참여중인 챌린지 정보에서 유저의 달성률 update
	@Override
	public int updateAchievePct(Map<String, String> paraMap) {
		int n = mapper.updateAchievePct(paraMap);
		return n;
	}

	
	// 오늘 인증하였는지 체크 / return 1이면 오늘 인증 한 것
	@Override
	public int checkTodayCertify(Map<String, String> paraMap) {
		int n = mapper.checkTodayCertify(paraMap);
		return n;
	}

	// 유저를 신고했을때 신고테이블에 insert
	@Override
	public int userReport(Map<String, String> paraMap) {
		int n = mapper.userReport(paraMap);
		return n;
	}

	// 전체 챌린지 리스트 가져오기 
	@Override
	public List<ChallengeDTO> getAllChallengeList() {
		List<ChallengeDTO> chaDTO = mapper.getAllChallengeList();
		return chaDTO;
	}

	
	// 챌린지 코드를 받아 해당 챌린지의 참가하고 있는 참가자의 정보 리스트를 가져온다.
	@Override
	public List<ChallengeInfoDTO> getParticipantList(String challenge_code) {
		List<ChallengeInfoDTO> chaInfoDTO = mapper.getParticipantList(challenge_code);
		return chaInfoDTO;
	}

	// 분배된 상금 insert 하기
	@Override
	public void userRewardAdd(ChallengeInfoDTO chaInfoDTO) {
		mapper.userRewardAdd(chaInfoDTO);		
	}

	// 인증할때마다 유저 경험치 증가시키기
	@Override
	public int addUserExp(Map<String, String> paraMap) {
		int n = mapper.addUserExp(paraMap);
		return n;
	}

}
