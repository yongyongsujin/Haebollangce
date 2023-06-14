<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
%>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.6/dist/sweetalert2.all.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.6/dist/sweetalert2.min.css" rel="stylesheet">

<style type="text/css">

	label#label_file {
		padding: 6px 25px;
		background-color: #EB534C;
		border-radius: 4px;
		color: white;
		cursor: pointer;
	}
	span.examInfo_left {
		display: inline-block; 
		width: 50%; 
		padding-left: 20%;
	}
	span.examInfo_right {
		display: inline-block; 
		width: 50%; 
		padding-left: 10%;
	}
	div.examInfo {
		width:70%; 
		font-size: 15pt; 
		margin: auto; 
		text-align: left;
	}
	div#img_exam {
		width:100%; 
		height: 370px; 
		display: flex; 
		font-size: 18pt; 
		font-weight: bold; 
		color: white;
	}
	p.img_OX {
		width: 100%; 
		height: 10%;
		border-bottom-left-radius: 20px; 
		border-bottom-right-radius: 20px;
	}
	img.img_insert {
		border: solid 2px black;
		border-top-left-radius: 20px; 
		border-top-right-radius: 20px;
	}
	/* ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 여기까지 모달창 css */

	
	li.certify_Mymenu {
		width: 50%;
	}
	
	a.menu_b {
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
	div#myProgress {
		border-radius: 20px;
		position: relative;
		width: 100%;
		height: 30px;
		background-color: #ddd;
	}
	div#Bar {
		border-radius: 20px;
		position: absolute;
		height: 100%;
		background-color: #4CAF50;
	}
	div#Bar {
		border-radius: 20px;
		position: absolute;
		height: 100%;
	}
	div#current_per {
		text-align: center;
		line-height: 30px;
		color: white;
	}
	
	/* 사진 hover CSS */
	span.report {
		display: flex; 
		justify-content:center; 
		align-items: center; 
		height: 50px; 
		width: 120px; 
		background-color: #EB534C; 
		color: white; 
		border-radius: 10px;
		opacity:0.8;
		cursor: pointer;
	}
	
	.my_image {
		opacity: 1;
		display: block;
		width: 100%;
		height: auto;
		transition: .5s ease;
		backface-visibility: hidden;
	}
	div.img_info {
		transition: .5s ease;
		opacity: 0;
		position: absolute;
		top: 50%;
		left: 47%;
		transform: translate(-50%, -50%);
		-ms-transform: translate(-50%, -50%);
		text-align: center;
	}
	.imgContainer:hover .my_image {
		opacity: 0.3;
	}
	
	.imgContainer:hover .img_info {
		opacity: 1;
	}
	
	
	/* 모든 참가자의 인증샷 */
	.user_image {
		opacity: 1;
		display: block;
		width: 100%;
		height: auto;
		transition: .5s ease;
		backface-visibility: hidden;
	}
	div.user_img_info {
		transition: .5s ease;
		opacity: 0;
		position: absolute;
		top: 50%;
		left: 47%;
		transform: translate(-50%, -50%);
		-ms-transform: translate(-50%, -50%);
		text-align: center;
	}
	.imgContainer:hover .user_image {
		opacity: 0.3;
	}
	
	.imgContainer:hover .user_img_info {
		opacity: 1;
	}
	
	.modal-content{  
	  -webkit-animation-name: zoom;
	  -webkit-animation-duration: 0.6s;
	  animation-name: zoom;
	  animation-duration: 0.6s;
	}
	
	@-webkit-keyframes zoom {
	  from {-webkit-transform:scale(0)} 
	  to {-webkit-transform:scale(1)}
	}
	
	@keyframes zoom {
	  from {transform:scale(0)} 
	  to {transform:scale(1)}
	}
	
</style>


<script type="text/javascript">

