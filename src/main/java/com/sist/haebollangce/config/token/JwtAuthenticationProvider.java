package com.sist.haebollangce.config.token;

import com.sist.haebollangce.user.dto.UserDTO;
import io.jsonwebtoken.Claims;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collection;
@Component
@RequiredArgsConstructor
public class JwtAuthenticationProvider implements AuthenticationProvider {

    private final JwtTokenizer jwtTokenizer;
    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {

        JwtAuthenticationToken authenticationToken = (JwtAuthenticationToken) authentication;

        Claims claims = jwtTokenizer.parseAccessToken(authenticationToken.getToken());

        String email = claims.getSubject();
        String userid = claims.get("userid", String.class);
        String name = claims.get("name", String.class);
        Collection<? extends GrantedAuthority> authorities = getGrantedAuthorities(claims);

        UserDTO.TokenUserDTO tokenUserDTO = new UserDTO.TokenUserDTO();
        tokenUserDTO.setUserid(userid);
        tokenUserDTO.setName(name);
        tokenUserDTO.setEmail(email);

        return new JwtAuthenticationToken(authorities,tokenUserDTO,null);
    }

    private Collection<? extends GrantedAuthority> getGrantedAuthorities(Claims claims) {
        Collection<GrantedAuthority> authority = new ArrayList<>();
        authority.add((GrantedAuthority) () -> (String) claims.get("role"));
        return authority;
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return JwtAuthenticationToken.class.isAssignableFrom(authentication);
    }
}
