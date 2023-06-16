<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<head>
    <title>로그인</title>

    <style>
        .container {
            padding-top: 6%;
            text-align: center;
            height: 550px;
        }
    </style>

    <script type="text/javascript" src="/js/jquery-3.6.4.min.js"></script>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>

</head>
<body>
<div class="container">
    <div>
        <h2>로그인</h2>
<%--        <form action="/api/v1/user/login" method="POST">--%>
        <form>
            <div><input type="text" name="userid" placeholder="아이디"></div>
            <div><input type="password" name="pw" placeholder="비밀번호"></div><br>
            <div><button id="login" type="button">로그인</button></div>
        </form>
    </div>

    <hr>

    <div>
        <h2>소셜 로그인</h2>
        <div id="naverIdLoginn">
            <a href="/oauth2/authorization/naver">
                <img src="https://static.nid.naver.com/oauth/big_g.PNG?version=js-2.0.1" height="50">
            </a>
        </div>
    </div>

    <br><br><br>

<%--    <div>--%>
<%--        <a href="/user/signup"><span>일반 회원가입</span></a>--%>

<%--    </div>--%>

    <input type="hidden" name="from" value="${from}"/>
</div>
<script type="text/javascript">
    const submit = document.getElementById("login");
    submit.addEventListener('click', () => {

        const userid = document.querySelector('input[name="userid"]').value;
        const pw = document.querySelector('input[name="pw"]').value;
        const from = document.querySelector('input[name="from"]').value;

        const xhr = new XMLHttpRequest;
        xhr.open('POST', '/api/v1/user/login', 'true');
        xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
        if(from.length > 0 || from != null) {
            xhr.setRequestHeader('custom-from', from);
        }
        xhr.withCredentials = true;
        const json = {"userid":userid, "pw":pw};
        xhr.send(JSON.stringify(json));

        xhr.onreadystatechange = () => {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    window.location.href = xhr.responseURL;
                } else {
                }
            }
        };

    });

</script>
<%--적용 X--%>
<%--<script type="text/javascript">--%>
<%--    const naverLogin = new window.naver.LoginWithNaverId( {--%>
<%--        loginButton: {color: "green", type: 3, height: 50}--%>
<%--    } ); /* 설정정보를 초기화하고 연동을 준비 */--%>
<%--    naverLogin.init();--%>
<%--</script>--%>
</body>