const imgInfo = document.querySelector('.img_info');

	$(document).ready(function(){

		const totalCertify = Number("${totalCertify}"); // 총인증횟수
		const certifyCnt = Number("${certifyCnt}"); // 인증횟수
		const remainCnt = totalCertify - certifyCnt;
		
		$("p#remainCertify").text(remainCnt+"회");
		
		const successPer = Math.trunc( (certifyCnt / totalCertify) * 100 );
		
		$("div#Bar").css({"width":successPer+"%"});
		$("div.current_per").text(successPer+"%");
		$("span#current_per").html("&nbsp;"+successPer+"%");
		
		if ( successPer != 0 && successPer < 80 ){
			const currentReward = Math.floor(Number("${joinedChallInfo.entry_fee}") * successPer / 100);
			$("span#currentDeposit").html("&nbsp;"+currentReward.toLocaleString('en')+"원"); 
		}
		else if ( successPer >= 80) {
			// 달성률이 80% 이상인 경우 현재 확보예치금은 걸어둔 예치금
			// 100%인 경우 계산 가능하면 추가하기
			$("span#currentDeposit").html("&nbsp;"+Number("${joinedChallInfo.entry_fee}").toLocaleString('en')+"원"); 
		};
		
		<%-- 차트 data --%>
		const data = {
				labels: [
				    '100%',
				    '80% 이상',
					'80% 미만'
				],
				datasets: [{
					label: '인원 수 (명)',
				    data: [ Number("${userAchieveCharts.hundredCnt}"), Number("${userAchieveCharts.eighty_up_cnt}"), Number("${userAchieveCharts.eighty_down_cnt}")],
				    backgroundColor: [
				      '#FCEEED',
				      '#F19E9B',
				      '#EB534C'
					],
					hoverOffset: 4
				}]
		};
		const config = {
			type: 'doughnut',
			data: data,
		};

		const myChart = new Chart(
			document.getElementById('myChart'),
			config
		);
		
		
		$("span.report").click(function(){
			const certifyNo = $(this).parent().next().val();
			$("input#certifyNo").val(certifyNo);
		})
		
		
	}); // end ready
	 
	// 상세 페이지로 이동하는 함수
	function goDetail() {
		location.href='<%= ctxPath%>/challenge/challengeView?challenge_code='+'${joinedChallInfo.challenge_code}';
	}
	
	// 유저가 신고했을 때
	function userReport() {

		if ( $("textarea#report_content").val().trim() == "") {
			Swal.fire({
				icon: "warning",
				title: "신고내용을 입력하세요 !",
				confirmButtonColor: "#EB534C",
				confirmButtonText: "확인"
			});
			$("textarea#report_content").focus();
			return;
		}
		
		const frm = document.userReportFrm;
		frm.action = "<%= ctxPath%>/challenge/userReport";
		frm.method = "post";
		frm.submit();
	}

	
</script>


