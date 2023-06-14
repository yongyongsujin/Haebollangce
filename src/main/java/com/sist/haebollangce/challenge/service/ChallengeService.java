package com.sist.haebollangce.challenge.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sist.haebollangce.challenge.dao.InterChallengeDAO;
import com.sist.haebollangce.challenge.dao.challengeVO;
import com.sist.haebollangce.challenge.dto.ChallengeDTO;
import com.sist.haebollangce.lounge.model.LoungeBoardDTO;

@Service
public class ChallengeService implements InterChallengeService {

    @Autowired
    private InterChallengeDAO dao;

   
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

	
	
	// 챌린지 불러오기
	@Override
	public List<challengeVO> challengeList() {
		
		List<challengeVO> challengeList = dao.challengeList();
		
		return challengeList;
		
	}

	// 카테고리 불러오기
	@Override
	public List<challengeVO> categoryList() {
		
		List<challengeVO> categoryLsit = dao.categoryList();
		
		return categoryLsit;
	}

	// 카테고리별 챌린지 불러오기
	@Override
	public List<challengeVO> challengelist() {
		
		List<challengeVO> challengelist = dao.challengelist();
		
		
		return challengelist;
		
		
	}
	
	// 챌린지 삭제하기
	@Override
	public challengeVO challViewWithNoAddCount(Map<String, String> paraMap) {
		
		challengeVO challViewWithNoAddCount = dao.challViewWithNoAddCount(paraMap);
		
		return challViewWithNoAddCount;
	}
	
	// 챌린지 삭제하기 완료요청
	@Override
	public int challengedel(Map<String, String> paraMap) {
		
		int n =	dao.challengedel(paraMap);
		
		return n;
	}

	// 라운지 리스트 불러오기
	@Override
	public List<LoungeBoardDTO> index_loungeList() {
		
		List<LoungeBoardDTO> index_loungeList = dao.index_loungeList();
		
		return index_loungeList;
	}
}