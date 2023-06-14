package com.sist.haebollangce.user.controller;

import com.sist.haebollangce.config.token.CookieUtil;
import com.sist.haebollangce.config.token.JwtTokenizer;
import com.sist.haebollangce.user.Role;
import com.sist.haebollangce.user.dto.UserDTO;
import com.sist.haebollangce.user.service.InterUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/user")
@RequiredArgsConstructor
public class UserEntryPointApiController {

    private final InterUserService service;
    private final JwtTokenizer jwtTokenizer;
    private final PasswordEncoder passwordEncoder;
    private final CookieUtil cookieUtil;

    @PostMapping("/login")
    public ResponseEntity login(@RequestBody UserDTO.UserLoginDTO loginUser) {
        UserDTO user = service.findByUserid(loginUser.getUserid());
        
        if(user == null) {
            return new ResponseEntity("No Such User Found.", HttpStatus.UNAUTHORIZED);
        }
        if( !passwordEncoder.matches(loginUser.getPw(), user.getPw() )) {
            return new ResponseEntity("Wrong Password.", HttpStatus.UNAUTHORIZED);
        }

        String accessToken = jwtTokenizer.createAccessToken(user.getUserid(),
                                                            user.getName(),
                                                            user.getEmail(),
                                                            user.getRoleId());

        String refreshToken = jwtTokenizer.createRefreshToken(user.getUserid(),
                                                              user.getName(),
                                                              user.getEmail(),
                                                              user.getRoleId());

        ResponseCookie cookie = cookieUtil.saveAccessToken("accessToken", accessToken);

        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.SET_COOKIE, String.valueOf(cookie));
        headers.add("Location", "/user/tiles-test");

        return new ResponseEntity(headers,HttpStatus.FOUND);
    }

    @GetMapping("/logout")
    public ResponseEntity logout(){
        ResponseCookie cookie = cookieUtil.removeToken("accessToken");

        HttpHeaders headers = new HttpHeaders();
        headers.add("Set-Cookie", String.valueOf(cookie));
        headers.add("Location", "/user/login");

        return new ResponseEntity(headers,HttpStatus.FOUND);
    }

    @PostMapping("/signup")
    public ResponseEntity formSignup2(UserDTO signupUser) {

        signupUser.setPw(passwordEncoder.encode(signupUser.getPw()));
        signupUser.setRoleId(Role.USER.getName());

        service.formSignup(signupUser);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Location", "/user/login");

        return new ResponseEntity(headers,HttpStatus.FOUND);
    }

    @GetMapping("/info")
    public ResponseEntity<String> info(){
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "text/html; charset=UTF-8");
        return new ResponseEntity<String>("API Controller 내 info 페이지", headers, HttpStatus.CREATED);
    }

}
