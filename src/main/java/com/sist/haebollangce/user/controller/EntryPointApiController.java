package com.sist.haebollangce.user.controller;

import com.sist.haebollangce.config.token.CookieUtil;
import com.sist.haebollangce.user.Role;
import com.sist.haebollangce.user.dto.TokenDTO;
import com.sist.haebollangce.user.dto.UserDTO;
import com.sist.haebollangce.user.service.InterUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@RestController
@RequestMapping("/api/v1/user")
@RequiredArgsConstructor
public class EntryPointApiController {

    private final InterUserService service;
    private final PasswordEncoder passwordEncoder;
    private final CookieUtil cookieUtil;

    @PostMapping("/login")
    public ResponseEntity login(@RequestBody UserDTO.UserLoginDTO loginUser, HttpServletRequest request) throws UnsupportedEncodingException {

        UserDTO user = service.formLogin(loginUser);

        if(user == null) {
            return new ResponseEntity("Wrong Password", HttpStatus.UNAUTHORIZED);
        }

        TokenDTO tokens = service.getTokens(user);
        ResponseCookie cookie = cookieUtil.saveAccessToken("accessToken", tokens.getAccessToken());

        String priorUrl = request.getHeader("custom-from");
        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.SET_COOKIE, String.valueOf(cookie));
        System.out.println("이전 페이지 찾기 "+priorUrl);
        String encodedPriorUrl = URLEncoder.encode(priorUrl, "utf-8");
        String encodedDefaultUrl = URLEncoder.encode("/challenge/main", "utf-8");
        if(priorUrl.length() > 0) {
            headers.add(HttpHeaders.LOCATION, "/user/login-process?redirect="+encodedPriorUrl+"&xduTvAAQVxq=true");
        } else if("http://localhost:7070/user/login".equals(priorUrl)) {
            headers.add(HttpHeaders.LOCATION, "/user/login-process?redirect="+encodedDefaultUrl+"&xduTvAAQVxq=true");
        } else {
            headers.add(HttpHeaders.LOCATION, "/user/login-process?redirect="+encodedDefaultUrl+"&xduTvAAQVxq=true");
        }

        return new ResponseEntity(headers,HttpStatus.FOUND);
    }

    @GetMapping("/logout")
    public ResponseEntity logout(){
        ResponseCookie cookie = cookieUtil.removeToken("accessToken");

        HttpHeaders headers = new HttpHeaders();
        headers.add("Set-Cookie", String.valueOf(cookie));
        headers.add("Location", "/challenge/main");

        return new ResponseEntity(headers,HttpStatus.FOUND);
    }

    @PostMapping("/signup")
    public ResponseEntity formSignup2(UserDTO signupUser) {

        signupUser.setPw(passwordEncoder.encode(signupUser.getPw()));
        signupUser.setRoleId(Role.USER.getName());

        service.formSignup(signupUser);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Location", "/challenge/main");

        return new ResponseEntity(headers,HttpStatus.FOUND);
    }

    @GetMapping("/info")
    public ResponseEntity<String> info(){
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "text/html; charset=UTF-8");
        return new ResponseEntity<String>("API Controller 내 info 페이지", headers, HttpStatus.CREATED);
    }

}
