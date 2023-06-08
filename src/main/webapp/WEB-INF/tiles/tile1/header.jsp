<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.InetAddress"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- === #2. tile1 중 header 페이지 만들기 === --%>
<% String ctxPath = request.getContextPath(); %>

<style type="text/css">

	@font-face {
	    font-family: 'Pretendard-Regular';
	    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
	    font-weight: 400;
	    font-style: normal;
	}
	
	@font-face {
	    font-family: 'SDSamliphopangche_Basic';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts-20-12@1.0/SDSamliphopangche_Basic.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	
	body {
	    font-family: 'Pretendard-Regular';
	}

	/* 헤더 */ 
	header {
	  	position: fixed;
	  	top: 0;
	  	left: 0;
	  	right: 0;
	  	z-index: 1;
	}
	
	.headerlogo {
		font-size:18pt;
		color: black;
		font-weight: bold;
		font-family: 'SDSamliphopangche_Basic';
		margin-right: 20px; letter-spacing: 2px;
	}
	
	.headerfont {
		font-size:12pt;
		color: black;
		font-weight: bold;
		font-family: 'Pretendard-Regular';
	}
	
	a.headerfont { 
	  	display:inline-block; 
	  	margin:0; 
	}
	a.headerfont:after {
	  	display:block;
	  	content: '';
	  	border-bottom: solid 3px #F43630;  
	  	transform: scaleX(0);  
	  	transition: transform 250ms ease-in-out;
	}
	a.headerfont:hover:after { 
		transform: scaleX(1); 
	}
	
	
	button.btn-habol {
		color: #fff;
		background-color: #F43630;
		border-color: #F43630;
		border-radius:10px;
	}
	
	.btn-habol:hover {
	  color: #fff;
	  background-color: #c82333;
	  border-color: #bd2130;
	}
	
	.btn-danger:focus, .btn-habol.focus {
	  color: #fff;
	  background-color: #c82333;
	  border-color: #bd2130;
	  box-shadow: 0 0 0 0.2rem rgba(225, 83, 97, 0.5);
	}
	
	.btn-habol.disabled, .btn-habol:disabled {
	  color: #fff;
	  background-color: #F43630;
	  border-color: #F43630;
	}
	
	.btn-habol:not(:disabled):not(.disabled):active, .btn-habol:not(:disabled):not(.disabled).active,
	.show > .btn-habol.dropdown-toggle {
	  color: #fff;
	  background-color: #bd2130;
	  border-color: #b21f2d;
	}
	
	.btn-habol:not(:disabled):not(.disabled):active:focus, .btn-habol:not(:disabled):not(.disabled).active:focus,
	.show > .btn-habol.dropdown-toggle:focus {
	  box-shadow: 0 0 0 0.2rem rgba(225, 83, 97, 0.5);
	}
	
	
	/* loungeList */
	.lounge_title_a {
	    width: 100vw;
	    height: 496px;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    flex-direction: column;
	    margin-top: 80px;
	}
	
	.lounge_title_b {
	    font-weight: 700;
	    font-size: 24px;
	    line-height: 30px;
	    display: flex;
	    align-items: center;
	    text-align: center;
	    letter-spacing: -.4px;
	    color: #ff8a7a;
	    margin-bottom: 24px;
	}
	
	.lounge_title_c {
	    font-weight: 700;
	    font-size: 44px;
	    line-height: 60px;
	    display: flex;
	    text-align: center;
	    letter-spacing: -.4px;
	    white-space: pre-wrap;
	    color: #000;
	    margin-bottom: 32px;
	}
	.lounge_title_d {
	font-weight: 400;
	    font-size: 22px;
	    line-height: 32px;
	    letter-spacing: -.4px;
	    color: #383535;
	    display: flex;
	    align-items: center;
	    text-align: center;
	}

	
	/* loungeView */
	body {
	    background-color: #eee;
	}
	
	.card {
	    border: none;
	    border-radius: 10px
	}
	
	.c-details span {
	    font-weight: 300;
	    font-size: 13px
	}
	
	.icon {
	    width: 50px;
	    height: 50px;
	    background-color: #eee;
	    border-radius: 15px;
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    font-size: 39px
	}
	
	.badge span {
	    background-color: #fffbec;
	    width: 60px;
	    height: 25px;
	    padding-bottom: 3px;
	    border-radius: 5px;
	    display: flex;
	    color: #fed85d;
	    justify-content: center;
	    align-items: center
	}
	
	.badge2 span {
	    background-color: #fffbec;
	    width: 80px;
	    height: 35px;
	    padding-bottom: 3px;
	    border-radius: 5px;
	    display: flex;
	    color: #fed85d;
	    justify-content: center;
	    align-items: center;
	    font-weight: bold;
	}
	
	.progress {
	    height: 10px;
	    border-radius: 10px
	}
	
	.progress div {
	    background-color: red
	}
	
	.text1 {
	    font-size: 14px;
	    font-weight: 600
	}
	
	/* loungeView_댓글쓰기 */
	span.lounge_comment_userid {
		font-size: 14px;
		font-weight: bold;
	}
	
	.lounge_comment_content {
		white-space: pre-line;
	    font-size: 14px;
	    line-height: 22px;
	    display: flex;
	}
	

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		
	});

