package com.sist.haebollangce.user.service;

import org.springframework.stereotype.Service;
import com.sist.haebollangce.user.dao.InterUserDAO;
import com.sist.haebollangce.user.dto.UserDTO;
import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class UserService implements InterUserService{

    private final InterUserDAO dao;

    @Override
    public UserDTO findByUserid(String userid) {
        return dao.findByUserid(userid);
    }

    @Override
    public void formSignup(UserDTO signupUser) {
        dao.formSignup(signupUser);
    }

}
