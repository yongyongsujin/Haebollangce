package com.sist.haebollangce.user.controller;

import com.sist.haebollangce.config.token.CookieUtil;
import com.sist.haebollangce.user.Role;
import com.sist.haebollangce.user.dto.TokenDTO;
import com.sist.haebollangce.user.dto.UserDTO;
import com.sist.haebollangce.user.service.InterUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.*;
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
    public ResponseEntity login(@RequestBody UserDTO.UserLoginDTO loginUser , HttpServletRequest request) throws UnsupportedEncodingException {

        UserDTO user = service.formLogin(loginUser);

        if(user == null) {
            return new ResponseEntity("Wrong Password", HttpStatus.UNAUTHORIZED);
        }

        TokenDTO tokens = service.getTokens(user);
        ResponseCookie cookie = cookieUtil.saveAccessToken("accessToken", tokens.getAccessToken());

        HttpHeaders headers = new HttpHeaders();
            headers.add(HttpHeaders.SET_COOKIE, String.valueOf(cookie));

            String priorUri = request.getHeader("custom-from");
            headerBuilder(priorUri, headers);

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
    public ResponseEntity formSignup2(UserDTO signupUser, HttpServletRequest request) throws UnsupportedEncodingException {

        UserDTO.UserLoginDTO loginDTO = new UserDTO.UserLoginDTO();
        loginDTO.setUserid(signupUser.getUserid());
        loginDTO.setPw(signupUser.getPw());

        signupUser.setPw(passwordEncoder.encode(signupUser.getPw()));
        signupUser.setRoleId(Role.USER.getName());
        service.formSignup(signupUser);

        return login(loginDTO, request);
    }

    private void headerBuilder(String priorUri,  HttpHeaders headers) throws UnsupportedEncodingException {
        String encodedDefaultUrl = URLEncoder.encode("/challenge/main", "utf-8");
        if(priorUri != null && priorUri.length() > 0) {
            int indexOfPortNum = priorUri.indexOf("7070");
            System.out.println("전 "+priorUri);
            priorUri = priorUri.substring(indexOfPortNum+4);
            System.out.println("후 "+priorUri);
            if("/user/login".equals(priorUri) || priorUri.length() == 0) {
                headers.add(HttpHeaders.LOCATION, "/user/login-process?redirect="+encodedDefaultUrl+"&xduTvAAQVxq=true");
            }

            String encodedPriorUrl = URLEncoder.encode(priorUri, "utf-8");
            headers.add(HttpHeaders.LOCATION, "/user/login-process?redirect="+encodedPriorUrl+"&xduTvAAQVxq=true");
        } else {
            headers.add(HttpHeaders.LOCATION, "/user/login-process?redirect="+encodedDefaultUrl+"&xduTvAAQVxq=true");
        }
    }

}
