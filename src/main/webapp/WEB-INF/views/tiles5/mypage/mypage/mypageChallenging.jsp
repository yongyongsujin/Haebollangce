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
	
	div#plzCha,
	div#notice {
		margin-bottom: 50px;
	}
	
	.change_tag_sort {
		color: red;
		font-weight: bold;
	}
	
	td.tag_sort {
		cursor: pointer;
		text-align: center;
		padding-top: 30px;
	}
	
	
	
	img.cha_img {
		width: 20rem;
		border-radius: 20%;
	}
	
	i.menu_icon {
		margin-right: 17px;
	}
	
	div.user_level {
		margin: 20px 23px;
	}
	
	div.bar_width {
		width: 400px;
	}
	
	button.go_detail {
		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 7px 12px;
		text-align: center;
		font-size: 13pt;
		margin: 0 18%;
		transition: 0.3s;
		border-radius: 35px;
	}
	
	button.go_detail:hover {
		background-color: #f43630;
		color: white;
	}
	
	div#show_ratio {
		width: 41%;
	}
	
	div.div_margin_10px {
		margin: 10px 0;
	}
	
	div.div_info {
		margin: 8px 0;
		font-size: 13pt;
	}
	
	td.td_width_33 {
		width: 33%;
	}
	
	div.go_certify,
	div.go_board {
		color: black;
		font-size: 14pt;
		font-weight: bold;
		margin: 10px 0;
		cursor: pointer;
	}
	
	
</style>

