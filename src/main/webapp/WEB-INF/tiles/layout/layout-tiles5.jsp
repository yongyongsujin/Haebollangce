<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === #25. tiles 를 사용하는 레이아웃3 페이지 만들기 === --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%
	String ctxPath = request.getContextPath();
%>    
    
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
  <!-- Required meta tags -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> 
  
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" type="text/css" href="/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
  
  <!-- Font Awesome 5 Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

  <!-- Optional JavaScript -->
  <script type="text/javascript" src="/js/jquery-3.6.4.min.js"></script>
  <script type="text/javascript" src="/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>
  <script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script> 
  
  <%--  ===== 스피너 및 datepicker 를 사용하기 위해  jquery-ui 사용하기 ===== --%>
  <link rel="stylesheet" type="text/css" href="/jquery-ui-1.13.1.custom/jquery-ui.css" /> 
  <script type="text/javascript" src="/jquery-ui-1.13.1.custom/jquery-ui.js"></script>
  
  <%-- 아임포트 실행 --%>  
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>  
    
  <%-- *** ajax로 파일을 업로드할때 가장 널리 사용하는 방법 ==> ajaxForm *** --%>
  <script type="text/javascript" src="/js/jquery.form.min.js"></script>
  
  <%-- 폰트 --%>
  <link rel="stylesheet" as="style" crossorigin href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.6/dist/web/static/pretendard.css" /> 

</head>

<body>
	<div id="myContainer">
		<div id="myHeader">
			<tiles:insertAttribute name="header" />
		</div>

		<div class="row">
			<div class="col col-sm-0 container" id="myside" >
				<tiles:insertAttribute name="side" />
			</div>

			<div class="col col-lg-10 m-4 pl-0 pr-4" id="mypageContent">
				<tiles:insertAttribute name="mypage" />
			</div>
		</div>
	</div>
</body>
</html>