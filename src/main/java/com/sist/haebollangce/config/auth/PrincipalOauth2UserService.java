package com.sist.haebollangce.config.auth;

import com.sist.haebollangce.user.Role;
import com.sist.haebollangce.user.dao.InterUserDAO;
import com.sist.haebollangce.user.dto.UserDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
@RequiredArgsConstructor
public class PrincipalOauth2UserService extends DefaultOAuth2UserService {

    // 정보제공자(Provider : Naver)로부터 받은 데이터 후처리
    // 네아로 버튼 클릭 -> 로그인창 -> 로그인 완료 -> code 리턴(oAuth-Client 라이브러리에서 받음) -> code 통해 AccessToken 요청
    // 까지가 userRequest 정보
    // loadUser() 통해 회원 프로필 받는다.

    private final InterUserDAO dao;
    @Lazy
    private PasswordEncoder passwordEncoder;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        OAuth2User oauth2User = super.loadUser(userRequest);
        Map<String, Object> attributes = (Map) oauth2User.getAttributes().get("response");

        String provider = userRequest.getClientRegistration().getRegistrationId(); // naver
        String id = (String) attributes.get("id"); // naver에서의 id(고유값)
        String username = provider + "_" + id;

        UserDTO user = dao.findByUserid(username);

        if(user == null) {
            String email = (String) attributes.get("email");
            String roleId = Role.USER.getName();
            String mobile = (String) attributes.get("mobile");
            String name = (String) attributes.get("name");


            user = UserDTO.builder()
                    .userid(username)
                    .email(email)
                    .roleId(roleId)
                    .mobile(mobile)
                    .name(name)
                    .build();
            dao.oauthSignup(user);
        }

        return new PrincipalDetails(user, oauth2User.getAttributes());
        // Authentication 객체로 들어간다.
        // formLogin() : 1 param only
        // oauth2()    : 1 & 2 params
    }
}
