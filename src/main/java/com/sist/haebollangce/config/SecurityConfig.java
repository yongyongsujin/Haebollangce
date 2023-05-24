package com.sist.haebollangce.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf().disable() // csrf: POST 방식으로 전송할 때, token을 사용해야 하는 보안 설정; 개발 초기엔 불편하므로 끔
                .authorizeRequests()
                .antMatchers("/", "/main").permitAll()  // 요 경로에 대해 누구나 접근 가능하다
                .anyRequest().authenticated();              // 그 외의 경로 요청은 모두 인증/인가 필요

        return http.build();
    }
    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        // 인증 및 인가 예외 Path URL
        return (web) -> web.ignoring().antMatchers( "/user/tiles-test",
                                                    "/bootstrap-4.6.0-dist/**",
                                                    "/css/**",
                                                    "/images/**",
                                                    "/jquery-ui-1.13.1.custom/**",
                                                    "/js/**",
                                                    "/smarteditor/**");
    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
