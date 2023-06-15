package com.sist.haebollangce.challenge.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.haebollangce.challenge.dto.ChallengeDTO;
import com.sist.haebollangce.common.mapper.InterMapper;
import com.sist.haebollangce.lounge.model.LoungeBoardDTO;

@Repository
public class ChallengeDAO implements InterChallengeDAO {

    @Autowired
    private InterMapper mapper;
    

 	// ==================================================================================================
 	
 	

 	// 인증빈도 리스트 가져오기
 	@Override
 	public List<ChallengeDTO> getfreq() {
 		
 		List<ChallengeDTO> freqList = mapper.getfreq();
 		
 		return freqList;
 	}

 	// 챌린지 기간 가져오기 
 	@Override
 	public List<ChallengeDTO> getduring() {
 		
 		List<ChallengeDTO> duringList = mapper.getduring();
 		
 		return duringList;
 	}

 	// 챌린지 등록하기 
	@Override
	public int addChallenge(ChallengeDTO challengedto) {
		
		int n = mapper.addChallenge(challengedto);
		
		return n;
	}
	
	// 인증 가능 시간 등록하기 
	@Override
	public int addCertifyHour(ChallengeDTO challengedto) {
		int n = mapper.addCertifyHour(challengedto);
		return n;
	}

	// 인증 예시 등록하기
	@Override
	public int addCertifyExam(ChallengeDTO challengedto) {
		int n = mapper.addCertifyExam(challengedto);
		return n;
	}

	// 챌린지 게시글 조회하기
	@Override
	public ChallengeDTO getview(Map<String, String> paraMap) {
		
		ChallengeDTO challengedto = mapper.getview(paraMap);
		
		return challengedto;
	}

	@Override
	public List<ChallengeDTO> getcategoryList() {
		List<ChallengeDTO> categoryList = mapper.getcategoryList();
				
		return categoryList;
	}

	// 챌린지 불러오기
	@Override
	public List<challengeVO> challengeList() {
	    
		return mapper.challengeList();
	}

	// 카테고리 불러오기
	@Override
	public List<challengeVO> categoryList() {
		
		
		return mapper.categoryList();
	}

	// 카테고리별 챌린지 불러오기
	@Override
	public List<challengeVO> challengelist() {
		
		
		return mapper.challengelist();
	}
	
	// 챌린지 삭제하기
	@Override
	public challengeVO challViewWithNoAddCount(Map<String, String> paraMap) {
		
		
		return mapper.challViewWithNoAddCount(paraMap);
	}

	// 챌린지 삭제하기 완료요청
	@Override
	public int challengedel(Map<String, String> paraMap) {
		
		int n = mapper.challengedel(paraMap);
		
		return n;
	}

	// 라운지 리스트 불러오기
	@Override
	public List<LoungeBoardDTO> index_loungeList() {
		
		return mapper.index_loungeList();
	}
	
	// 좋아요 되어 있는지 안 되어 있는지 확인 
	@Override
	public int checkLike(Map<String, String> paraMap) {
		int n = mapper.checkLike(paraMap);
			
		return n;
	}

	// 챌린지 북마크(관심)등록
	@Override
	public int challengelikeadd(ChallengeDTO challengedto) {
		int n = mapper.challengelikeadd(challengedto);
			
	//	System.out.println("dao 확인용 : "+ n);
		return n;
	}

	// 챌린지 북마크(관심) 해제
	@Override
	public int likedelete(ChallengeDTO challengedto) {
		int n = mapper.likedelete(challengedto);
			
	//	System.out.println("dao 확인용 : "+ n);
		return n;
	}
}