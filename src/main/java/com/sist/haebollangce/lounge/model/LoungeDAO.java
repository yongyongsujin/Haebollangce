package com.sist.haebollangce.lounge.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.haebollangce.common.mapper.InterMapper;

@Repository
public class LoungeDAO implements InterLoungeDAO {

	// === 1. 의존객체 주입 (Type 에 따라 알아서 Bean 을 주입해준다.)
//  @Resource
//  private SqlSessionTemplate sqlsession;
	@Autowired
	private InterMapper mapper;
	
}
