package com.sist.haebollangce.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import com.sist.haebollangce.config.auth.PrincipalOauth2UserService;
import com.sist.haebollangce.config.token.AuthenticationManagerConfig;
import com.sist.haebollangce.config.token.exception.CustomAuthenticationEntryPoint;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.CorsUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true) // each @Secured, @PreAuthorize 활성화
@RequiredArgsConstructor
public class SecurityConfig {

    private final AuthenticationManagerConfig authenticationManagerConfig;
    private final CustomAuthenticationEntryPoint customAuthenticationEntryPoint;
    private final PrincipalOauth2UserService principalOauth2UserService;
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        return http
                .csrf().disable()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .formLogin().disable()
                .httpBasic().disable()
                .cors()
                    .configurationSource(corsConfigurationSource())
                .and()
                .apply(authenticationManagerConfig)
                .and()
                .authorizeRequests()
                    .requestMatchers(CorsUtils::isPreFlightRequest).permitAll()
//                    .mvcMatchers("/api/v1/user/**").access("hasAnyRole('ADMIN', 'MANAGER', 'USER')")
                    .mvcMatchers("/manager/**").access("hasAnyRole('ADMIN', 'MANAGER')")
                    .mvcMatchers("/admin/**").access("hasRole('ADMIN')")
                    .mvcMatchers("/mypage/**", "/challenge/add_challenge").authenticated()
                    .anyRequest().permitAll()
                .and()
                .exceptionHandling()
                    .authenticationEntryPoint(customAuthenticationEntryPoint)
                .and()
                .oauth2Login()
                    .loginPage("/user/form-login")
                    .userInfoEndpoint()
                    .userService(principalOauth2UserService)
                    .and()
                    .defaultSuccessUrl("/user/tiles-test")
                .and()
                .headers()
                    .frameOptions().sameOrigin()
                    .and()
                .build();
    }

    public CorsConfigurationSource corsConfigurationSource() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration config = new CorsConfiguration();
        config.setAllowCredentials(true);
        config.addAllowedOriginPattern("*");
        config.addAllowedHeader("*");
        config.addAllowedMethod("*");
        source.registerCorsConfiguration("/**", config);

        return source;
    }

    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.ignoring().requestMatchers(PathRequest.toStaticResources().atCommonLocations());
    }
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}