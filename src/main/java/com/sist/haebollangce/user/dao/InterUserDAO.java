package com.sist.haebollangce.user.dao;

import com.sist.haebollangce.user.dto.UserDTO;

public interface InterUserDAO {

    UserDTO findByUserid(String userid);

    // form 사용자 회원가입
    void formSignup(UserDTO signupUser);

    // Oauth2 사용자 회원가입
    void oauthSignup(UserDTO user);
}
