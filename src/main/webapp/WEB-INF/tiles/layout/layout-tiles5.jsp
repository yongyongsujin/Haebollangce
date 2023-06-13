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
<!-- Required meta tags : 반응형 웹 쓸래 -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	<!-- Bootstrap CSS : 부트스트랩 쓸래 -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
	
	<!-- 직접 만든 CSS 쓸래 -->
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />
	
	<!-- 페이지로고 -->
	<link rel="icon" href="<%= ctxPath%>/images/fire-solid.png">
	
	<!-- Font Awesome 6 Icons -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
	    
	<!-- Optional JavaScript : jQuery 쓸래 -->
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.4.min.js"></script>
	<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 
	 
	<!-- 스마트에디터 -->
	<script type="text/javascript" src="/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
	
	<%--  ===== 스피너 및 datepicker 를 사용하기 위해  jquery-ui 사용하기 ===== --%>
	<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.css" />
	<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.js"></script>
	
	<%-- *** ajax로 파일을 업로드할때 가장 널리 사용하는 방법 ==> ajaxForm *** --%>
	<script type="text/javascript" src="<%= ctxPath%>/js/jquery.form.min.js"></script>
	
  	<%-- 아임포트 실행 --%>  
  	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
	<%-- 하이차트 --%>
	<script src="<%= ctxPath%>/Highcharts-11.0.1/code/highcharts.js"></script>
	<script src="<%= ctxPath%>/Highcharts-11.0.1/code/modules/data.js"></script>
	<script src="<%= ctxPath%>/Highcharts-11.0.1/code/modules/drilldown.js"></script>
	<script src="<%= ctxPath%>/Highcharts-11.0.1/code/modules/exporting.js"></script>
	<script src="<%= ctxPath%>/Highcharts-11.0.1/code/modules/export-data.js"></script>
	<script src="<%= ctxPath%>/Highcharts-11.0.1/code/modules/accessibility.js"></script>
	
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