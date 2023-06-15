package com.sist.haebollangce.user.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TokenDTO {

    private String accessToken;
    private String refreshToken;

}
