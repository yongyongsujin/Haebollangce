package com.sist.haebollangce.challenge.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sist.haebollangce.challenge.dao.InterCertifyDAO;
import com.sist.haebollangce.challenge.dto.CertifyDTO;
import com.sist.haebollangce.challenge.dto.ChallengeDTO;
import com.sist.haebollangce.challenge.dto.ChallengeInfoDTO;

@Service
public class CertifyService implements InterCertifyService {

    @Autowired
    private InterCertifyDAO dao;

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

	// 유저를 신고했을때 신고테이블에 insert
	@Override
	public int userReport(Map<String, String> paraMap) {
		int n = dao.userReport(paraMap);
		return n;
	}

	@Scheduled(cron="0 30 00 * * *") // 매일 00시 30분에 정산시작 cron="0 30 00 * * *"
	public void rewardCalculate() {
		// 스케줄러로 사용되어지는 메소드는 반드시 파라미터는 없어야 한다.
	      
		System.out.println("금일의 챌린지 정산 시작 !");
	    
		List<ChallengeDTO> endChallengeList = dao.getAllChallengeList();
		// 전체 챌린지 리스트 가져오기 
		// where 절 기간 수정해야함
		
		if (endChallengeList.size() > 0) {
			// 종료된 챌린지가 있을 때
			
			for (ChallengeDTO chaDTO : endChallengeList) {
				// 한 챌린지 마다의 정산 (상금을 계산한다)
				
				String challenge_code = chaDTO.getChallengeCode();
				List<ChallengeInfoDTO> chaInfoList = dao.getParticipantList(challenge_code);
				// 챌린지 코드를 받아 해당 챌린지의 참가하고 있는 참가자의 정보 리스트를 가져온다.
				
				System.out.println(challenge_code+"번 챌린지 정산 결과");
				if (chaInfoList.size() > 0) {
					// 참가자가 있을 경우 - 참가자들의 정보를 가져와 정산
					
					int perfectUserTotalDeposit = 0;
					int totalPenalty = 0;
					
					for (ChallengeInfoDTO chaInfoDTO : chaInfoList) {
						// 총 벌금 계산과 100% 달성한 유저들의 예치금 알아오기 
						
						int userEntryFee = Integer.parseInt(chaInfoDTO.getEntryFee());
						int userAchievePct = Integer.parseInt(chaInfoDTO.getAchievementPct());
						
						if ( userAchievePct == 0 ) {
							// 달성률 0퍼인 사람은 참가비 = 벌금
							totalPenalty += userEntryFee;
						}
						else if (userAchievePct != 0 && userAchievePct < 80) {
							// 달성률 80미만인 사람들의 벌금 수급
							totalPenalty += (userEntryFee * (100 - userAchievePct)) / 100;
						}
						else if ( userAchievePct == 100 ) {
							// 달성률 100%인 사람들의 총 예치금 구하기
							perfectUserTotalDeposit += userEntryFee;
						}
						
					} // end chaInfoList - 총 벌금 구하기
					
					System.out.println("이 챌린지의 벌금 합계 : "+totalPenalty);
					System.out.println("이 챌린지의 100% 달성률 유저들의 총 합계 예치금 : "+perfectUserTotalDeposit);

					
					// 상금 분배 시작
					for (ChallengeInfoDTO chaInfoDTO : chaInfoList) {
						
						int userEntryFee = Integer.parseInt(chaInfoDTO.getEntryFee());
						int userAchievePct = Integer.parseInt(chaInfoDTO.getAchievementPct());
						
						int userReward = 0;
						
						if (userAchievePct != 0 && userAchievePct < 80) {
							// 달성률 80미만인 사람들의 상금
							userReward = userEntryFee * userAchievePct / 100;
						}
						else if ( 80 <= userAchievePct && userAchievePct < 100 ) {
							// 달성률 80% 이상 100% 미만인 사람들의 상금
							userReward = userEntryFee;
						}
						else if ( userAchievePct == 100 ) {
							// 달성률 100%인 사람들의 상금
							if (totalPenalty == 0) {
								// 벌금이 안모여졌을 경우 즉, 참가자 모두가 100% 달성률 일 경우
								userReward = userEntryFee;
							}
							else {
								userReward = (int)Math.floor( (totalPenalty * userEntryFee / perfectUserTotalDeposit) / 100) * 100 ;
							}
						}
						
						if (totalPenalty != 0) {
							totalPenalty -= userReward;
						}
						chaInfoDTO.setUserReward(userReward);
						
						try {
							dao.userRewardAdd(chaInfoDTO);
							// 분배된 상금 insert 하기
						} catch (Exception e) {
							e.printStackTrace();
						}
						
					} // 상금 분배 끝
					
					System.out.println("이 챌린지의 회사가 가지는 수수료 (벌금 정산 후 남는 돈) : "+totalPenalty);
					
				} // end if 참가자가 존재할경우
				
			} // end endChallengeList 한 챌린지의 정산
			
		} // end if 종료된 챌린지가 있을 경우
		
		return ;
	}
}
