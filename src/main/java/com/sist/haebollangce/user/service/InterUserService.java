package com.sist.haebollangce.user.service;

import com.sist.haebollangce.user.dto.UserDTO;

public interface InterUserService {

    UserDTO findByUserid(String userid);

    void formSignup(UserDTO signupUser);
}
