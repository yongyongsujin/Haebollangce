package com.sist.haebollangce.user.dao;

public interface InterUserDAO {

    int submit(String userid);

    String findById(String id);
}
