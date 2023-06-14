package com.sist.haebollangce.config.token;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@RequiredArgsConstructor
public class AuthenticationManagerConfig extends AbstractHttpConfigurer<AuthenticationManagerConfig, HttpSecurity> {

    private final JwtAuthenticationProvider jwtAuthenticationProvider;

    @Override
    public void configure(HttpSecurity http) throws Exception {
        AuthenticationManager authenticationManager = http.getSharedObject(AuthenticationManager.class);

        http
                .addFilterBefore(new JwtAuthenticationFilter(authenticationManager),
                                 UsernamePasswordAuthenticationFilter.class)
                .authenticationProvider(jwtAuthenticationProvider);
    }

}
