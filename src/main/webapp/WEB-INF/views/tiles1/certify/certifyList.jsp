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
	div.challengeList {
		cursor: pointer;
		box-shadow: 0px 0px 10px 1px gray;
	}
	div#not_chaList {
		box-shadow: 0px 0px 10px 1px gray;
		width: 100%; 
		height: 250px; 
		display: flex; 
		border-radius: 20px; 
		justify-content: center; 
		align-items: center; 
		font-weight: bold; 
		font-size: 22pt;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		checkCertifyTime(); // 처음 로드 됐을때 인증시간 체크
		Notification.requestPermission(); // 브라우저 알림을 허용하는지 권한 요청
		notifyCertifyTime(); // 인증시간 알림 체크
		
		// 챌린지 목록 호버효과
		$("div.challengeList").hover(function(){
			$(this).css({"background-color":"#FBECEA"});
		},function() {
			$(this).css({"background-color":"white"});
		});

		// 인증하기 버튼 클릭시
		$("button#certify").click(function(e){
			e.stopPropagation();
			let challenge_code = $(this).parent().find("input#challenge_code").val();
			location.href='<%= ctxPath%>/challenge/certify?challenge_code='+challenge_code;
		});
		
		// 목록중 챌린지 하나를 선택했을시
		$("div.challengeList").click(function(e){
			let challenge_code = $(this).find("input#challenge_code").val();
			location.href='<%= ctxPath%>/challenge/certifyMyInfo?challenge_code='+challenge_code;
		});
		
		
		// 1분 마다 챌린지의 인증시간을 체크함 (버튼활성화, 비활성화)
		setInterval(function() {
			checkCertifyTime();
			notifyCertifyTime();
			console.log("인증시간 체크완료");
		}, 60000);
		
		
		// 각 챌린지의 오늘 인증을 완료했는지 체크하여 인증완료 버튼 변환해주기
		const arr_chall = $("input.checkCertify");

		arr_chall.each(function(index, element) {
			
			if ( $(element).val() > 0) {
				// 오늘 인증을 완료했을 경우
				$(element).next().css({"background-color":"white", "color":"black"});
				const html = '인증완료&nbsp;&nbsp;<i class="fa-solid fa-check fa-lg" style="color: #000000;"></i>';				
				$(element).next().html(html);
				$(element).next().prop('disabled', true );
			} 
		});
		
		
		
	}); // end $(document).ready
	
	
	// 시작시간과 종료시간을 받아와 현재시간과 비교하여 boolean을 리턴하는 함수
	function getTimeCompare(hour_start, hour_end) {
		
		let bool = false;
		
		const now = new Date();
		const nowHours = now.getHours();
		const nowMinutes = now.getMinutes();

		// let hour_start = "";
		const hour_start_hours = hour_start.substring(0, 2);
		const hour_start_min = hour_start.substring(3, 5);
		
		const hour_end_hours = hour_end.substring(0, 2);
		const hour_end_min = hour_end.substring(3, 5);
		
		const hour_start_date = new Date(0, 0, 0, hour_start_hours, hour_start_min);
		const hour_end_date = new Date(0, 0, 0, hour_end_hours, hour_end_min);
		const now_time_date = new Date(0, 0, 0, nowHours, nowMinutes);
		
		if ( hour_start_date <= now_time_date && now_time_date <= hour_end_date ) {
			// 현재시각이 인증시간인 경우 true
			bool = true;
		}
		
		return bool;
	} // end function getTimeCompare
	
	
	// frequency 타입(평일, 주말)을 받아와 현재시간과 비교하여 boolean을 리턴하는 함수
	function getDateCompare(freq_type) {
		
		let bool = false;
		
		const now = new Date();
		const nowday = now.getDay();
		// console.log(nowday);
		// 0 일 , 1 월 , 2 화, 3 수, 4 목, 5 금, 6 토
		
		// freq_type이 100 일 경우  매일, 101=평일, 102=주말
		switch (freq_type) {
			case "100" :
				if ( nowday == 0 || nowday == 1 || nowday == 2 || nowday == 3 || nowday == 4 || nowday == 5 || nowday == 6) {
					bool = true;					
				}
				break;
			case "101" :
				if ( nowday==1 || nowday==2 || nowday==3 || nowday==4 || nowday==5) {
					bool = true;
				}	
				break;
			case "102" :
				if ( nowday==0 || nowday==6) {
					bool = true;
				}	
				break;
			
			default:
				break;
		
		}
		
		return bool;
	} // end function getDateCompare
	
	
	// 각 챌린지의 인증시간 체크하는 함수
	function checkCertifyTime() {
		const challenge_list = $("input.hour_start");
		
		challenge_list.each(function(index, element) {
			let hour_start = $(this).val();
			let hour_end = $(this).next().val();
			let freq_type = $(this).next().next().val();
			// console.log(freq_type);  100 101 102
			
			let certify_date = getDateCompare(freq_type);

			if (certify_date) {
				// 오늘 요일이 frequecy에 맞는 경우
				
				let certify_time = getTimeCompare(hour_start, hour_end);
				// 인증시간인 경우 certify_time = true 아닐경우 false
				
				if (certify_time) {
					// 인증시간인 경우 버튼 활성화
					$(this).prev().prop('disabled', false );
				}
				else {
					// 인증시간이 아닌경우 버튼 비활성화
					$(this).prev().prop('disabled', true );
				}
				
			}
			else {
				// 인증 요일이 아닐 경우
				$(this).prev().prop('disabled', true );
			}
			
		
		});
	} // end function checkCertifyTime

	
	// 크롬 알림참을 띄우는 객체
	function notify (challengeName) {
		
		if (Notification.permission != "denied") {
			
			new Notification("인증해주세요 !", {
				body: "진행중인 챌린지 [ "+challengeName+" ] 의 인증시간입니다." ,
				icon: "<%= ctxPath%>/images/fire-solid.png"
			});
		}
	}
	
	
	// 진행중인 챌린지중 인증시간이 되면 알림창을 띄우는 함수
	function notifyCertifyTime() {
		
		const chaList = ${requestScope.chaListTime};
		
		$.each(chaList, function(index, elt) {
			const startDate = new Date(elt.startDate);
			const endDate = new Date(elt.endDate);
			const today = new Date();

			startDate.setHours(0);
			endDate.setHours(23,59,59);

			if ( startDate <= today && today <= endDate ) {
				const time = elt.startTime;
				const time_hour = time.substring(0, 2);
				const time_min = time.substring(3, 5);
				
				const certifyTime = new Date(today.getFullYear(), today.getMonth(), today.getDate(), Number(time_hour), Number(time_min));
				// const certifyTime = new Date(today.getFullYear(), today.getMonth(), today.getDate(), 9, 34);
				// 특정시간 지정하는 테스트 용도

				let diff = (certifyTime.getTime() - today.getTime()) / 1000;
				diff /= 60;
				// console.log( Math.abs(Math.round(diff)) );
				// 현재시간과 인증시간의 남은 분 출력하기
				
				if (Math.abs(Math.round(diff)) == 0) {
					// 현재시간과 인증시간의 차이가 0 일때 알림 띄우기
					notify(elt.challengeName);
				}
			}
			
		});
	}
	
	