<div class="container-fluid" style="background-color: #f4f4f4;">
<div class="container pb-5" style="border-radius: 20px; width: 70% !important; background-color: white; text-align: center; font-size: 18pt;">
	<br>
	<h3 style="font-weight: bold;">참가중인 챌린지 인증정보</h3>
	<br>
	<div style="height: 500px; width: 95%; margin:auto;">
		<img src="<%= ctxPath%>/images/${joinedChallInfo.thumbnail}" width="100%" height="100%" style="object-fit: cover; border-radius: 20px;"/>
	</div>
	<div class="mt-5" style="display: inline-block; width: 100%;">
		<p style="display: inline-block; width: 20%; margin:0;"><span style="background-color: rgb(244, 244, 244); display: inline-block; border-radius: 20px; width: 100%; height: 44px; line-height: 48px;">${joinedChallInfo.category_name}</span></p>
		<p style="display: inline-block; width: 45%; margin:0; font-weight: bold; font-size: 22pt;"><span style="background-color: rgb(244, 244, 244); display: inline-block; border-radius: 20px; width: 100%;">${joinedChallInfo.challenge_name}</span></p>
		<p style="display: inline-block; width: 32%; margin:0; font-size: 16pt;"><i class="fa-regular fa-calendar-days fa-lg mr-2" style="color: #000000;"></i>${joinedChallInfo.startDate} ~ ${joinedChallInfo.enddate}</p>
	</div>
	<div class="my-5">
		<button onclick="goDetail();" type="button" class="btn btn-lg mb-3 mr-3" style="background-color: #EB534C; color: white;">상세페이지로 이동 ></button>
		<button type="button" class="btn btn-lg mb-3" style="background-color: #EB534C; color: white;" data-toggle="modal" data-target="#exampleModal_certify"><i class="fa-solid fa-camera fa-xl" style="color: #fffff;"></i>&nbsp;&nbsp;인증 방법 및 인증샷 예시</button>
	</div>
	
	<ul class="nav nav-tabs mt-5" style="justify-content: center;">
		<li class="nav-item certify_Mymenu">
			<a class="nav-link active menu_b" id="myCertify" data-toggle="tab" href="#myCertifyInfo">나의 인증 현황</a>
		</li>
		<li class="nav-item certify_Mymenu">
			<a class="nav-link menu_b" id="userCertify" data-toggle="tab" href="#userCertifyInfo">참가자 인증 현황</a>
		</li>
	</ul>
	
	<!-- Tab panes -->
	<div class="tab-content pb-5">
		<div class="tab-pane container active" id="myCertifyInfo" style="font-size: 16pt;">
	  		<div class="pt-5" style="display: flex; justify-content: space-between;">
	  			<span>현재 달성률</span>
	  			<span>예상 달성률</span>
	  		</div>
	  		<div class="pb-2" style="display: flex; justify-content: space-between; font-weight: bold;">
	  			<span id="current_per"></span>
	  			<span>100%&nbsp;</span>
	  		</div>
	  		<div id="myProgress">
				<div id="Bar" style="width: 40%;">
			    	<div id="current_per" class="current_per"></div>
			  	</div>
			  	<div id="80perBar" style="width: 80%; border-right: solid 3px gray;">
			    	<div id="current_per" style="color: gray;">80%</div>
			  	</div>
			</div>
			<div class="pt-2" style="display: flex; justify-content: space-between;">
	  			<span>현재 확보한 상금</span>
	  			<span>걸어둔 예치금</span>
	  		</div>
	  		<div class="pb-5" style="display: flex; justify-content: space-between; font-weight: bold;">
	  			<span id="currentDeposit">&nbsp;0원</span>
	  			<span><fmt:formatNumber value="${joinedChallInfo.entry_fee}" pattern="#,###"></fmt:formatNumber>원&nbsp;</span>
	  		</div>
	  		<div class="my-5" style="display: flex; justify-content: space-around;">
				<div><p class="mb-1">인증성공</p><p style="font-weight: bold;">${certifyCnt}회</p></div>
				<div><p class="mb-1">남은인증</p><p id="remainCertify" style="font-weight: bold;"></p></div>
				<div><p class="mb-1">총 인증횟수</p><p style="font-weight: bold;">${totalCertify}회</p></div>
			</div>
	  		<h4 class="mt-5 mb-3" style="font-weight: bold; text-align: left;">나의 인증샷</h4>
	  		<table class="my-3" style="width: 100%;"> 
	  			
	  			<c:if test="${not empty myCertifyHistory}">
	  				<c:set var="length" value="${myCertifyHistory.size()}"></c:set>
	  			
  					<c:forEach var="certifyDTO" items="${myCertifyHistory}" varStatus="status">
  						<c:if test="${status.index % 3 == 0}">
				  			<tr style="height:250px; width:100%;">
  						</c:if>
  							<c:if test="${length == 1}">
								<td class="imgContainer" style="height:300px; width:33%; position: relative;">
	  								<img class="my_image" style="width: 100%; height:100%; object-fit: cover;" alt="이미지 로딩중" src="<%= ctxPath%>/images/certify/${certifyDTO.certifyImg}">
	  								<div class="img_info">
	  									<div><span data-toggle="modal" data-target="#myImage${status.index }" class="report" style="background-color: gray; opacity:0.8;">사진보기</span></div>
	  								</div>
	  							</td>
	  							
  								<!-- 사진 확대 Modal -->
								<div class="modal fade" id="myImage${status.index }">
								  <div class="modal-dialog modal-dialog-centered modal-lg">
								    <div class="modal-content">
								      <div class="modal-body">
									      <button type="button" class="close" data-dismiss="modal">&times;</button>
									      <img class="my_image mt-5" style="width: 100%; height:100%;" alt="이미지 로딩중" src="<%= ctxPath%>/images/certify/${certifyDTO.certifyImg}">
								      </div>
								    </div>
								  </div>
								</div>
								<td></td>
  							</c:if>
  							
  							<c:if test="${length == 2}">
								<td class="imgContainer" style="height:300px; width:33%; position: relative;">
	  								<img class="my_image" style="width: 100%; height:100%; object-fit: cover;" alt="이미지 로딩중" src="<%= ctxPath%>/images/certify/${certifyDTO.certifyImg}">
	  								<div class="img_info">
	  									<div><span data-toggle="modal" data-target="#myImage${status.index }" class="report" style="background-color: gray; opacity:0.8;">사진보기</span></div>
	  								</div>
	  							</td>
	  							
  								<!-- 사진 확대 Modal -->
								<div class="modal fade" id="myImage${status.index }">
								  <div class="modal-dialog modal-dialog-centered modal-lg">
								    <div class="modal-content">
								      <div class="modal-body">
									      <button type="button" class="close" data-dismiss="modal">&times;</button>
									      <img class="my_image mt-5" style="width: 100%; height:100%;" alt="이미지 로딩중" src="<%= ctxPath%>/images/certify/${certifyDTO.certifyImg}">
								      </div>
								    </div>
								  </div>
								</div>
  							</c:if>
  							
  							<c:if test="${length > 2 }">
								<td class="imgContainer" style="height:300px; width:33%; position: relative;">
	  								<img class="my_image" style="width: 100%; height:100%; object-fit: cover;" alt="이미지 로딩중" src="<%= ctxPath%>/images/certify/${certifyDTO.certifyImg}">
	  								<div class="img_info">
	  									<div><span data-toggle="modal" data-target="#myImage${status.index }" class="report" style="background-color: gray; opacity:0.8;">사진보기</span></div>
	  								</div>
	  							</td>
	  							
  								<!-- 사진 확대 Modal -->
								<div class="modal fade" id="myImage${status.index }">
								  <div class="modal-dialog modal-dialog-centered modal-lg">
								    <div class="modal-content">
								      <div class="modal-body">
									      <button type="button" class="close" data-dismiss="modal">&times;</button>
									      <img class="my_image mt-5" style="width: 100%; height:100%;" alt="이미지 로딩중" src="<%= ctxPath%>/images/certify/${certifyDTO.certifyImg}">
								      </div>
								    </div>
								  </div>
								</div>
  							</c:if>
		  				<c:if test="${(status.index+1) % 3 == 0}">
			  				</tr>
			  			</c:if>
			  			
  					</c:forEach>
  						<c:if test="${length == 2}"><td></td></c:if>
  				</c:if>
  				<c:if test="${empty myCertifyHistory}">
  					<tr style="border: solid 1px black; height:250px; border-collapse: collapse; border-radius:20px; box-shadow: 0 0 0 1px #000; border-style: hidden;">
		  				<td style="font-weight: bold; font-size: 20pt;">나의 인증기록이 없어요.&nbsp;&nbsp;<i class="fa-regular fa-face-sad-tear fa-lg" style="color: #000000;"></i></td>
		  			</tr>
  				</c:if>
	  		
	  		</table>
		</div>
		
		
		<div class="tab-pane container fade" id="userCertifyInfo" style="font-size: 16pt;">
			<div class="pt-5" style="display: flex;">
				<div style="width: 50%;"><p style="margin: 0;">총 참가자 수</p><p style="font-weight: bold;">${userAchieveCharts.member_count}명</p></div>
				<div style="width: 50%;"><p style="margin: 0;">평균 예상 달성률</p><p style="font-weight: bold;">${userAchieveCharts.achievement_pct_avg}%</p></div>
	  		</div>
  			<div class="my-5" style="width: 50%; margin: auto;">
			  <canvas id="myChart"></canvas>
			</div>
			<div class="my-5" style="display: flex; justify-content: space-evenly;">
				<div>
					<p class="mb-1">
						<span style="border:solid 2px #E2D5D5; border-radius: 20px; background-color: #FCEEED;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						&nbsp;&nbsp;100%
					</p>
					<p style="font-weight: bold;">${userAchieveCharts.hundredCnt}명</p>
				</div>
				<div>
					<p class="mb-1">
						<span style="border:solid 2px #D88E8B; border-radius: 20px; background-color: #F19E9B;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						&nbsp;&nbsp;80% 이상
					</p>
					<p style="font-weight: bold;">${userAchieveCharts.eighty_up_cnt}명</p>
				</div>
				<div>
					<p class="mb-1">
						<span style="border:solid 2px #D34A44; border-radius: 20px; background-color: #EB534C;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						&nbsp;&nbsp;80% 미만
					</p>
					<p style="font-weight: bold;">${userAchieveCharts.eighty_down_cnt}명</p>
				</div>
			</div>
			<h4 class="mt-5 mb-3" style="font-weight: bold; text-align: left;">참가자 인증샷</h4>
	  		<table class="my-3" style="width: 100%;">
	  		
	  			<c:if test="${not empty allCertifyHistory}">
	  				<c:set var="length" value="${allCertifyHistory.size()}"></c:set>
	  				
  					<c:forEach var="allcertifyDTO" items="${allCertifyHistory}" varStatus="status">
  						<c:if test="${status.index % 3 == 0}">
				  			<tr style="height:250px; width:100%;">
  						</c:if>
  							<c:if test="${length == 1}">
	  							<td class="imgContainer" style="height:300px; width:33%; position: relative;">
	  								<img class="user_image" style="width: 100%; height:100%; object-fit: cover;" alt="이미지 로딩중" src="<%= ctxPath%>/images/certify/${allcertifyDTO.certifyImg}">
	  								<div class="user_img_info">
	  									<div><span data-toggle="modal" data-target="#report" class="report">신고하기</span></div>
	  									<input type="hidden" value="${allcertifyDTO.certifyNo}">
	  									<div class="mt-3"><span data-toggle="modal" data-target="#userImage${status.index }" class="report" style="background-color: gray; opacity:0.8;">사진보기</span></div>
	  								</div>
	  							</td>
	  							
	  							<!-- 사진 확대 Modal -->
								<div class="modal fade" id="userImage${status.index }">
								  <div class="modal-dialog modal-dialog-centered modal-lg">
								    <div class="modal-content">
								      <div class="modal-body">
									      <button type="button" class="close" data-dismiss="modal">&times;</button>
									      <img class="user_image mt-5" style="width: 100%; height:100%;" alt="이미지 로딩중" src="<%= ctxPath%>/images/certify/${allcertifyDTO.certifyImg}">
								      </div>
								    </div>
								  </div>
								</div>
								<td></td>
							</c:if>
							
							<c:if test="${length == 2}">
	  							<td class="imgContainer" style="height:300px; width:33%; position: relative;">
	  								<img class="user_image" style="width: 100%; height:100%; object-fit: cover;" alt="이미지 로딩중" src="<%= ctxPath%>/images/certify/${allcertifyDTO.certifyImg}">
	  								<div class="user_img_info">
	  									<div><span data-toggle="modal" data-target="#report" class="report">신고하기</span></div>
	  									<input type="hidden" value="${allcertifyDTO.certifyNo}">
	  									<div class="mt-3"><span data-toggle="modal" data-target="#userImage${status.index }" class="report" style="background-color: gray; opacity:0.8;">사진보기</span></div>
	  								</div>
	  							</td>
	  							
	  							<!-- 사진 확대 Modal -->
								<div class="modal fade" id="userImage${status.index }">
								  <div class="modal-dialog modal-dialog-centered modal-lg">
								    <div class="modal-content">
								      <div class="modal-body">
									      <button type="button" class="close" data-dismiss="modal">&times;</button>
									      <img class="user_image mt-5" style="width: 100%; height:100%;" alt="이미지 로딩중" src="<%= ctxPath%>/images/certify/${allcertifyDTO.certifyImg}">
								      </div>
								    </div>
								  </div>
								</div>
							</c:if>
							
							<c:if test="${length > 2}">
	  							<td class="imgContainer" style="height:300px; width:33%; position: relative;">
	  								<img class="user_image" style="width: 100%; height:100%; object-fit: cover;" alt="이미지 로딩중" src="<%= ctxPath%>/images/certify/${allcertifyDTO.certifyImg}">
	  								<div class="user_img_info">
	  									<div><span data-toggle="modal" data-target="#report" class="report">신고하기</span></div>
	  									<input type="hidden" value="${allcertifyDTO.certifyNo}">
	  									<div class="mt-3"><span data-toggle="modal" data-target="#userImage${status.index }" class="report" style="background-color: gray; opacity:0.8;">사진보기</span></div>
	  								</div>
	  							</td>
	  							
	  							<!-- 사진 확대 Modal -->
								<div class="modal fade" id="userImage${status.index }">
								  <div class="modal-dialog modal-dialog-centered modal-lg">
								    <div class="modal-content">
								      <div class="modal-body">
									      <button type="button" class="close" data-dismiss="modal">&times;</button>
									      <img class="user_image mt-5" style="width: 100%; height:100%;" alt="이미지 로딩중" src="<%= ctxPath%>/images/certify/${allcertifyDTO.certifyImg}">
								      </div>
								    </div>
								  </div>
								</div>
							</c:if>
								
		  				<c:if test="${(status.index+1) % 3 == 0}">
			  				</tr>
			  			</c:if>
  					</c:forEach>
  						<c:if test="${length == 2}"><td></td></c:if>
  				</c:if>
  				<c:if test="${empty allCertifyHistory}">
  					<tr style="border: solid 1px black; height:250px; border-collapse: collapse; border-radius:20px; box-shadow: 0 0 0 1px #000; border-style: hidden;">
		  				<td style="font-weight: bold; font-size: 20pt;">참가자 인증기록이 없어요.&nbsp;&nbsp;<i class="fa-regular fa-face-sad-tear fa-lg" style="color: #000000;"></i></td>
		  			</tr>
  				</c:if>
	  		
	  		</table>
		</div>
	</div>
	