<script type="text/javascript">

	//7일전 알아오기 시작 //
	let nowDate = new Date();
	let weekDate = nowDate.getTime() -(7*24*60*60*1000);
	nowDate.setTime(weekDate);
	
	let weekYear = nowDate.getFullYear();
	let weekMonth = nowDate.getMonth() + 1;
	let weekDay = nowDate.getDate();
	
	if(weekMonth < 10) {weekMonth = "0" + weekMonth};
	if(weekDay < 10) {weekDay = "0" + weekDay};
	
	let resultDate = weekYear + "-" + weekMonth + "-" + weekDay;
	// 7일전 알아오기 끝 //
	
	// 오늘 날짜 알아오기 시작 //
	const today = new Date();
		
	let todayMonth = today.getMonth() + 1;
	let todayDay = today.getDate();
	
	if(todayMonth < 10) {todayMonth = "0" + todayMonth};
	if(todayDay < 10) {todayDay = "0" + todayDay};
	
	let resultToday = today.getFullYear() + "-" + todayMonth + "-" + todayDay;
	// 오늘 날짜 알아오기 끝 //


	$(document).ready(function(){
		
		tag_sort(0);
		
		
		
		<%-- 챌린지 추천하기 시작 --%>
		$.ajax ({
			url:"/mypage/mypage_recommend_ajax",
			type:"GET",
			data:{
				"userid":"jisu"
			},
			dataType:"json",
			success:function(json){
				// 사용자가 관심태그로 설정한 카테고리로 있는 챌린지들 추천
				// console.log(JSON.stringify(json));
				
				let html = "";
				
				let cnt = 0;
				
				if(json.length > 0) {
					
					for(var i=0; i<json.length; i++) {
						
						if(resultDate <= json[i].startdate) {
						
							cnt++;
							
							if(cnt > 4) {
								break;
							}
							
							html += "<table class='col-lg-6'>"
								 +	"	<tr>"
								 +	"		<td class='td_width_33'>"
								 +  "			<img class='img-fluid px-3 px-sm-4 mt-3 mb-4 cha_img' src='" + json[i].thumbnail + "' alt='챌린지이미지'>"
								 +	"		</td>"
								 +	"		<td>"
								 +	"			<div class='div_info'>챌린지이름: " + json[i].challenge_name + "</div>"
								 +	"			<div class='div_info'>시작일자: " + json[i].startdate + "</div>"
								 +	"			<div class='div_info'>개설자: " + json[i].fk_userid +"</div>"
								 +	"		</td>"
								 +	"		<td>"
								 +	"			<button type='button' class='go_detail'>상세보기</button>"
								 +  "		</td>"
								 + 	"	</tr>"
								 +	"</table>";
								
							
						} // end of if(resultDate <= json[i].startdate) -----
						
					} // end of for(var i=0; i<json.length; i++) -----
					
					$("div#recommend_position").html(html);
					
				} // end of if(json.length > 0) -----
				else {
					
					html += "<table class='col-lg-6'>"
						 +	"	<tr>"
						 +	"		<td>추천챌린지가 없습니다.</td>"
						 +	"		<td>"
						 +  "			<div>직접 챌린지를 만들어보는 것은 어떤가요?</div>"
						 +	"			<button type='button' onclick=''>챌린지 개설하러 가기</button>"
						 +  "		</td>"
						 +	"		<td>"
						 +  "			<div>관심 태그를 더 추가해보시겠어요?</div>"
						 +	"			<button type='button' onclick='location.href=mypageInfoEdit'>정보 수정하러 가기</button>"
						 +  "		</td>"
						 + 	"	</tr>"
						 +	"</table>";
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		<%-- 챌린지 추천하기 끝 --%>

		
		
		
	}); // end of document.ready -----
	
	function tag_sort(code){
		
		// 글씨 색 변화주기 시작
		const nonClick = document.querySelectorAll(".tag_sort");

		function handleClick(event) {
		  nonClick.forEach((e) => {
		    e.classList.remove("change_tag_sort");
		  });
		  // 클릭한 div만 "click"클래스 추가
		  event.target.classList.add("change_tag_sort");
		}

		nonClick.forEach((e) => {
		  e.addEventListener("click", handleClick);
		});
		// 글씨 색 변화주기 끝
		
		$.ajax ({
			url:"/mypage/mypage_challenging_ajax",
			type:"GET",
			data:{
				"userid":"jisu",
				"fk_category_code":code
			},
			dataType:"json",
			success:function(json){
				
				// console.log(JSON.stringify(json));
			
				if(code == 0) {
					
					// 참가중인 챌린지
					let ing_cnt = 0; 
					
					for(var i=0; i<json.length; i++) {
						
						if(resultToday <= json[i].finish_day) {
							ing_cnt++;
						}
						
					}
					
					$("div#during_position").html(ing_cnt);
					
					// 완료된 챌린지
					let fin_cnt = 0;  // 완료된 챌린지 수 세기
					
					for(var i=0; i<json.length; i++) {
						
						if(resultToday > json[i].finish_day) {
							fin_cnt++;
						}
						
					}
					
					$("div#finish_position").html(fin_cnt);
					
					// 개설한 챌린지 수
					let fk_cnt = 0;
					
					for(var i=0; i<json.length; i++) {
						
						if( "jisu" == json[i].fk_userid) {    // 로그인기능 만들어지면 로그인한 상대로 변경해주기
							fk_cnt++;
						}
						
					}
					
					$("div#make_position").html(fk_cnt);
					
					let html = "";
					
					let all_cnt = 0;
					
					if(json.length > 0){
						
						for(var i=0; i<json.length; i++) {
							
							if(resultToday < json[i].finish_day) {
								html += "<table class='col-lg-6 '>"
									 +  "	<tr>"
									 +  "		<td class='td_width_33'>"
									 +  "			<img class='img-fluid px-3 px-sm-4 mt-3 mb-4 cha_img' src='" + json[i].thumbnail + "' alt='챌린지이미지'>"
									 +  "		</td>"
									 +	"		<td>"
									 +	"			<div class='div_info'>" + json[i].challenge_name + "</div>"
									 +	" 			<div class='div_info'>참여기간: " + json[i].startdate + "~" + json[i].finish_day + "</div>"
									 +	"			<div class='div_info'>인증시간: " + json[i].hour_start + "~" + json[i].hour_end + "</div>"
									 +	" 			<div class='div_info'>시작일: " + json[i].startdate + "</div>"
									 +	" 			<div class='div_info'>개설자: " + json[i].fk_userid + "</div>"
									 +  " 		</td>"
									 +	"		<td>"
									 +	"			<div class='go_certify' onclick='location.href='#''>인증하러가기</div>"
									 +	"			<div class='go_board' onclick='location.href='#''>게시판가기</div>"
									 +  "		</td>"
									 +  "	</tr>"
									 +	"</table>";
								
								$("div#show_table").html(html);
								
								all_cnt++;
							}
						} // for(var i=0; i<json.length; i++) -----
						
						$("input#all_cnt").val(all_cnt);
						
					} // end of if(json.length > 0) -----
					else {
						html = "<tr><td class='td_width_33'>참여중인 챌린지가 없습니다.</td></tr>"
						
						$("div#show_table").html(html);
					}
					
				} // end of if(cord == 0) -----
				else {
					
					let html = "";
					
					let ratio = (json.length/$("input#all_cnt").val())*100;
					
					html = "<div class='auto'>"
						 + "	<div class='user_level'>참여 비율</div>"
						 + "</div>"
						 + "<div class='col'>"
						 + "	<div class='progress progress-sm mr-2 bar_width'>"
						 + "		<div class='progress-bar bg-info' role='progressbar' style='width:" + ratio + "%;' aria-valuenow='50' aria-valuemin='0' aria-valuemax='100'></div>"
						 + "	</div>"
						 + "</div>"
						 + "<span>" + ratio + "%</span>";
						 
					$("div#show_ratio").html(html); 
					
					if(json.length > 0){
						
						html = "";
							 
						for(var i=0; i<json.length; i++) {
							
							if(resultToday < json[i].finish_day) {
							
								html  += "<table class='col-lg-6 '>"
									  +  "		<tr>"
									  +  "			<td class='td_width_33'>"
									  +  "				<img class='img-fluid px-3 px-sm-4 mt-3 mb-4 cha_img' src='" + json[i].thumbnail + "' alt='챌린지이미지'>"
								  	  +  "			</td>"
									  +	 "			<td>"
									  +  "				<div class='div_info'>" + json[i].challenge_name + "</div>"
									  +	 " 				<div class='div_info'>참여기간: " + json[i].startdate + "~" + json[i].finish_day + "</div>"
									  +	 "				<div class='div_info'>인증시간: " + json[i].hour_start + "~" + json[i].hour_end + "</div>"
									  +	 " 				<div class='div_info'>시작일: " + json[i].startdate + "</div>"
									  +	 " 				<div class='div_info'>개설자: " + json[i].fk_userid + "</div>"
									  +  " 			</td>"
									  +	 "			<td>"
									  +	 "				<div class='go_certify' onclick='location.href='#''>인증하러가기</div>"
									  +  "				<div class='go_board' onclick='location.href='#''>게시판가기</div>"
									  +  "			</td>"
									  +  "		</tr>"
									  +	 "</table>";
								
								$("div#show_table").html(html);
							} 
							else {
								html = "<tr><td class='td_width_33'>참여중인 챌린지가 없습니다.</td></tr>"
								
								$("div#show_table").html(html);
							}
						} // for(var i=0; i<json.length; i++) -----
						
					} // end of if(json.length > 0) -----
					else {
						html = "<tr><td class='td_width_33'>참여중인 챌린지가 없습니다.</td></tr>"
						
						$("div#show_table").html(html);
					}
				} // end of else -----
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		
		});
		
	} // end of function tag_sort(code) -----
	
	
</script>

	<div id="mainPosition">
		<!-- index 상단 제목 시작 -->
 		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h3 mb-0 text-gray-800">진행중인 챌린지 현황</h1>
		</div>
		<!-- index 상단 제목 끝 -->
		
		<input type="hidden" id="all_cnt" />
		
		<!-- index 메인 시작 -->
		<div class="row">
		
			<!-- 참가중인챌린지 시작 -->
			<div class="col-xl-4 col-md-6 mb-4">
 				<div class="card border-left-primary shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">참가중</div>
								<div id="during_position" class="h5 mb-0 font-weight-bold text-gray-800"></div>
							</div>
							<div class="col-auto">
								<i class="fa-solid fa-person-running fa-2xl menu_icon" style="color: #f43630;"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 참가중인챌린지 끝 -->

			<!-- 완료된 챌린지 시작 -->
			<div class="col-xl-4 col-md-6 mb-4">
				<div class="card border-left-success shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-xs font-weight-bold text-success text-uppercase mb-1">완료</div>
								<div id="finish_position" class="h5 mb-0 font-weight-bold text-gray-800"></div>
							</div>
							<div class="col-auto">
								<i class="fa-solid fa-child-reaching fa-2xl menu_icon" style="color: #f43630;"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 완료된 챌린지 끝 -->
			
			<!-- 개설한 챌린지 시작 -->
			<div class="col-xl-4 col-md-6 mb-4">
				<div class="card border-left-success shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-xs font-weight-bold text-info text-uppercase mb-1">개설한 챌린지</div>
								<div id="make_position" class="h5 mb-0 font-weight-bold text-gray-800"></div>
							</div>
							<div class="col-auto">
								<i class="fa-solid fa-handshake fa-2xl menu_icon" style="color: #f43630;"></i>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 개설한 챌린지 끝 -->
           </div>
           
			<!-- 참여하고 있는 챌린지 시작 -->
			<div class="row mb-4">
				<div class="col-lg-12 mb-8">
					<div id="notice" class="card shadow mb-8">
						<div class="card-header py-3">
							<h5 class="m-0 font-weight-bold">참여하고 있는 챌린지</h5>
							<form>
								<table style="width:95%;">
									<tr>
										<td class="tag_sort" onclick="tag_sort(1)">
											<i class="fa-solid fa-book fa-xl menu_icon" style="color: #c8632d;"></i>
										문화·예술</td>
										<td class="tag_sort" onclick="tag_sort(2)">
											<i class="fa-solid fa-dumbbell fa-xl menu_icon" style="color: black;"></i>
										운동·액티비티</td>							
										<td class="tag_sort" onclick="tag_sort(3)">
											<i class="fa-solid fa-utensils fa-xl menu_icon" style="color: #8cddee;"></i>
										푸드·드링크</td>
										<td class="tag_sort" onclick="tag_sort(4)">
											<i class="fa-solid fa-palette fa-xl menu_icon" style="color: #f7da45;"></i>
										취미</td>
										<td class="tag_sort" onclick="tag_sort(5)">
											<i class="fa-solid fa-truck-plane fa-xl menu_icon" style="color: #3830ab;"></i>
										여행·동행</td>
										<td class="tag_sort" onclick="tag_sort(6)">
											<i class="fa-solid fa-arrow-trend-up fa-xl menu_icon" style="color: #f43630;"></i>
										성장·자기계발</td>
										<td class="tag_sort" onclick="tag_sort(7)">
											<i class="fa-solid fa-user-group fa-xl menu_icon" style="color: black;"></i>
										동네·또래</td>
										<td class="tag_sort" onclick="tag_sort(8)">
											<i class="fa-solid fa-martini-glass-citrus fa-xl menu_icon" style="color: #959720;"></i>
										연애·소개팅</td>
									</tr>
								</table>
							</form>
 						</div>
						<div class="card-body card_body_style">
							<div id="show_ratio" class="row no-gutters align-items-center">
							
							</div>
							<div id="show_table" class="row"></div>
							  
						</div>
					</div>
				</div>
			</div>
			<!-- 참여하고 있는 챌린지 끝 -->

			<!-- 새로운 챌린지 추천 시작 -->
			<div class="row">
				<div class="col-lg-12 mb-8">
					<div id="notice" class="card shadow mb-8">
						<div class="card-header py-3">
							<h5 class="m-0 font-weight-bold">새로운 챌린지 추천</h5>
 						</div>
 						<form >
							<div id="recommend_position" class="row card-body">
							
								  
							
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- 새로운 챌린지 추천 끝 -->
			
			
			
		</div>
		<!-- 메인 끝 -->


</body>
</html> 
