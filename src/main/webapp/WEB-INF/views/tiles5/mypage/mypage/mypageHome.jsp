<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%
    String ctxPath = request.getContextPath();
%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<style type="text/css">
	div#mainPosition {
		margin: 99px 5% 0 5%;
	}
	
	table {
		width: 100%;
	}
	
	div#plzCha,
	div#notice {
		margin-bottom: 50px;
	}
	
	img#promainimg {
		height: 84px;
		border-radius: 50px;
		margin-right: 41px;
		margin-left: 24px;
	}
	
	div#user_info {
		margin-bottom: 50px;
	}
	
	div#level_percent {
		font-size: 13pt;
		margin-top: 38px;
	}
	
	div#user_level {
		font-size: 15pt;
		margin-right: 20px;
	}
	
	button.go_cite {
		width: 156px;
		height: 50px;
		border: none;
		border-radius: 40px;
		background-color: #f43630;
		color: white;
		font-size: 13pt;
		font-weight: bold;
	}
	
	button#go_deposit,
	button#go_reward {
		width: 99px;
		height: 35px;
		border: none;
		border-radius: 40px;
		background-color: #f43630;
		color: white;
		font-size: 10pt;
		font-weight: bold;
	}
	
	button#go_detail {
		width: 156px;
		height: 50px;
		border: none;
		border-radius: 40px;
		background-color: #f43630;
		color: white;
		font-size: 13pt;
		font-weight: bold;
	}
	
</style>

	<div id="mainPosition">
		<div class="row">
			<div class="col-lg-12 mb-4" style="margin-bottom:41px;">
					<div class="card border-left-info shadow h-100 py-2">
						<div class="card-body">
							<div class="row no-gutters align-items-center ">
									<img id="promainimg" alt="프로필사진입니다." src="yjs.images/testpro.jpg">
								<div class="col mr-2">
									<div class="text-xs font-weight-bold text-info text-uppercase mb-1" style="font-size:18pt">사용자아이디</div>
	   								<div class="row no-gutters align-items-center">
										<div class="col-auto">
											<div id="user_level">level 5</div>
										</div>
										<div class="col">
											<div class="progress progress-sm mr-2" style="width:400px;">
	 											<div class="progress-bar bg-info" role="progressbar" style="width: 10%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		
		<!-- index 상단 제목 시작 -->
 		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h3 mb-0 text-gray-800">사용자 코인 현황</h1>
		</div>
		<!-- index 상단 제목 끝 -->
		
		<!-- index 메인 시작 -->
		<div class="row">
		
			<!-- 코인보유량 시작 -->
			<div class="col-lg-3 col-md-6 mb-4">
 				<div class="card border-left-primary shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">보유 예치금</div>
								<div class="h5 mb-0 font-weight-bold text-gray-800">10,000원</div>
							</div>
							<div class="col-auto">
								<button type="button" id="go_deposit" onClick="location.href='<%=ctxPath%>/mypage/depositPurchase'">
									<i class="fas fa-won-sign" style="color: #4b9156;"></i>
									충전
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 코인보유량 끝 -->

			<!-- 보유상금 시작 -->
			<div class="col-lg-3 col-md-6 mb-4">
				<div class="card border-left-success shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-xs font-weight-bold text-success text-uppercase mb-1">보유 상금</div>
								<div class="h5 mb-0 font-weight-bold text-gray-800">100,000원</div>
							</div>
							<div class="col-auto">
								<button type="button" id="go_reward" onClick="location.href='<%=ctxPath%>/mypage/change_reward'">
									<i class="fas fa-coins" style="color: #fff700;"></i>
									상금전환
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 보유상금 끝 -->
			
			<!-- 인증 성공률 시작 -->
			<!-- 총 인증한 챌린지/총 참여챌린지 최대 인증횟수 -->
			<div class="col-lg-3 col-md-6 mb-4">
				<div class="card border-left-info shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-xs font-weight-bold text-info text-uppercase mb-1">인증성공률</div>
   								<div class="row no-gutters align-items-center">
									<div class="col-auto">
										<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">10%</div>
									</div>
									<div class="col">
										<div class="progress progress-sm mr-2">
 											<div class="progress-bar bg-info" role="progressbar" style="width: 10%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-check-square fa-lg"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 인증 성공률 끝 -->

			<!-- 알림 시작 -->
			<div class="col-lg-3 col-md-6 mb-4">
				<div class="card border-left-warning shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-xs font-weight-bold text-warning text-uppercase mb-1">알림</div>
								<div class="h5 mb-0 font-weight-bold text-gray-800">18</div>
							</div>
							<div class="col-auto">
								<i class="fas fa-bell fa-lg" style="color: #eeff00;"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 알림 끝 -->
           </div>
           
			<!-- 인증이 필요한 챌린지 시작 -->
			<div class="row">
				<div class="col-lg-12 mb-8">
					<div id="plzCha" class="card shadow mb-8">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">인증이 필요한 챌린지</h6>
						</div>
						<div class="card-body">
							<div class="text-center">
								<form>
									<table>
										<tr>
											<td style="width:25%;"><img class="img-fluid px-3 px-sm-4 mt-3 mb-4"  src="img/undraw_posting_photo.svg" alt="챌린지이미지"></td>
											<td style="width:25%;">챌린지이름</td>
											<td style="width:30%;">인증시간</td>
											<td style="30%"><button class="go_cite">인증하러 가기</button></td>
										</tr>
									</table>   
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 인증이 필요한 챌린지 끝 -->

			<!-- 두번째문단 시작 -->
			<div class="row">
				<!-- 공지사항 시작 -->
				<div class="col-lg-4 mb-4">
					<div id="notice" class="card shadow mb-8">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">공지사항</h6>
 						</div>
						<div class="card-body">
							<table>
								<tr>
									<td style="width:30%; text-align:center;">글번호</td>
									<td style="width:40%; text-align:center;">공지사항제목</td>
									<td style="width:30%; text-align:center;">작성일자</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<!-- 공지사항 끝 -->
				
				<!-- 새로운 챌린지 추천 시작 -->
				<div class="col-lg-8 mb-4">
					<div id="notice" class="card shadow mb-8">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">새로운 챌린지 추천</h6>
 						</div>
						<div class="card-body">
							<form>
								<table>
									<tr>
										<td style="width:30%;">
											<img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;" src="img/undraw_posting_photo.svg" alt="챌린지이미지">
										</td>
										<td style="width:36%;">챌린지이름</td>
										<td style="width:20%;"><button type="button" id="go_detail">상세보기</button></td>
									</tr>
								</table>   
							</form>
						</div>
					</div>
				</div>
				<!-- 새로운 챌린지 추천 끝 -->
			</div>
			<!-- 두번째문단 끝 -->
				
			
			
			
			
			<!-- 챌린지 리포트 시작-->
			<div class="row">
				<div class="col-lg-12 mb-8">
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">챌린지 리포트</h6>
						</div>
						<div class="card-body">
							<div class="chart-bar">
  								<canvas id="myBarChart"></canvas>
							</div>
							<hr>
							Styling for the bar chart can be found in the
							<code>/js/demo/chart-bar-demo.js</code> file.
						</div>
					</div>
				</div>
			</div>
			<!-- 챌린지 리포트 끝 -->
			
		</div>
		<!-- 메인 끝 -->
		
</body>
</html> 
