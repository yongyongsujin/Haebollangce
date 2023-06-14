package com.sist.haebollangce.config.token;

import org.springframework.http.ResponseCookie;
import org.springframework.stereotype.Component;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

@Component
public class CookieUtil {

    public static String getToken(HttpServletRequest request, String tokenName) {
        Cookie[] cookies=request.getCookies();
        if(cookies!=null){
            for (Cookie c : cookies) {
                String name = c.getName();
                String value = c.getValue();
                if (name.equals(tokenName)) {
                    return value;
                }
            }
        }
        return null;
    }

    public ResponseCookie saveAccessToken(String tokenName, String accessToken) {
        return saveToken(tokenName, accessToken, 1 * 24 * 60 * 60L);
    }

    public ResponseCookie saveRefreshToken(String tokenName, String refreshToken) {
        return saveToken(tokenName, refreshToken, 1 * 24 * 60 * 60L);
    }

    public ResponseCookie removeToken(String tokenName) {
        return saveToken(tokenName, null, 0L);
    }

    private ResponseCookie saveToken(String tokenName, String token, long maxAgeSeconds) {
        ResponseCookie cookie = ResponseCookie
                .from(tokenName, token)
                .maxAge(maxAgeSeconds)
                .path("/")
                .secure(true)
                .sameSite("None")
                .httpOnly(true)
                .build();

        return cookie;
    }
}
