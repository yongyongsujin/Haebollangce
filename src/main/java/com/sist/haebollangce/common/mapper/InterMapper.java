package com.sist.haebollangce.common.mapper;

import com.sist.haebollangce.challenge.dto.CertifyDTO;
import com.sist.haebollangce.challenge.dto.ChallengeDTO;
import com.sist.haebollangce.lounge.model.LoungeBoardDTO;
import com.sist.haebollangce.user.dto.UserDTO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface InterMapper {
 
    int test_insert(String userid);

    int fromBoard2(String userid);

    String findById(String id);

    UserDTO getDetail(String userid);

    // === #2. 게시판 글쓰기 완료 요청 ===
	int loungeAdd(LoungeBoardDTO lgboarddto) throws Exception;

	// --- #3-1. 페이징 처리 안한 검색어 없는 전체 글 목록 보기 --- 
	List<LoungeBoardDTO> lgboardListNoSearch();

	// --- #4-1. 글 조회수 증가와 함께 글 1개를 조회 해주는 것 ---
	LoungeBoardDTO lggetView(Map<String, String> paraMap);
	
	// --- #4-1-1. 글 조회수 1 증가 ---
	void lgsetAddReadCount(String seq);

	// === #6. 라운지 글 수정 페이지 요청 완료 ===
	int lgedit(LoungeBoardDTO lgboarddto);

	// === #8. 라운지 글 삭제 페이지 요청 완료 ===
	int lgdel(Map<String, String> paraMap); 
	
	List<ChallengeDTO> getJoinedChaList(String fk_userid);
	// 참가중인 챌린지 리스트 가져오기

	// 인증빈도 리스트 가져오기
	List<ChallengeDTO> getfreq();

	// 챌린지 기간 가져오기 
	List<ChallengeDTO> getduring();

	// 챌린지 등록 완료 
	int addChallenge(ChallengeDTO challengedto);
	
	// 인증 가능 시간 등록하기 
	int addCertifyHour(ChallengeDTO challengedto);

	// 인증 예시 등록하기
	int addCertifyExam(ChallengeDTO challengedto);

	// 챌린지 게시글 조회하기
	ChallengeDTO getview(Map<String, String> paraMap);

	// 카테고리 리스트 가져오기
	List<ChallengeDTO> getcategoryList();

	ChallengeDTO getOneChallengeInfo(String challenge_code);
	// 챌린지 코드를 받아  그 챌린지의 정보 가져오기

	int joinChallenge(Map<String, String> paraMap);
	// 유저가 챌린지 참가했을 때 - tbl_challenge_info 에 insert

	Map<String, String> checkJoinedChall(Map<String, String> paraMap);
	// 이미 참가한 챌린지인지 확인

	Map<String, String> getCertifyInfo(Map<String, String> paraMap);
	// 인증하려는 챌린지의 인증예시 데이터 가져오기

	String getUserDeposit(String fk_userid);
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
	
	
	
	
}
