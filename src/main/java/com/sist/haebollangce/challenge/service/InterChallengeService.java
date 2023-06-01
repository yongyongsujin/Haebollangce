package com.sist.haebollangce.challenge.service;

import java.util.List;

import com.sist.haebollangce.challenge.dto.ChallengeDTO;

public interface InterChallengeService {
	
	List<ChallengeDTO> getJoinedChaList();
	// 참가중인 챌린지 리스트 가져오기

}
