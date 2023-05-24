package com.sist.haebollangce.user.dao;

import com.sist.haebollangce.common.mapper.InterMapper;
import com.sist.haebollangce.user.dto.UserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO implements InterUserDAO{

//    @Resource
//    private SqlSessionTemplate sqlsession;
    @Autowired
    private InterMapper mapper;

    @Override
    public int submit(String userid) {
//        System.out.println("DAO  : "+userid);
//        int n = sqlsession.insert("user.test_insert",userid);
//        int n = mapper.test_insert(userid);
        int n = mapper.fromBoard2(userid);
        return n;
    }

    @Override
    public String findById(String id) {
        String pw = mapper.findById(id);
        return pw;
    }

    @Override
    public UserDTO getDetail(String userid) {
        UserDTO user = mapper.getDetail(userid);
        return user;
    }
}
