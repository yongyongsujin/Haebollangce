<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>


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
	
	p.cha_info {
		display: inline-block; 
		width: 32%; 
		margin:0;
	}
	
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
	
</style>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		<%-- 차트 data --%>
		const data = {
				labels: [
				    'Red',
				    'Blue',
					'Yellow'
				],
				datasets: [{
					label: 'My First Dataset',
				    data: [300, 50, 100],
				    backgroundColor: [
				      'rgb(255, 99, 132)',
				      'rgb(54, 162, 235)',
				      'rgb(255, 205, 86)'
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
		
		
	}); // end ready
	
	// 나의 인증 현황 바 채워지는 함수
	<%-- 
	function move() {
		var elem = document.getElementById("Bar");   
		var width = 10;
		var id = setInterval(frame, 10);
		
		function frame() {
			if (width >= 100) {
				clearInterval(id);
			} 
			else {
				width++; 
				elem.style.width = width + '%'; 
				document.getElementById("label").innerHTML = width * 1  + '%';
			}
		}
	}
	--%>
	
	

	
</script>



<div class="container" style="width: 70% !important; background-color: white; text-align: center; font-size: 18pt;">
	<br>
	<h3 style="font-weight: bold;">참가중인 챌린지 인증정보</h3>
	<br>
	<div style="border: solid 1px red; height: 300px; width: 50%; margin:auto;">
		<img />
	</div>
	<div class="mt-5" style="border:solid 1px black; display: inline-block; width: 100%;">
		<p class="cha_info">챌린지 카테고리명</p>
		<p class="cha_info">챌린지 제목</p>
		<p class="cha_info">챌린지 날짜</p>
	</div>
	<div class="my-5" style="border:solid 1px black;">챌린지 내용</div>
	<button type="button" class="btn btn-lg mb-3" style="background-color: #EB534C; color: white;" data-toggle="modal" data-target="#exampleModal_certify"><i class="fa-solid fa-camera fa-xl" style="color: #fffff;"></i>&nbsp;&nbsp;인증 방법 및 인증샷 예시</button>
	
	
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
	  			<span>&nbsp;0%</span>
	  			<span>100%&nbsp;</span>
	  		</div>
	  		<div id="myProgress">
				<div id="Bar" style="width: 30%;">
			    	<div id="current_per">30%</div>
			  	</div>
			  	<div id="80perBar" style="width: 80%; border-right: solid 3px gray;">
			    	<div id="current_per" style="color: gray;">80%</div>
			  	</div>
			</div>
			<div class="pt-2" style="display: flex; justify-content: space-between;">
	  			<span>현재 확보한 예치금</span>
	  			<span>걸어둔 예치금</span>
	  		</div>
	  		<div class="pb-5" style="display: flex; justify-content: space-between; font-weight: bold;">
	  			<span>&nbsp;0원</span>
	  			<span>0원&nbsp;</span>
	  		</div>
	  		<div class="my-5" style="display: flex; justify-content: space-around;">
				<div><p class="mb-1">인증성공</p><p style="font-weight: bold;">3회</p></div>
				<div><p class="mb-1">인증실패</p><p style="font-weight: bold;">1회</p></div>
				<div><p class="mb-1">남은인증</p><p style="font-weight: bold;">2명</p></div>
			</div>
	  		<h4 class="mt-5 mb-3" style="font-weight: bold; text-align: left;">나의 인증샷</h4>
	  		<table style="border: solid 1px black; width: 100%;">
	  			<tr style="border: solid 1px black; height:250px;">
	  				<td style="border: solid 1px black;">사진1</td>
	  				<td style="border: solid 1px black;">사진2</td>
	  				<td style="border: solid 1px black;">사진3</td>
	  			</tr>
	  		</table>
		</div>
		
		
		<div class="tab-pane container fade" id="userCertifyInfo" style="font-size: 16pt;">
			<div class="pt-5" style="display: flex;">
				<div style="width: 50%;"><p style="margin: 0;">총 참가자 수</p><p style="font-weight: bold;">751명</p></div>
				<div style="width: 50%;"><p style="margin: 0;">평균 예상 달성률</p><p style="font-weight: bold;">100%</p></div>
	  		</div>
  			<div class="my-5" style="width: 50%; margin: auto;">
			  <canvas id="myChart"></canvas>
			</div>
			<div class="my-5" style="display: flex; justify-content: space-evenly;">
				<div>
					<p class="mb-1">
						<span style="border:solid 2px #D34A44; border-radius: 20px; background-color: #EB534C;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						&nbsp;&nbsp;100%
					</p>
					<p style="font-weight: bold;">751명</p>
				</div>
				<div>
					<p class="mb-1">
						<span style="border:solid 1px #D88E8B; border-radius: 20px; background-color: #F19E9B;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						&nbsp;&nbsp;85% 이상
					</p>
					<p style="font-weight: bold;">3명</p>
				</div>
				<div>
					<p class="mb-1">
						<span style="border:solid 1px #E2D5D5; border-radius: 20px; background-color: #FCEEED;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						&nbsp;&nbsp;85% 미만
					</p>
					<p style="font-weight: bold;">0명</p>
				</div>
			</div>
			<h4 class="mt-5 mb-3" style="font-weight: bold; text-align: left;">참가자 인증샷</h4>
	  		<table style="border: solid 1px black; width: 100%;">
	  			<tr style="border: solid 1px black; height:250px;">
	  				<td style="border: solid 1px black;">사진1</td>
	  				<td style="border: solid 1px black;">사진2</td>
	  				<td style="border: solid 1px black;">사진3</td>
	  			</tr>
	  		</table>
		</div>
	</div>
	
</div>



<%-- 모달창 --%>
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
							<img class="img_insert" src="" width="100%" height="90%"/>
							<p class="img_OX" style="background-color:#57B585;">○</p>
						</div>
						<div style="width: 50%; border-radius: 20px;">
							<img class="img_insert" src="" width="100%" height="90%"/>
							<p class="img_OX" style="background-color:#AF2317;">✕</p>
						</div>
					</div>
					<div class="my-3" style="font-size: 18pt; font-weight: bold;">(DB에서 읽어온 인증예시 내용)</div>
					<div class="my-3" style="font-size: 18pt; font-weight: bold;">꼭 알아주세요 !</div>
					<div>
						<div class="examInfo my-2">
							<span class="examInfo_left">인증 가능 요일</span><span class="examInfo_right">월 화 수 목 금 토 일</span>
						</div>
						<div class="examInfo my-2">
							<span class="examInfo_left">인증 빈도</span><span class="examInfo_right">매일</span>
						</div>
						<div class="examInfo my-2">
							<span class="examInfo_left">인증 가능 시간</span><span class="examInfo_right">00시 00분 ~ 23시 59분</span>
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