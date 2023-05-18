package com.sist.haebollangce.common.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface InterMapper {

    int test_insert(String userid);

    int fromBoard2(String userid);

    String findById(String id);
}
