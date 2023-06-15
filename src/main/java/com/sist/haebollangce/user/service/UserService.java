package com.sist.haebollangce.user.service;

import com.sist.haebollangce.config.token.JwtTokenizer;
import com.sist.haebollangce.user.dto.TokenDTO;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.sist.haebollangce.user.dao.InterUserDAO;
import com.sist.haebollangce.user.dto.UserDTO;
import lombok.RequiredArgsConstructor;

import java.util.NoSuchElementException;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserService implements InterUserService{

    private final InterUserDAO dao;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenizer jwtTokenizer;

    @Override
    public UserDTO findByUserid(String userid) {

        return Optional.ofNullable(dao.findByUserid(userid))
                .orElseThrow( () -> new NoSuchElementException("입력한 "+userid+"와 일치하는 userid 가 없습니다.") );
    }

    @Override
    public UserDTO formLogin(UserDTO.UserLoginDTO loginUser) {

        UserDTO user = findByUserid(loginUser.getUserid());

        if( passwordEncoder.matches(loginUser.getPw(), user.getPw()) ) {
            return user;
        }
        return null;
    }

    @Override
    public void formSignup(UserDTO signupUser) {
        dao.formSignup(signupUser);
    }

    @Override
    public TokenDTO getTokens(UserDTO loginUser) {


        String accessToken = jwtTokenizer.createAccessToken(loginUser.getUserid(),loginUser.getName(),
                                                            loginUser.getEmail(),loginUser.getRoleId());

        String refreshToken = jwtTokenizer.createRefreshToken(loginUser.getUserid(),loginUser.getName(),
                                                              loginUser.getEmail(),loginUser.getRoleId());

        return new TokenDTO(accessToken, refreshToken);
    }

}
