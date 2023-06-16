package com.sist.haebollangce.user.controller;

import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import com.sist.haebollangce.config.token.CookieUtil;
import com.sist.haebollangce.config.token.JwtTokenizer;
import org.springframework.web.bind.annotation.*;
import lombok.RequiredArgsConstructor;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class EntryPointViewController {

    private final JwtTokenizer jwtTokenizer;

    @GetMapping("/login")
    public String formLogin(HttpServletRequest request) {
        String targetUrl = request.getHeader("referer");
        request.setAttribute("from", targetUrl);
        return "login.tiles1";
    }

    @GetMapping("/signup")
    public String formSignup1() {
        return "signup.tiles1";
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////
    @GetMapping("/tiles-test")
    public String tiles(HttpServletRequest request) {

        String accessToken = CookieUtil.getToken(request,"accessToken");
        if(accessToken != null) {
            System.out.println(jwtTokenizer.getUseridFromToken(accessToken));
        }
        return "tiles_test_1.tiles1";
    }


    @GetMapping("/login-process")
    public String process(HttpServletRequest request){
        String redirectUrl = request.getParameter("redirect");
        String boolLogin = request.getParameter("xduTvAAQVxq");

        request.setAttribute("boolLogin", boolLogin);
        request.setAttribute("redirectUrl", redirectUrl);

        return "login_process.tiles1";
    }


}
