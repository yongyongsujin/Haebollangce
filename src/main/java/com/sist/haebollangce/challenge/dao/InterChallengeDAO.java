package com.sist.haebollangce.challenge.dao;

import java.util.List;
import java.util.Map;

import com.sist.haebollangce.challenge.dto.ChallengeDTO;
import com.sist.haebollangce.lounge.model.LoungeBoardDTO;

public interface InterChallengeDAO {

	
	// ====================================================================================================
	

	// 인증빈도 리스트 가져오기
	List<ChallengeDTO> getfreq();

	// 챌린지 기간 가져오기 
	List<ChallengeDTO> getduring();

	// 챌린지 등록하기 
	int addChallenge(ChallengeDTO challengedto);

	// 챌린지 게시글 조회하기
	ChallengeDTO getview(Map<String, String> paraMap);

	// 카테고리 리스트 가져오기
	List<ChallengeDTO> getcategoryList();
	
	// 인증 가능 시간 등록하기 
	int addCertifyHour(ChallengeDTO challengedto);
	
	// 인증 예시 등록하기
	int addCertifyExam(ChallengeDTO challengedto);

	
	// 챌린지 불러오기
	List<challengeVO> challengeList();

	// 카테고리 불러오기
	List<challengeVO> categoryList();

	// 카테고리별 챌린지 불러오기
	List<challengeVO> challengelist();
	
	// 챌린지 삭제하기
	challengeVO challViewWithNoAddCount(Map<String, String> paraMap);

	// 챌린지 삭제하기 완료요청
	int challengedel(Map<String, String> paraMap);

	// 라운지 리스트 불러오기
	List<LoungeBoardDTO> index_loungeList();
	
	// 좋아요 되어 있는지 안 되어 있는지 확인  
	int checkLike(Map<String, String> paraMap);

	// 챌린지 북마크(관심)등록
	int challengelikeadd(ChallengeDTO challengedto);

	// 챌린지 북마크(관심)해제
	int likedelete(ChallengeDTO challengedto);
}