package com.sist.haebollangce.user.dao;

import org.springframework.stereotype.Repository;
import com.sist.haebollangce.common.mapper.InterMapper;
import com.sist.haebollangce.user.dto.UserDTO;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UserDAO implements InterUserDAO{

    private final InterMapper mapper;

    @Override
    public UserDTO findByUserid(String userid) {
        return mapper.findByUserid(userid);
    }

    @Override
    public void formSignup(UserDTO signupUser) { mapper.formSignup(signupUser); }

    @Override
    public void oauthSignup(UserDTO user) {
        mapper.oauthSignup(user);
    }
}
