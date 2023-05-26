package com.sist.haebollangce.challenge.controller;

import com.sist.haebollangce.challenge.service.InterChallengeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/challenge")
public class ChallengeController {

    @Autowired
    private InterChallengeService service;


}
