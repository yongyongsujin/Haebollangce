package com.sist.haebollangce.lounge.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.haebollangce.lounge.model.InterLoungeDAO;

@Service
public class LoungeService implements InterLoungeService {

	// === 1. 의존객체 주입 (Type 에 따라 알아서 Bean 을 주입해준다.)
	@Autowired
	private InterLoungeDAO  dao;
	
}