</script>


<!-- 탭을 토글 가능하게 만들려면 각 링크에 data-toggle="tab" 속성을 추가하십시오. 
	  그런 다음 모든 탭에 대해 고유한 ID가 있는 .tab-pane 클래스를 추가하고 .tab-content 클래스가 있는 <div> 요소 안에 래핑합니다.
                         
	  탭을 클릭할 때 탭이 페이드 인 및 페이드 아웃되도록 하려면 .fade 클래스를 .tab-pane에 추가하세요. 
-->
<div class="container-fluid" style="background-color: #f4f4f4;">
<div class="container pb-5" style="border-radius: 20px; background-color: white; text-align: center;">
	<br>
	<h3 class="py-3" style="font-weight: bold;"><span style="box-shadow: 0px 0px 10px 1px gray; line-height: 50px; height: 50px; border-radius: 8px; width:250px; display: inline-block; background-color: #EB534C; color: white;">참가중인 챌린지</span></h3>
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
				  		<div class="challengeList my-4" style="width: 100%; height: 250px; display: flex; border-radius: 20px;">
				  			<div style="height: 100%; width: 30%;">
					  			<img src="<%= ctxPath%>/images/${chaDTO.thumbnail}" style="object-fit: cover; height:90%; width: 90%; margin-top:12px; border-radius: 20px;"/>
				  			</div>
				  			<div style="text-align: left; width: 70%;">
				  				<div style="display: flex; justify-content: space-between;">
					  				<div class="mt-3" style="width: 180px; height: 35px; line-height: 34px; background-color: rgb(244, 244, 244); text-align: center; border-radius: 20px;">
					  					<div>${chaDTO.categoryName}</div>
					  				</div>
					  				<div class="mt-3 pr-3" style="font-weight: bold;">
					  					<span class="mr-2">현재 달성률</span><span>${chaDTO.achievementPct}%</span>
					  				</div>
				  				</div>
				  				<h4 class="my-3" style="font-weight: bold;">${chaDTO.challengeName}</h4>
				  				<div class="pr-3" style="margin-top: 30px; display: flex; justify-content: space-between;">
				  					<div><span>인증빈도 - </span><span>${chaDTO.frequency }</span></div>
				  					<div><span>인증시간 - </span><span class="certifyTime">${chaDTO.hourStart} ~ ${chaDTO.hourEnd}</span></div>
				  				</div>
				  				<div class="mr-3" style="display: flex; justify-content: space-between; margin-top: 30px;">
					  				<div>
						  				<span>기간 : </span>
						  				<h5 class="pt-3" style="display: inline-block;">${chaDTO.startDate} ~ ${chaDTO.enddate}</h5>
					  				</div>
					  				<%-- 순서 건들면 스크립트 틀어짐 --%>
					  				<input class="checkCertify" type="hidden" value="${chaDTO.todayCheckCertify}">
					  				<button id="certify" style="width: 300px; background-color: #EB534C;" type="button" class="btn btn-secondary btn-lg btn_certify">인증하기</button>
				  					<input class="hour_start" type="hidden" value="${chaDTO.hourStart}" readonly="readonly">
				  					<input class="hour_end" type="hidden" value="${chaDTO.hourEnd}" readonly="readonly">
				  					<input class="fk_freq_type" type="hidden" value="${chaDTO.fkFreqType}" readonly="readonly">
				  					<input id="challenge_code" type="hidden" value="${chaDTO.challengeCode}" readonly="readonly">
				  					<%-- 순서 건들면 스크립트 틀어짐 --%>
				  				</div>
				  			</div>
				  		</div>
				  		<c:set var="flag_ing" value="false" />
			  		</c:if>
			  		
				</c:forEach>
				
				<c:if test="${flag_ing}">
					<div id="not_chaList" class="my-4">진행 중인 챌린지가 없어요.&nbsp;<i class="fa-regular fa-face-sad-tear fa-lg" style="color: #000000;"></i></div>
			    </c:if>
			    
			</c:if>
			<c:if test="${empty requestScope.chaList}">
				<div id="not_chaList" class="my-4">진행 중인 챌린지가 없어요.&nbsp;<i class="fa-regular fa-face-sad-tear fa-lg" style="color: #000000;"></i></div>
			</c:if>
		</div>
		
		
		
		<div class="tab-pane container fade pt-3" id="challenge_before" style="font-size: 16pt;">
			<c:if test="${not empty requestScope.chaList}">
				<c:set var="flag_before" value="true" />
				<c:forEach var="chaDTO" items="${requestScope.chaList}">
				
					<c:if test="${chaDTO.startDate > today}">
				  		<div class="challengeList my-4" style="width: 100%; height: 250px; display: flex; border-radius: 20px;">
				  			<div style="height: 100%; width: 30%;">
					  			<img src="<%= ctxPath%>/images/${chaDTO.thumbnail}" style="object-fit: cover; height:90%; width: 90%; margin-top:12px; border-radius: 20px;"/>
				  			</div>
				  			<div style="text-align: left; width: 70%;">
				  				<div style="display: flex; justify-content: space-between;">
					  				<div class="mt-3" style="width: 180px; height: 35px; line-height: 34px; background-color: rgb(244, 244, 244); text-align: center; border-radius: 20px;">
					  					<div>${chaDTO.categoryName}</div>
					  				</div>
					  				<div class="mt-3 pr-3" style="font-weight: bold;">
					  					<span class="mr-2">현재 달성률</span><span>${chaDTO.achievementPct}%</span>
					  				</div>
				  				</div>
				  				<h4 class="my-3" style="font-weight: bold;">${chaDTO.challengeName}</h4>
				  				<div class="pr-3" style="margin-top: 30px; display: flex; justify-content: space-between;">
				  					<div><span>인증빈도 - </span><span>${chaDTO.frequency }</span></div>
				  					<div><span>인증시간 - </span><span>${chaDTO.hourStart} ~ ${chaDTO.hourEnd}</span></div>
				  				</div>
				  				<div class="mr-3" style="display: flex; justify-content: space-between; margin-top: 30px;">
					  				<div>
						  				<span>기간 : </span>
						  				<h5 class="pt-3" style="display: inline-block;">${chaDTO.startDate} ~ ${chaDTO.enddate}</h5>
					  				</div>
					  				<button id="certify" disabled="disabled" style="width: 300px; background-color: #EB534C;" type="button" class="btn btn-secondary btn-lg btn_certify" onclick="location.href='<%= request.getContextPath()%>/challenge/certify'">인증하기</button>
				  					<input id="challenge_code" type="hidden" value="${chaDTO.challengeCode}">
				  					<%-- 챌린지의 참가중인 userid 들어와야함 get방식으로 보낼때 아이디 추가--%>
				  				</div>
				  			</div>
				  		</div>
				  		<c:set var="flag_before" value="false" />
				  	</c:if>
				</c:forEach>
				
				<c:if test="${flag_before}">
					<div id="not_chaList" class="my-4">시작 전인 챌린지가 없어요.&nbsp;<i class="fa-regular fa-face-sad-tear fa-lg" style="color: #000000;"></i></div>
			    </c:if>
				
			</c:if>
			<c:if test="${empty requestScope.chaList}">
				<div id="not_chaList" class="my-4">시작 전인 챌린지가 없어요.&nbsp;<i class="fa-regular fa-face-sad-tear fa-lg" style="color: #000000;"></i></div>
			</c:if>
		</div>
		
	</div>
</div>
</div>