<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String ctxPath = request.getContextPath();
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> 

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="/bootstrap-4.6.0-dist/css/bootstrap.min.css" >

<!-- Optional JavaScript -->
<script type="text/javascript" src="/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="/js/bootstrap.bundle.min.js" ></script>


<style type="text/css">

	div.info {
		height: 50%;
		display: flex; 
		justify-content: space-between; 
		padding: 0 40px 0 40px;
		font-size: 16pt;
		font-weight: bold; 
		line-height: 45px; 
	}
	
</style>
    
<script type="text/javascript">

	$(document).ready(function(){
		$("button#btn_close").click(function(){
			close();
		});
	});
	
</script>


<div class="container">
	<h3 style="height: 100px; text-align: center; margin: 0; line-height: 90px; font-weight: bold;">참가 완료되었습니다 &#x1F44F </h3>
	<div class="mb-3" style="height: 100px; display: flex;" >
		<div class="join_body" style="display: flex; box-shadow: 0px 0px 10px 1px gray; justify-content: center; align-items:center; width: 100%; height: 100%; border-radius: 20px; font-size: 12pt;">
			<div style="height: 100%; width: 30%; display: flex; justify-content: center; align-items:center;">
	  			<img src="<%= ctxPath%>/images/${chaDTO.thumbnail}" style="height:90%; width: 90%; border-radius: 20px;"/>
  			</div>
  			<div style="text-align: left; width: 70%;">
  				<div class="mb-2" style="display: flex; justify-content: space-between;">
	  				<div style="width: 120px; background-color: rgb(244, 244, 244); text-align: center; border-radius: 20px;">
	  					${chaDTO.categoryName}
	  				</div>
	  				<div class="mr-3" style="font-weight: bold;">
	  					<span class="">${chaDTO.memberCount}명 참가 중</span>
	  				</div>
  				</div>
	  			<h5 style="margin: 0; display: flex; font-weight: bold; display:inline-block;">${chaDTO.challengeName}</h5>
  				<div class="mr-3" style="text-align: right;">
	  				<span>기간 : </span>
	  				<h6 style="margin: 0; display: inline-block;">${chaDTO.startDate} ~ ${chaDTO.enddate}</h6>
  				</div>
  			</div>
		</div>
	</div>
	<div style="height: 100px;">
		<div class="info"><span>참가 예치금</span><span><fmt:formatNumber value="${paraMap.entry_fee}" pattern="#,###"/>원</span></div>
		<div class="info"><span>예치금 잔액</span><span><fmt:formatNumber value="${paraMap.after_deposit}" pattern="#,###"/>원</span></div>
	</div>
	<%-- 기능확장시 <button>알람 설정하기</button> --%>
	<div style="display: flex; justify-content: center; align-items: center; height: 75px;">
		<button id="btn_close" type="button" class="btn btn-secondary">확인</button>
	</div>
</div>