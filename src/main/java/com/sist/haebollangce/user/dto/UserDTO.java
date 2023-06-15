package com.sist.haebollangce.user.dto;

import com.sist.haebollangce.user.Role;
import lombok.*;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserDTO {

    private String userid;
    private String email;
    private String pw;
    private String name;
    private String exp;
    private String regdate;
    private String status;
    private String profilePic;
    private String acct;
    private String mobile;
    private String roleId;

    @Builder
    public UserDTO(String userid, String email, String name, String mobile, String roleId) {
        this.userid = userid;
        this.email = email;
        this.name = name;
        this.mobile = mobile;
        this.roleId = roleId;
    }

    /**
     * `/user/login' URI 페이지의 form으로부터 받아온 userid, pw
     */
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class UserLoginDTO {

//        @Pattern(regexp = "^[a-zA-Z0-9]$")
        private String userid;

//        @Pattern(regexp = "^(?=.*[a-zA-Z])(?=.*\\d)(?=.*\\W).{8,20}$")
        private String pw;

    }

    /**
     * JWT claims 에 담길 정보
     */
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class TokenUserDTO {
        private String userid;
        private String name;
        private String email;
    }

}
