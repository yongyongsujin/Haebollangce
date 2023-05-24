package com.sist.haebollangce.user.service;

import com.sist.haebollangce.user.dto.UserDTO;

public interface InterUserService {

    int submit(String userid);

    String findById(String id);

    UserDTO getDetail(String userid);
}