</div>
</div>



<%-- 인증예시 모달창 --%>
<div class="modal fade" id="exampleModal_certify">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
			<!-- Modal header -->
			<div class="modal-header">
				<h4 class="modal-title" style="font-weight: bold; padding-left: 340px;">인증방법</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			
			<!-- Modal body -->
			<div class="modal-body" style="text-align: center; justify-content: center;">
				<div style="height: 650px; justify-content: center;">
					<div id="img_exam">
						<div style="width: 50%; border-radius: 20px;">
							<img class="img_insert" src="<%= ctxPath%>/images/${oneExample.success_img}" width="100%" height="90%" style="object-fit: cover;"/>
							<p class="img_OX" style="background-color:#57B585;">○</p>
						</div>
						<div style="width: 50%; border-radius: 20px;">
							<img class="img_insert" src="<%= ctxPath%>/images/${oneExample.fail_img}" width="100%" height="90%" style="object-fit: cover;"/>
							<p class="img_OX" style="background-color:#AF2317;">✕</p>
						</div>
					</div>
					<div class="my-3" style="font-size: 18pt; font-weight: bold;">인증 예시) - ${oneExample.example}</div>
					<div class="my-3" style="font-size: 18pt; font-weight: bold;">꼭 알아주세요 !</div>
					<div>
						<div class="examInfo my-2">
							<span class="examInfo_left">인증 빈도</span><span class="examInfo_right">${oneExample.frequency}</span>
						</div>
						<div class="examInfo my-2">
							<span class="examInfo_left">인증 가능 시간</span><span class="examInfo_right">${oneExample.hour_start} ~ ${oneExample.hour_end}</span>
						</div>
						<div class="examInfo my-2">
							<span class="examInfo_left">하루 인증 횟수</span><span class="examInfo_right">1회</span>
						</div>
						
					</div>
				</div>
			</div>
			
			<!-- Modal footer -->
			<div class="modal-footer" style="justify-content: center;">
				<button type="button" class="btn btn-danger btn-lg" data-dismiss="modal">확인</button>
			</div>
		</div>
	</div>
</div>

<%-- 신고하기 모달창 --%>
<div class="modal fade" id="report">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
     
			<!-- Modal header -->
			<div class="modal-header">
				<img style="width:30px;" src="<%= ctxPath%>/images/certify/siren.png">&nbsp;&nbsp;
				<h5 class="modal-title" style="margin-top: 5px;">신고하기</h5>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
     
			<!-- Modal body -->
			<div class="modal-body">
				<form name="userReportFrm">
					<textarea id="report_content" name="report_content" rows="5" cols="54" placeholder="정확한 처리를 위해 신고하시는 구체적인 사유를 적어주세요. (최소 10자 이상) 신고내용 - ex)적합하지 않은 인증사진" style="outline-color: #FE6B8B;"></textarea>
					<input id="certifyNo" type="hidden" name="certifyNo" value="" readonly="readonly">
					<input name="challenge_code" type="hidden" value="${joinedChallInfo.challenge_code}">
				</form>
			</div>
     
			<!-- Modal footer -->
			<div class="modal-footer">
			 	<button type="button" class="btn btn-secondary" onclick="userReport();" style="background-color: #EB534C !important;">신고하기</button> 
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
			
		</div>
	</div>
</div>