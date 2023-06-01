package com.sist.haebollangce.challenge.service;

import com.sist.haebollangce.challenge.dao.InterChallengeDAO;
import com.sist.haebollangce.challenge.dto.ChallengeDTO;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChallengeService implements InterChallengeService {

    @Autowired
    private InterChallengeDAO dao;

    // 참가중인 챌린지 리스트 가져오기
	@Override
	public List<ChallengeDTO> getJoinedChaList() {
		List<ChallengeDTO> chaList = dao.getJoinedChaList();
		return chaList;
	}
}
