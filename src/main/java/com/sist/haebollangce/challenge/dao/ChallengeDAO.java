package com.sist.haebollangce.challenge.dao;

import com.sist.haebollangce.challenge.dto.ChallengeDTO;
import com.sist.haebollangce.common.mapper.InterMapper;
import com.sist.haebollangce.user.dao.InterUserDAO;
import com.sist.haebollangce.user.dto.UserDTO;

import java.util.List;

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
}
