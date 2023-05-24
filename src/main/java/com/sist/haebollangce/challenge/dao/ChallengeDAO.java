package com.sist.haebollangce.challenge.dao;

import com.sist.haebollangce.common.mapper.InterMapper;
import com.sist.haebollangce.user.dao.InterUserDAO;
import com.sist.haebollangce.user.dto.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChallengeDAO implements InterChallengeDAO {

    @Autowired
    private InterMapper mapper;

}
