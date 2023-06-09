package com.sist.haebollangce.challenge.service;

import com.sist.haebollangce.challenge.dao.InterChallengeDAO;
import com.sist.haebollangce.challenge.dto.CertifyDTO;
import com.sist.haebollangce.challenge.dto.ChallengeDTO;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ChallengeService implements InterChallengeService {

    @Autowired
    private InterChallengeDAO dao;

   
 // 참가중인 챌린지 리스트 가져오기
 	@Override
 	public List<ChallengeDTO> getJoinedChaList(String fk_userid) {
 		List<ChallengeDTO> chaList = dao.getJoinedChaList(fk_userid);
 		return chaList;
 	}

 	// 챌린지 코드를 받아  그 챌린지의 정보 가져오기
 	@Override
 	public ChallengeDTO getOneChallengeInfo(String challenge_code) {
 		ChallengeDTO chaDTO = dao.getOneChallengeInfo(challenge_code);
 		return chaDTO;
 	}

 	// 유저가 챌린지 참가했을 때 - tbl_challenge_info 에 insert
 	@Override
 	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
 	public int joinChallenge(Map<String, String> paraMap) throws Throwable{
 		int n = 0, m = 0; 
 		
 		m = dao.joinChallenge(paraMap);
 		if (m == 1) {
 			n = dao.updateMemberCount(paraMap);
 			// 챌린지 테이블에 참가인원수 update
 		}
 		
 		return n;
 	}

 	// 이미 참가한 챌린지인지 확인
 	@Override
 	public Map<String, String> checkJoinedChall(Map<String, String> paraMap) {
 		Map<String, String> resultMap = dao.checkJoinedChall(paraMap);
 		return resultMap;
 	}

 	// 인증하려는 챌린지의 인증예시 데이터 가져오기
 	@Override
 	public Map<String, String> getCertifyInfo(Map<String, String> paraMap) {
 		Map<String, String> oneExample = dao.getCertifyInfo(paraMap);
 		return oneExample;
 	}

 	// 로그인한 유저의 보유 예치금 알아오기
 	@Override
 	public String getUserDeposit(String fk_userid) {
 		String userDeposit = dao.getUserDeposit(fk_userid);
 		return userDeposit;
 	}

 	
 	// 인증 기록 테이블에 insert
 	@Override
 	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
 	public int doCertify(Map<String, String> paraMap) throws Throwable {
 		int n = 0, m = 0;
 		
 		m = dao.doCertify(paraMap);
 		// 인증 기록 테이블에 insert
 		
 		if (m==1) {
 			Map<String, String> userAchievePct = dao.getUserAchievePct(paraMap);
 			// 인증이 완료되었으면 해당 유저의 달성률을 계산하여 가져오기
 			paraMap.put("achievement_pct", userAchievePct.get("achievement_pct"));
 			
 			n = dao.updateAchievePct(paraMap);
 			// 참여중인 챌린지 정보에서 유저의 달성률 update
 		}
 		
 		return n;
 	}

 	// 유저아이디와 챌린지 코드를 받아  그 챌린지의 참가중인 정보 가져오기 (챌린지 정보 view용)
 	@Override
 	public Map<String, String> getJoinedChallengeInfo(Map<String, String> paraMap) {
 		Map<String, String> joinedChallInfo = dao.getJoinedChallengeInfo(paraMap);
 		return joinedChallInfo;
 	}

 	// 내 인증기록 가져오기
 	@Override
 	public List<CertifyDTO> getMyCertifyHistory(Map<String, String> paraMap) {
 		List<CertifyDTO> myCertifyHistory = dao.getMyCertifyHistory(paraMap);
 		return myCertifyHistory;
 	}

 	// 해당 챌린지의 유저들의 달성률 통계 가져오기
 	@Override
 	public Map<String, String> getUserAchieveCharts(String challenge_code) {
 		Map<String, String> userAchieveCharts = dao.getUserAchieveCharts(challenge_code);
 		return userAchieveCharts;
 	}

 	// 아이디와 챌린지 코드로 해당 유저의 달성률(%) 가져오기
 	@Override
 	public Map<String, String> getUserAchievePct(Map<String, String> paraMap) {
 		Map<String, String> userAchievePct = dao.getUserAchievePct(paraMap);
 		return userAchievePct;
 	}

 	
 	// 오늘 인증하였는지 체크 / return 1이면 오늘 인증 한 것
 	@Override
 	public int checkTodayCertify(Map<String, String> paraMap) {
 		int n = dao.checkTodayCertify(paraMap);
 		return n;
 	}
 	
 	
 	// ===============================================================================================
 	
	
	// 카테고리 리스트 가져오기 
	@Override
	public List<ChallengeDTO> getcategoryList() {
		
		List<ChallengeDTO> categoryList = dao.getcategoryList();
		
		return categoryList;
	}

	// 인증빈도 리스트 가져오기
	@Override
	public List<ChallengeDTO> getfreq() {
		List<ChallengeDTO> freqList =dao.getfreq();
		return freqList;
	}

	// 챌린지 기간 가져오기 
	@Override
	public List<ChallengeDTO> getduring() {
		List<ChallengeDTO> duringList = dao.getduring();
		
		return duringList;
	}

	// 챌린지 등록하기 
	@Override
	@Transactional
	public int addChallenge(ChallengeDTO challengedto) {
	    int n = dao.addChallenge(challengedto);
	    n += dao.addCertifyHour(challengedto);  // 인증 가능 시간 등록하기 
	    n += dao.addCertifyExam(challengedto);  // 인증 예시 등록하기
	    
	    if(n == 3) {
	    		return n;
	    }
	    else {
	    		return 0;
	    }
	}

	// 챌린지 게시글 조회하기
	@Override
	public ChallengeDTO getview(Map<String, String> paraMap) {
		
		ChallengeDTO challengedto = dao.getview(paraMap);
		
		return challengedto;
	}

	
}
