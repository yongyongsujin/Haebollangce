package com.sist.haebollangce.user.dao;

import com.sist.haebollangce.user.dto.UserDTO;

public interface InterUserDAO {

    int submit(String userid);

    String findById(String id);

    UserDTO getDetail(String userid);
}
