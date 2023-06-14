<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="form-inline my-2 my-lg-0" id="islogin">
    	<c:if test="${accessToken == null}">
	    	<button type="button" class="btn btn-sm btn-habol mx-2 my-2" style="color:white; font-weight:bold;" onclick="javascript:location.href='<%= ctxPath %>/user/signup'">회원가입</button>
	    	<button type="button" class="btn btn-sm btn-habol mx-2 my-2 " style="color:white; font-weight:bold;" onclick="javascript:location.href='<%= ctxPath %>/user/login'">로그인</button>
    	</c:if>
    	<c:if test="${accessToken != null}">
	    	<i type="button" class="fa-solid fa-paper-plane mx-2" onclick="javascript:location.href='<%= ctxPath%>/messenger/messengerView'"></i>
	    	<button type="button" class="btn btn-sm btn-habol mx-2 my-2" style="color:white; font-weight:bold;" onclick="javascript:location.href='<%= ctxPath %>/mypage/mypageHome'">마이페이지</button>
	    	<button type="button" class="btn btn-sm btn-habol mx-2 my-2 " style="color:white; font-weight:bold;" onclick="javascript:location.href='<%= ctxPath %>/user/logout'">로그아웃</button>
    	</c:if>
    </div>

</body>
</html> --%>