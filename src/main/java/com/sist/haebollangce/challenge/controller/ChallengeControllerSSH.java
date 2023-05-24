package com.sist.haebollangce.challenge.controller;

import com.sist.haebollangce.challenge.service.InterChallengeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/challenge")
public class ChallengeControllerSSH {

    @Autowired
    private InterChallengeService service;


}
