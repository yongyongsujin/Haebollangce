<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<head>
    <title>회원가입</title>

    <style>
        .container-md {
            margin: 10% 20% 0 20%;
            height: 380px;
        }
        input {
            margin-bottom: 2% !important;
            width: 16vw;

        }
        span.error {
            color: red;
        }
    </style>

</head>
<body>
<div class="container-md">
    <h2 class="mb-4">회원가입</h2>
    <form name="signup">
        <div><input type="text" name="userid" placeholder="아이디"></div>
        <div><input type="password" name="pw" placeholder="비밀번호">&emsp;<span class="error">8-20 사이의 숫자, 대/소문자, 특수문자를 각각 하나이상 포함해주세요 </span></div>
        <div><input type="text" name="name" placeholder="이름"></div>
        <div><input type="text" name="mobile" placeholder="휴대전화 : 010xxxxAAAA 형식">&emsp;<span class="error">010xxxxAAAA 형식을 반드시 지켜주세요</span></div>
        <button id="go" type="button" class="btn btn-success">회원가입</button>
    </form>
  </div>

<script>

    $(document).ready(function(){
        $('span.error').hide();
    });

    $('input[name="pw"]').change( (e) => {
            $(e.target).parent().find('span.error').hide();
    });

    $('input[name="mobile"]').change( (e) => {
            $(e.target).parent().find('span.error').hide();
    });

    $('button#go').click(function(){

        let regExp = new RegExp("^(?=.*[a-zA-Z])(?=.*\\d)(?=.*\\W).{8,20}$");
        let bool = regExp.test($('input[name="pw"]').val());

        if(!bool) {
            // 암호가 정규표현식에 위배
            $('input[name="pw"]').focus();
            $('input[name="pw"]').parent().find('span.error').show();
            return;
        } else {
            // 암호가 정규표현식에 부합
            $('input[name="pw"]').parent().find('span.error').hide();
        }

        regExp = new RegExp("^[0-9]{11}$");
        bool = regExp.test($('input[name="mobile"]').val());
        console.log('mobile '+bool);
        if(!bool) {
            $('input[name="mobile"]').focus();
            $('input[name="mobile"]').parent().find('span.error').show();
            return;
        } else {
            $('input[name="mobile"]').parent().find('span.error').hide();
        }

        const signup = document.signup;
        signup.action = "/api/v1/user/signup";
        signup.method = "POST";
        signup.submit();


    });



</script>
</body>