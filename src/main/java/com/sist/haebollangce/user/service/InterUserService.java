package com.sist.haebollangce.user.service;

import com.sist.haebollangce.user.dto.TokenDTO;
import com.sist.haebollangce.user.dto.UserDTO;

import javax.swing.text.html.Option;
import java.util.Optional;

public interface InterUserService {

    UserDTO findByUserid(String userid);

    /**
     * 로그인 요청 사용자가 입력한 PW와
     * 토큰에 담긴 userid를 통해 얻어온 비밀번호를 비교해
     * 올바르면 사용자 정보를 전달합니다.
     * @param loginUser '/user/login' 에서 입력받은 userid, pw
     * @return DB에 담긴 사용자 전체 정보 또는 null
     *
     */
    UserDTO formLogin(UserDTO.UserLoginDTO loginUser);

    void formSignup(UserDTO signupUser);

    TokenDTO getTokens(UserDTO signinUser);
}
