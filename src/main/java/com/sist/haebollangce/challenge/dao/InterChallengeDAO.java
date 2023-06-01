package com.sist.haebollangce.challenge.dao;

import java.util.List;

import com.sist.haebollangce.challenge.dto.ChallengeDTO;

public interface InterChallengeDAO {

	List<ChallengeDTO> getJoinedChaList();
	// 참가중인 챌린지 리스트 가져오기
}
