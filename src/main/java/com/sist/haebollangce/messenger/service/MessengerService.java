package com.sist.haebollangce.messenger.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.haebollangce.messenger.model.InterMessengerDAO;

@Service
public class MessengerService implements InterMessengerService {
	
	// === 의존객체 주입 (Type 에 따라 알아서 Bean 을 주입해준다.)
	@Autowired
	private InterMessengerDAO dao;

}
