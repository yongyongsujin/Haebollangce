package com.sist.haebollangce.challenge.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sist.haebollangce.challenge.service.InterChallengeService;

@RestController
@RequestMapping("/challenge")
public class ChallengeController {

    @Autowired
    private InterChallengeService service;

    
    
    
    
}
