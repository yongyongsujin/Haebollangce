package com.sist.haebollangce.challenge.dao;

import com.sist.haebollangce.challenge.dto.ChallengeDTO;
import com.sist.haebollangce.common.mapper.InterMapper;
import com.sist.haebollangce.user.dao.InterUserDAO;
import com.sist.haebollangce.user.dto.UserDTO;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChallengeDAO implements InterChallengeDAO {

    @Autowired
    private InterMapper mapper;
    
    // 참가중인 챌린지 리스트 가져오기
 	@Override
 	public List<ChallengeDTO> getJoinedChaList() {
 		List<ChallengeDTO> chaList = mapper.getJoinedChaList();
 		return chaList;
 	}

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

	
}
