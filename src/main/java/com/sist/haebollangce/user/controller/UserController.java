package com.sist.haebollangce.user.controller;

import com.sist.haebollangce.user.dto.UserDTO;
import com.sist.haebollangce.user.service.InterUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private InterUserService service;

    @GetMapping("/register")
    public ModelAndView userRegister(HttpServletRequest request, ModelAndView mav) {
        // String ctx = request.getContextPath();
        // System.out.println("ctxpath => "+ctx); ctxpath => ''
        mav.setViewName("test");
        return mav;
    }
    @PostMapping("/register")
    public String submit(HttpServletRequest request) {
        String userid = request.getParameter("userid");
        System.out.println("Controller : "+userid);
        int n = service.submit(userid);
        return "test";
    }

//    @GetMapping("/login")
//    public ModelAndView Login(ModelAndView mav) {
//
//        return mav;
//    }


    @GetMapping("/tiles-test")
    public ModelAndView tiles(ModelAndView mav) {

        mav.setViewName("tiles_test_1.tiles1");
        return mav;
    }

    @GetMapping("/detail/{userid}")
    public ModelAndView showUserDetail(@PathVariable String userid, ModelAndView mav) {

        UserDTO user= service.getDetail(userid);
        mav.addObject("user", user);
        mav.setViewName("detail2");
        return mav;
    }

//    1. 로그인
//    네이버/카카오/구글 로그인
//    Spring Security
//    Spring Session
//
//    본인인증?
//
//    2. PR -> CI
//
//    3. 회원가입
//
//    4. 결제 또는 챌린지 참여 시 카카오 메시지 발송


}
