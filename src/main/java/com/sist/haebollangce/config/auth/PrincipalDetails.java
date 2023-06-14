package com.sist.haebollangce.config.auth;

import com.sist.haebollangce.user.dto.UserDTO;
import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;

@Getter
@Setter
public class PrincipalDetails implements UserDetails, OAuth2User {

    private UserDTO user;
    private Map<String, Object> attributes; // 로그인한 사용자 정보

    // form-login
    public PrincipalDetails(UserDTO user) {
        this.user = user;
    }

    // OAuth2User
    public PrincipalDetails(UserDTO user, Map<String, Object> attributes) {
        this.user = user;
        this.attributes=attributes;
    }

    // ===== implementations of methods from UserDetails =====
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() { // 로그인한 유저의 권한을 리턴
        Collection<GrantedAuthority> authority = new ArrayList<>();
        authority.add(new GrantedAuthority() {
            @Override
            public String getAuthority() {
                return user.getRoleId();
            }
        });
        // authority.add((GrantedAuthority) () -> user.getRoleId()); 으로도 표현 가능
        return authority;
    }

    @Override
    public String getPassword() {
        return user.getPw();
    }
    @Override
    public String getUsername() {
        return user.getUserid();
    }
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    } // 비밀번호 재설정 기간(ex.1년) 안 지났는지 체크
    @Override
    public boolean isEnabled() { return true; } // 1년 미접속 ➡️ 휴면 게정 전환

    // ======================================================
    // ===== implementations of methods from OAuth2User =====
    @Override
    public String getName() {
        return null;
    }
    @Override
    public Map<String, Object> getAttributes() {
        return attributes;
    }
}