</script>

<%-- 상단배너 시작 --%>
<header>
	<div id="main_header" class="container-fluid px-0">
		<!-- 상단 네비게이션 시작 -->
		<nav class="navbar navbar-expand-lg navbar-light py-3 " style="padding: 15px 100px; background-color: #e6e1e1; color: black;">
		
			<a class="navbar-brand headerlogo active" href="<%=ctxPath%>/main">HAEBOLLANGCE</a>
			
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		        <span class="navbar-toggler-icon"></span>
		    </button>
			
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
			    <ul class="navbar-nav mr-auto"> <!-- .mr-auto : 가로축 미사용 공간 너비의 일부를 바깥 여백에 할당한다는 의미임. -->
			        
			        <li class="nav-item dropdown active mr-3">
			        	<a class="nav-link dropdown-toggle headerfont" id="navbardrop_chlg" data-toggle="dropdown">챌린지</a>
			      		<div class="dropdown-menu" style="border:none;">
					        <a class="dropdown-item" href="<%=ctxPath%>/challenge/add_challenge">챌린지 개설하기</a>
					        <a class="dropdown-item" href="<%=ctxPath%>/chanllenge_all">챌린지 둘러보기</a>
					    </div>
			      	</li>
			      	<li class="nav-item dropdown active mr-3">
			        	<a class="nav-link dropdown-toggle headerfont" href="<%= ctxPath %>/challenge/certifyList">챌린지 인증</a>
			      	</li>
			     	<li class="nav-item dropdown active mr-3">
			        	<a class="nav-link dropdown-toggle headerfont" id="navbardrop_lng" data-toggle="dropdown">라운지</a>
			      		<div class="dropdown-menu" style="border: none;">
					        <a class="dropdown-item" href="<%=ctxPath%>/lounge/loungeAdd">라운지 글게시하기</a>
					        <a class="dropdown-item" href="<%=ctxPath%>/lounge/loungeList">라운지 둘러보기</a>
					    </div>
			      	</li>
			<%--<c:if test="${sessionScope.loginuser != null and sessionScope.loginuser.userid == 'admin'}"> <%-- admin 으로 로그인 했으면 --%>
			      	<li class="nav-item">
			        	<a class="nav-link headerfont fromCenter disabled" style="font-weight:bold;" href="<%= ctxPath %>/haebol_admin" tabindex="-1" aria-disabled="true">관리자</a>
			      	</li>
		    <%--</c:if> --%>
			    </ul>
			    <form class="form-inline my-2 my-lg-0">
			    	<button type="button" class="  btn btn-sm btn-habol mx-2 my-2" style="color:white; font-weight:bold;" href="<%= ctxPath %>/login">회원가입</a>
			    	<button type="button" class="  btn btn-sm btn-habol mx-2 my-2 " style="color:white; font-weight:bold;" href="<%= ctxPath %>/register">로그인</a>
			    </form>
			</div>
			
		</nav>
		<!-- 상단 네비게이션 끝 -->
	</div>
</header>		
<%-- 상단배너 끝 --%>

