package com.sist.haebollangce.challenge.service;

import com.sist.haebollangce.challenge.dao.InterChallengeDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChallengeService implements InterChallengeService {

    @Autowired
    private InterChallengeDAO dao;

}
