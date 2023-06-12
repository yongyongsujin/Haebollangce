package com.sist.haebollangce.user.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDTO {

    String userid;
    String email;
    String pw;
    String name;
    String fkLevel;
    String exp;
    String regdate;
    String status;
    String profilePic;
    String acct;
    String mobile;
    String fkRoleId;

    public static class UserLoginDTO {
        private String userid;
        private String pw;

        public UserLoginDTO(String userid, String pw) {
            this.userid = userid;
            this.pw = pw;
        }

        public UserLoginDTO getInstance(String userid, String pw) {
            return new UserLoginDTO(userid, pw);
        }
    }

}