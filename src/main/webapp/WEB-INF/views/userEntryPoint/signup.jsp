<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<head>
    <title>회원가입</title>
    <style>
        .container {
            margin: 20% 30% 0 30%;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>회원가입</h2>
    <form action="/api/v1/user/signup" method="POST">
        <input type="text" name="userid" placeholder="아이디"><br>
        <input type="text" name="pw" placeholder="비밀번호"><br>
        <input type="text" name="name" placeholder="이름"><br>
        <input type="text" name="mobile" placeholder="휴대전화"><br>
        <br>
        <hr>
        <br>
        <button type="submit">회원가입</button>
</form>
  </div>
</body>