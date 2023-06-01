<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">

	li.certify_menu {
		
		width: 50%;
	}
	
	a.menu_a {
		text-align: center;
		font-size: 18pt;
		font-weight: bold;
		color: #808080;
		background-color:#FBECEA;
	}
	.nav-link.active,
	.nav-item.show .nav-link {
		color:black !important;
	}
	div.tab-pane{
		border: solid 1px #dee2e6; 
		border-top: none;     
		border-bottom-left-radius: 0.25rem;
    	border-bottom-right-radius: .25rem;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
	});
	
</script>


<!-- 탭을 토글 가능하게 만들려면 각 링크에 data-toggle="tab" 속성을 추가하십시오. 
	  그런 다음 모든 탭에 대해 고유한 ID가 있는 .tab-pane 클래스를 추가하고 .tab-content 클래스가 있는 <div> 요소 안에 래핑합니다.
                         
	  탭을 클릭할 때 탭이 페이드 인 및 페이드 아웃되도록 하려면 .fade 클래스를 .tab-pane에 추가하세요. 
-->

<div class="container" style="width: 70% !important; background-color: white; text-align: center;">
	<br>
	<h3 style="font-weight: bold;">참여중인 챌린지</h3>
	<br>
	<ul class="nav nav-tabs" style="justify-content: center;">
		<li class="nav-item certify_menu">
			<a class="nav-link active menu_a" id="cha_ing" data-toggle="tab" href="#challenge_ongoing">진행 중 (${requestScope.ing_count })</a>
		</li>
		<li class="nav-item certify_menu">
			<a class="nav-link menu_a" id="cha_before" data-toggle="tab" href="#challenge_before">시작 전 (${requestScope.before_count })</a>
		</li>
	</ul>
	
	<!-- Tab panes -->
	<div class="tab-content pb-2">
		<jsp:useBean id="now" class="java.util.Date" />
		<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
		
		
		<div class="tab-pane container active pt-3" id="challenge_ongoing" style="font-size: 16pt;">
			<c:if test="${not empty requestScope.chaList}">
				<c:set var="flag_ing" value="true" />
				<c:forEach var="chaDTO" items="${requestScope.chaList}">
					
					<c:if test="${chaDTO.startDate <= today && today <= chaDTO.enddate}">
				  		<div class="my-4" style="border: solid 1px black; width: 100%; height: 250px; display: flex; border-radius: 20px;">
				  			<div style="height: 100%; width: 30%;">
					  			<img style="border: solid 1px black; height:90%; width: 90%; margin-top:12px; border-radius: 20px;"/>
				  			</div>
				  			<div style="text-align: left; width: 70%;">
				  				<div style="display: flex; justify-content: space-between;">
					  				<div class="mt-3" style="width: 180px; height: 35px; line-height: 34px; background-color: rgb(244, 244, 244); text-align: center; border-radius: 20px;">
					  					<div>${chaDTO.category_name}</div>
					  				</div>
					  				<div class="mt-3 pr-3" style="font-weight: bold;">
					  					<span class="mr-2">현재 달성률</span><span>50%</span>
					  				</div>
				  				</div>
				  				<h4 class="my-3" style="font-weight: bold;">${chaDTO.challenge_name}</h4>
				  				<div class="pr-3" style="margin-top: 30px; display: flex; justify-content: space-between;">
				  					<div><span>인증빈도 - </span><span>${chaDTO.frequency }</span></div>
				  					<div><span>인증시간 - </span><span>${chaDTO.hour_start} ~ ${chaDTO.hour_end}</span></div>
				  				</div>
				  				<div class="mr-3" style="display: flex; justify-content: space-between; margin-top: 30px;">
					  				<div>
						  				<span>기간 : </span>
						  				<h5 class="pt-3" style="display: inline-block;">${chaDTO.startDate} ~ ${chaDTO.enddate}</h5>
					  				</div>
					  				<button style="width: 300px; background-color: #EB534C;" type="button" class="btn btn-secondary btn-lg" onclick="location.href='<%= request.getContextPath()%>/challenge/certify'">인증하기</button>
				  				</div>
				  			</div>
				  		</div>
				  		<c:set var="flag_ing" value="false" />
			  		</c:if>
			  		
				</c:forEach>
				
				<c:if test="${flag_ing}">
					<div class="my-4" style="border: solid 1px black; width: 100%; height: 250px; display: flex; border-radius: 20px; justify-content: center; align-items: center; font-weight: bold; font-size: 22pt;">진행 중인 챌린지가 없어요.&nbsp;<i class="fa-regular fa-face-sad-tear fa-lg" style="color: #000000;"></i></div>
			    </c:if>
			    
			</c:if>
			<c:if test="${empty requestScope.chaList}">
				<div class="my-4" style="border: solid 1px black; width: 100%; height: 250px; display: flex; border-radius: 20px; justify-content: center; align-items: center; font-weight: bold; font-size: 22pt;">진행 중인 챌린지가 없어요.&nbsp;<i class="fa-regular fa-face-sad-tear fa-lg" style="color: #000000;"></i></div>
			</c:if>
		</div>
		
		
		
		<div class="tab-pane container fade pt-3" id="challenge_before" style="font-size: 16pt;">
			<c:if test="${not empty requestScope.chaList}">
				<c:set var="flag_before" value="true" />
				<c:forEach var="chaDTO" items="${requestScope.chaList}">
				
					<c:if test="${chaDTO.startDate > today}">
				  		<div class="my-4" style="border: solid 1px black; width: 100%; height: 250px; display: flex; border-radius: 20px;">
				  			<div style="height: 100%; width: 30%;">
					  			<img style="border: solid 1px black; height:90%; width: 90%; margin-top:12px; border-radius: 20px;"/>
				  			</div>
				  			<div style="text-align: left; width: 70%;">
				  				<div style="display: flex; justify-content: space-between;">
					  				<div class="mt-3" style="width: 180px; height: 35px; line-height: 34px; background-color: rgb(244, 244, 244); text-align: center; border-radius: 20px;">
					  					<div>${chaDTO.category_name}</div>
					  				</div>
					  				<div class="mt-3 pr-3" style="font-weight: bold;">
					  					<span class="mr-2">현재 달성률</span><span>50%</span>
					  				</div>
				  				</div>
				  				<h4 class="my-3" style="font-weight: bold;">${chaDTO.challenge_name}</h4>
				  				<div class="pr-3" style="margin-top: 30px; display: flex; justify-content: space-between;">
				  					<div><span>인증빈도 - </span><span>${chaDTO.frequency }</span></div>
				  					<div><span>인증시간 - </span><span>${chaDTO.hour_start} ~ ${chaDTO.hour_end}</span></div>
				  				</div>
				  				<div class="mr-3" style="display: flex; justify-content: space-between; margin-top: 30px;">
					  				<div>
						  				<span>기간 : </span>
						  				<h5 class="pt-3" style="display: inline-block;">${chaDTO.startDate} ~ ${chaDTO.enddate}</h5>
					  				</div>
					  				<button style="width: 300px; background-color: #EB534C;" type="button" class="btn btn-secondary btn-lg" onclick="location.href='<%= request.getContextPath()%>/challenge/certify'">인증하기</button>
				  				</div>
				  			</div>
				  		</div>
				  		<c:set var="flag_before" value="false" />
				  	</c:if>
				</c:forEach>
				
				<c:if test="${flag_before}">
					<div class="my-4" style="border: solid 1px black; width: 100%; height: 250px; display: flex; border-radius: 20px; justify-content: center; align-items: center; font-weight: bold; font-size: 22pt;">진행 중인 챌린지가 없어요.&nbsp;<i class="fa-regular fa-face-sad-tear fa-lg" style="color: #000000;"></i></div>
			    </c:if>
				
			</c:if>
			<c:if test="${empty requestScope.chaList}">
				<div class="my-4" style="border: solid 1px black; width: 100%; height: 250px; display: flex; border-radius: 20px; justify-content: center; align-items: center; font-weight: bold; font-size: 22pt;">시작 전인 챌린지가 없어요.&nbsp;<i class="fa-regular fa-face-sad-tear fa-lg" style="color: #000000;"></i></div>
			</c:if>
		</div>
		
	</div>


	<br><br>
	
	<div class="container">
		<button type="button" class="btn btn-success" onclick="location.href='<%= request.getContextPath()%>/challenge/certifyMyInfo'">챌린지 인증 정보</button>
		<button type="button" class="btn btn-success" onclick="location.href='<%= request.getContextPath()%>/challenge/certify'">인증하기</button>
		<button type="button" class="btn btn-success" onclick="location.href='<%= request.getContextPath()%>/challenge/join'">참가하기</button>
	</div>
    
</div>