package com.sist.haebollangce.user.service;

import com.sist.haebollangce.user.dao.InterUserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService implements InterUserService{

    @Autowired
    private InterUserDAO dao;

    @Override
    public int submit(String userid) {
        System.out.println("Service : "+userid);

        int n = dao.submit(userid);
        return n;
    }

    @Override
    public String findById(String id) {
        String pw = dao.findById(id);
        return pw;
    }
}
