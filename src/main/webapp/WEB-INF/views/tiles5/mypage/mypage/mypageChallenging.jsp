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
	
	.font_weight {
		font-weight: bold;
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
	
	td.td_width_36 {
		width: 36%;
	}
	
	div.go_button {
		color: black;
		font-size: 14pt;
		font-weight: bold;
		margin: 10px 0;
		text-align: center;
		cursor: pointer;
	}
	
	div.go_button:hover {
		color: #f43630;
	}
	
	table.no_challenging {
		margin: 3% 0 3% 43%;
	}
	
	div.div_info {
		margin: 8px 0;
		font-size: 13pt;
	}
	
	div.div_title {
		font-size: 15pt;
		font-weight: bold;
		margin-bottom: 8%;
	}
	
	td.td_width_22 {
		width: 22%;
	}
	
	div.ratio_width {
		width: 41%;
	}
	
	table.table_margin {
		margin: 1% 0;
	}
	
	div.click_show {
		cursor: pointer;
	}
	
	button.go_button_style {
		margin: 10% 14% 0 14%;
		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 5% 6%;
		text-align: center;
		transition: 0.3s;
		border-radius: 35px;
	}
	
	button.go_button_style:hover {
		background-color: #f43630;
		color: white;
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

	let show_challenging_flag = false;
	let show_finish_flag = false;
	let show_create_flag = false;

	$(document).ready(function(){
		
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
		
		<%-- 챌린지 갯수 불러오기 시작 --%>
		$.ajax ({
			url:"/mypage/mypage_challenging_ajax",
			type:"GET",
			data:{
				"userid":"${requestScope.userid}",
				"fk_category_code":"0"
			},
			dataType:"json",
			success:function(json){
				
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
					
					if( "${requestScope.userid}" == json[i].fk_userid) {    // 로그인기능 만들어지면 로그인한 상대로 변경해주기
						fk_cnt++;
					}
					
				}
				
				$("div#make_position").html(fk_cnt);
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		<%-- 챌린지 갯수 불러오기 끝 --%>

		
		
		
	}); // end of document.ready -----
	
	function show_challenging(code){
		// 참여중인 챌린지 보여주기
		$.ajax ({
			url:"/mypage/mypage_challenging_ajax",
			type:"GET",
			data:{
				"userid":"${requestScope.userid}",
				"fk_category_code":code
			},
			dataType:"json",
			success:function(json){
				
				// console.log(JSON.stringify(json));
			
				$("div#show_challenging_table").html("");
				$("div#show_challenging_ratio").html("");
				
				if(code == 0) {
					
					if(!show_challenging_flag) {
						
						$("div#show_challenging_form").slideDown('fast');
						
						show_challenging_flag = true;
						
					}
					
					else if(show_challenging_flag) {
						
						$("div#show_challenging_form").slideUp('fast');
						
						show_challenging_flag = false;
						
					}
					
					let html = "";
					
					let all_cnt = 0; // 참여 비율을 알기 위한 count
					
					let count = 0; // 챌린지가 모두 끝나서 없는 것인지, 참여한 챌린지가 과거에도 현재에도 없는지 판단하기 위한 count
					
					if(json.length > 0){
						
						for(var i=0; i<json.length; i++) {
							
							if(resultToday <= json[i].finish_day) {
								// 끝난 챌린지가 아닐 경우
								html += "<table class='col-lg-6 table_margin'>"
									 +  "	<tr>"
									 +  "		<td class='td_width_36'>"
									 +  "			<img class='img-fluid px-3 px-sm-4 mt-3 mb-4 cha_img' src='<%=ctxPath%>/images/" + json[i].thumbnail + "' alt='챌린지이미지'>"
									 +  "		</td>"
									 +	"		<td>"
									 +	"			<div class='div_title'>" + json[i].challenge_name + " 챌린지</div>"
									 +	" 			<div class='div_info'>참여기간 : " + json[i].startdate + " ~ " + json[i].finish_day + "</div>"
									 +	"			<div class='div_info'>인증시간 : " + json[i].hour_start + " ~ " + json[i].hour_end + "</div>"
									 +  " 		</td>"
									 +	"		<td class='td_width_22'>"
									 +	"			<div type='button' class='go_button' onclick='go_certify(" +json[i].fk_challenge_code ");'>인증하러가기</div>"
									 +  "		</td>"
									 +  "	</tr>"
									 +	"</table>";
								
								all_cnt++;
								
							} // if(resultToday <= json[i].finish_day) -----
							else {
								// 끝난 챌린지의 경우
								count++;
							}
							
						} // for(var i=0; i<challenge.length; i++) -----
						
						if(count == json.length) {
							// tbl_challenge_info 에 있는 모든 챌린지가 끝난 챌린지일 경우
							html = "<table class='no_challenging'>"
								 + "	<tr>"
								 + "		<td>참여중인 챌린지가 없습니다.</td>"
								 + "	</tr>"
								 + "	<tr>"
								 + "		<td><button type='button' class='go_button_style' onclick='go_challenge();'>챌린지보러가기</button></td>"
								 + "	</tr>"
								 + "</table>";
						}
						
						$("input#ing_cnt").val(all_cnt);
						
					} // end of if(challenge.length > 0) -----
					else {
						html = "<table class='no_challenging'>"
							 + "	<tr>"
							 + "		<td>참여중인 챌린지가 없습니다.</td>"
							 + "	</tr>"
							 + "	<tr>"
							 + "		<td><button type='button' class='go_button_style' onclick='go_challenge();'>챌린지보러가기</button></td>"
							 + "	</tr>"
							 + "</table>";
						
					}
					
					$("div#show_challenging_table").html(html);
					
				} // end of if(cord == 0) -----
				else {
					
					let html = "<table class='no_challenging'>"
						 	+ "		<tr>"
							 + "		<td>참여중인 챌린지가 없습니다.</td>"
							 + "	</tr>"
							 + "	<tr>"
							 + "		<td><button type='button' class='go_button_style' onclick='go_challenge();'>챌린지보러가기</button></td>"
							 + "	</tr>"
							 + "</table>";
					
					$("div#show_challenging_table").html(html);
					
					html = "";
					
					let ing_cnt = 0; // 참여 비율을 알기 위한 count
					
					let count = 0; // 챌린지가 모두 끝나서 없는 것인지, 참여한 챌린지가 과거에도 현재에도 없는지 판단하기 위한 count
					
					if(json.length > 0){
						
						for(var i=0; i<json.length; i++) {
							
							if(resultToday <= json[i].finish_day) {
							
								html  += "<table class='col-lg-6 table_margin'>"
									  +  "		<tr>"
									  +  "			<td class='td_width_36'>"
									  +  "				<img class='img-fluid px-3 px-sm-4 mt-3 mb-4 cha_img' src='<%=ctxPath%>/images/" + json[i].thumbnail + "' alt='챌린지이미지'>"
								  	  +  "			</td>"
									  +	 "			<td>"
									  +  "				<div class='div_title'>" + json[i].challenge_name + "</div>"
									  +	 " 				<div class='div_info'>참여기간 : " + json[i].startdate + " ~ " + json[i].finish_day + "</div>"
									  +	 "				<div class='div_info'>인증시간 : " + json[i].hour_start + " ~ " + json[i].hour_end + "</div>"
									  +  " 			</td>"
									  +	 "			<td class='td_width_22'>"
									  +	 "				<div class='go_button' onclick='go_certify();'>인증하러가기</div>"
									  +  "			</td>"
									  +  "		</tr>"
									  +	 "</table>";
									  
								ing_cnt++; 
								
							} // if(resultToday < json[i].finish_day) -----
							else {
								count++;
							}	
							
						} // for(var i=0; i<challenge.length; i++) -----
						
						if(count == json.length) {
							
							html = "<table class='no_challenging'>"
								 + "	<tr>"
								 + "		<td>참여중인 챌린지가 없습니다.</td>"
								 + "	</tr>"
								 + "	<tr>"
								 + "		<td><button type='button' class='go_button_style' onclick='go_challenge();'>챌린지보러가기</button></td>"
								 + "	</tr>"
								 + "</table>";
						}
						
						$("div#show_challenging_table").html(html);
						
						html = "";
						
						let ratio = (ing_cnt/$("input#ing_cnt").val())*100;
						
						let roundNum = Math.round(ratio * 10) / 10;
						
						html = "<div class='auto'>"
							 + "	<div class='user_level'>참여 비율</div>"
							 + "</div>"
							 + "<div class='col'>"
							 + "	<div class='progress progress-sm mr-2 bar_width'>"
							 + "		<div class='progress-bar bg-info' role='progressbar' style='width:" + roundNum + "%;' aria-valuenow='50' aria-valuemin='0' aria-valuemax='100'></div>"
							 + "	</div>"
							 + "</div>"
							 + "<span>" + roundNum + "%</span>";
							 
						$("div#show_challenging_ratio").html(html);
						
					} // end of if(challenge.length > 0) -----
					else {
						
						html = "<div class='auto'>"
							 + "	<div class='user_level'>참여 비율</div>"
							 + "</div>"
							 + "<div class='col'>"
							 + "	<div class='progress progress-sm mr-2 bar_width'>"
							 + "		<div class='progress-bar bg-info' role='progressbar' style='width:0%;' aria-valuenow='50' aria-valuemin='0' aria-valuemax='100'></div>"
							 + "	</div>"
							 + "</div>"
							 + "<span>0%</span>";
							 
						$("div#show_challenging_ratio").html(html);
						
					} // end of else -----
					
				} // end of else -----
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		
		});
		
	} // end of function show_challenging(code) -----
	
	function show_finish(code){
		// 끝난 챌린지 보여주기
		$.ajax ({
			url:"/mypage/mypage_challenging_ajax",
			type:"GET",
			data:{
				"userid":"${requestScope.userid}",
				"fk_category_code":code
			},
			dataType:"json",
			success:function(json){
				
				// console.log(JSON.stringify(json));
				
				$("div#show_finish_table").html("");
				$("div#show_finish_ratio").html("");
				
				if(code == 0) {
					
					if(!show_finish_flag) {
						
						$("div#show_finish_form").slideDown('fast');
						
						show_finish_flag = true;
						
					}
					
					else if(show_finish_flag) {
						
						$("div#show_finish_form").slideUp('fast');
						
						show_finish_flag = false;
						
					}
					
					let html = "";
					
					let all_cnt = 0; // 참여 비율을 알기 위한 count
					
					let count = 0; // 챌린지가 모두 끝나서 없는 것인지, 참여한 챌린지가 과거에도 현재에도 없는지 판단하기 위한 count
					
					if(json.length > 0){
						
						for(var i=0; i<json.length; i++) {
							
							if(resultToday > json[i].finish_day) {
								
								html += "<table class='col-lg-6 table_margin'>"
									 +  "	<tr>"
									 +  "		<td class='td_width_36'>"
									 +  "			<img class='img-fluid px-3 px-sm-4 mt-3 mb-4 cha_img' src='<%=ctxPath%>/images/" + json[i].thumbnail + "' alt='챌린지이미지'>"
									 +  "		</td>"
									 +	"		<td>"
									 +	"			<div class='div_title'>" + json[i].challenge_name + " 챌린지</div>"
									 +	" 			<div class='div_info'>참여기간: " + json[i].startdate + " ~ " + json[i].finish_day + "</div>"
									 +	" 			<div class='div_info'>달성률: " + json[i].achievement_pct + "%</div>"
									 +  " 		</td>"
									 +	"		<td class='td_width_22'>"
									 +	"			<div class='go_button' onclick='go_lounge();'>후기쓰러가기</div>"
									 +  "		</td>"
									 +  "	</tr>"
									 +  "</table>";
							
								all_cnt++;
								
							} // end of if(resultToday > json[i].finish_day) -----
							else {

								count++;
								
							}
							
						} // end of for(var i=0; i<json.length; i++) -----
						
						if(count == json.length) {
							// tbl_challenge_info 테이블에 챌린지가 존재하나, 모두 진행중일 경우
							html = "<table class='no_challenging'><tr><td>완료된 챌린지가 없습니다.</td></tr></table>"
							
						}
						$("input#fin_cnt").val(all_cnt);
						
					} // end of if(json.length > 0) -----
					else {
						
						html = "<table class='no_challenging'><tr><td>완료된 챌린지가 없습니다.</td></tr></table>"
						
					}
					
					$("div#show_finish_table").html(html);
					
				} // end of if(cord == 0) -----
				else {
					
					let html = "";
					
					$("div#show_finish_table").html("<table class='no_challenging'><tr><td>완료된 챌린지가 없습니다.</table></td></tr>");
					
					if(json.length > 0){
						
						let fin_cnt = 0;
							 
						for(var i=0; i<json.length; i++) {
							
							if(resultToday > json[i].finish_day) {
								
								html += "<table class='col-lg-6 table_margin'>"
									 +	"	<tr>"
									 +  "		<td class='td_width_36'>"
									 +  "			<img class='img-fluid px-3 px-sm-4 mt-3 mb-4 cha_img' src='<%=ctxPath%>/images/" + json[i].thumbnail + "' alt='챌린지이미지'>"
									 +  "		</td>"
									 +	"		<td>"
									 +	"			<div class='div_title'>" + json[i].challenge_name + " 챌린지</div>"
									 +	" 			<div class='div_info'>참여기간: " + json[i].startdate + " ~ " + json[i].finish_day + "</div>"
									 +	" 			<div class='div_info'>달성률: " + json[i].achievement_pct + "%</div>"
									 +  " 		</td>"
									 +	"		<td class='td_width_22'>"
									 +	"			<div class='go_button' onclick='go_lounge();'>후기쓰러가기</div>"
									 +  "		</td>"
									 +  "	</tr>"
									 +	"</table>";
							
								$("div#show_finish_table").html(html);
								
								fin_cnt++;
								
							} // end of if(resultToday > json[i].finish_day) -----
							
						} // for(var i=0; i<json.length; i++) -----
						
						html = "";
						
						let ratio = (fin_cnt/$("input#fin_cnt").val())*100;
						
						let roundNum = Math.round(ratio * 10) / 10;
						
						html = "<div class='auto'>"
							 + "	<div class='user_level'>참여 비율</div>"
							 + "</div>"
							 + "<div class='col'>"
							 + "	<div class='progress progress-sm mr-2 bar_width'>"
							 + "		<div class='progress-bar bg-info' role='progressbar' style='width:" + roundNum + "%;' aria-valuenow='50' aria-valuemin='0' aria-valuemax='100'></div>"
							 + "	</div>"
							 + "</div>"
							 + "<span>" + roundNum + "%</span>";
							 
						$("div#show_finish_ratio").html(html); 
						
					} // end of if(json.length > 0) -----
					else {
						
						html = "<div class='auto'>"
							 + "	<div class='user_level'>참여 비율</div>"
							 + "</div>"
							 + "<div class='col'>"
							 + "	<div class='progress progress-sm mr-2 bar_width'>"
							 + "		<div class='progress-bar bg-info' role='progressbar' style='width:0%;' aria-valuenow='50' aria-valuemin='0' aria-valuemax='100'></div>"
							 + "	</div>"
							 + "</div>"
							 + "<span>0%</span>";
							 
						$("div#show_finish_ratio").html(html);
						
					}
					
				} // end of else -----
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		
		});
	    
	} // end of function show_finish(code) -----
	
	function show_create(code) {
		// 개설한 챌린지 보러가기
		$.ajax ({
			url:"/mypage/mypage_challenging_ajax",
			type:"GET",
			data:{
				"userid":"${requestScope.userid}",
				"fk_category_code":code
			},
			dataType:"json",
			success:function(json){
				
				// console.log(JSON.stringify(json));
				
				$("div#show_create_table").html("");
				$("div#show_create_ratio").html("");
				
				if(code == 0) {
					
					if(!show_create_flag) {
						
						$("div#show_create_form").slideDown('fast');
						
						show_create_flag = true;
						
					}
					
					else if(show_create_flag) {
						
						$("div#show_create_form").slideUp('fast');
						
						show_create_flag = false;
						
					}
					
					let html = "";
					
					if(json.length > 0){
						
						for(var i=0; i<json.length; i++) {
							
							if('admin4' == json[i].fk_userid) {
								
								if(resultToday > json[i].finish_day) {
									// 끝난 챌린지
									html += "<table class='col-lg-6 table_margin'>"
										 +  "	<tr>"
										 +  "		<td class='td_width_36'>"
										 +  "			<img class='img-fluid px-3 px-sm-4 mt-3 mb-4 cha_img' src='<%=ctxPath%>/images/" + json[i].thumbnail + "' alt='챌린지이미지'>"
										 +  "		</td>"
										 +	"		<td>"
										 +	"			<div class='div_title'>" + json[i].challenge_name + "</div>"
										 +	" 			<div class='div_info'>참여기간: " + json[i].startdate + "~" + json[i].finish_day + "</div>"
										 +	" 			<div class='div_info'>시작일: " + json[i].startdate + "</div>"
										 +	" 			<div class='div_info'>개설자: " + json[i].fk_userid + "</div>"
										 +  " 		</td>"
										 +	"		<td class='td_width_22'>"
										 +	"			<div class='go_button' onclick='go_lounge();'>후기쓰러가기</div>"
										 +  "		</td>"
										 +  "	</tr>"
										 +	"</table>";
								}
								else {
									// 진행중인 챌린지
									html += "<table class='col-lg-6 table_margin'>"
										 +	"	<tr>"
										 +  "		<td class='td_width_36'>"
										 +  "			<img class='img-fluid px-3 px-sm-4 mt-3 mb-4 cha_img' src='<%=ctxPath%>/images/" + json[i].thumbnail + "' alt='챌린지이미지'>"
										 +  "		</td>"
										 +	"		<td>"
										 +	"			<div class='div_title'>" + json[i].challenge_name + "</div>"
										 +	" 			<div class='div_info'>참여기간: " + json[i].startdate + "~" + json[i].finish_day + "</div>"
										 +	"			<div class='div_info'>인증시간: " + json[i].hour_start + "~" + json[i].hour_end + "</div>"
										 +  " 		</td>"
										 +	"		<td class='td_width_22'>"
										 +	"			<div class='go_button' onclick='go_certify();'>인증하러가기</div>"
										 +  "		</td>"
										 +  "	</tr>"
										 +	"</table>";
									
								}
								
								$("div#show_create_table").html(html);
								
							} 
							
							else {
								html = "<table class='no_challenging'>"
									 + "	<tr>"
									 + "		<td>개설한 챌린지가 없습니다.</td>"
									 + "	</tr>"
									 + "	<tr>"
									 + "		<td><button type='button' class='go_button_style' onclick='go_create();'>개설하러가기</button></td>"
									 + "	</tr>"	
									 + "</table>"
								
								$("div#show_create_table").html(html);
							}
							
						} // for(var i=0; i<json.length; i++) -----
						
					} // end of if(json.length > 0) -----
					else {
						html = "<table class='no_challenging'>"
							 + "	<tr>"
							 + "		<td>개설한 챌린지가 없습니다.</td>"
							 + "	</tr>"
							 + "	<tr>"
							 + "		<td><button type='button' class='go_button_style' onclick='go_create();'>개설하러가기</button></td>"
							 + "	</tr>"	
							 + "</table>"
						
						$("div#show_create_table").html(html);
					}
				} // end of if(cord == 0) -----
				else {
					
					let html = "<table class='no_challenging'>"
							 + "	<tr>"
							 + "		<td>개설한 챌린지가 없습니다.</td>"
							 + "	</tr>"
							 + "	<tr>"
							 + "		<td><div class='go_button_style' onclick='go_create();'>개설하러가기</button></td>"
							 + "	</tr>"	
							 + "</table>";
					
					$("div#show_create_table").html(html);
					
					html = "";
					
					if(json.length > 0){
						
						for(var i=0; i<json.length; i++) {
							
							if('admin4' == json[i].fk_userid) {
								
								if(resultToday > json[i].finish_day) {
									// 끝난 챌린지
									html += "<table class='col-lg-6 table_margin'>"
										 +  "	<tr>"
										 +  "		<td class='td_width_36'>"
										 +  "			<img class='img-fluid px-3 px-sm-4 mt-3 mb-4 cha_img' src='<%=ctxPath%>/images/" + json[i].thumbnail + "' alt='챌린지이미지'>"
										 +  "		</td>"
										 +	"		<td>"
										 +	"			<div class='div_title'>" + json[i].challenge_name + "</div>"
										 +	" 			<div class='div_info'>참여기간: " + json[i].startdate + "~" + json[i].finish_day + "</div>"
										 +	" 			<div class='div_info'>시작일: " + json[i].startdate + "</div>"
										 +	" 			<div class='div_info'>개설자: " + json[i].fk_userid + "</div>"
										 +  " 		</td>"
										 +	"		<td class='td_width_22'>"
										 +	"			<div class='go_button' onclick='go_lounge();'>후기쓰러가기</div>"
										 +  "		</td>"
										 +  "	</tr>"
										 +	"</table>";
								}
								else {
									// 진행중인 챌린지
									html += "<table class='col-lg-6 table_margin'>"
										 +	"	<tr>"
										 +  "		<td class='td_width_36'>"
										 +  "			<img class='img-fluid px-3 px-sm-4 mt-3 mb-4 cha_img' src='<%=ctxPath%>/images/" + json[i].thumbnail + "' alt='챌린지이미지'>"
										 +  "		</td>"
										 +	"		<td>"
										 +	"			<div class='div_title'>" + json[i].challenge_name + "</div>"
										 +	" 			<div class='div_info'>참여기간: " + json[i].startdate + "~" + json[i].finish_day + "</div>"
										 +	"			<div class='div_info'>인증시간: " + json[i].hour_start + "~" + json[i].hour_end + "</div>"
										 +  " 		</td>"
										 +	"		<td class='td_width_22'>"
										 +	"			<div class='go_button' onclick='go_certify();'>인증하러가기</div>"
										 +  "		</td>"
										 +  "	</tr>"
										 +	"</table>";
								}
								
								$("div#show_create_table").html(html);
								
							} 
							
						} // for(var i=0; i<json.length; i++) -----
						
					} // end of if(json.length > 0) -----
					
				} // end of else -----
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		
		});
		
	} // end of function show_create(code) -----
	
	function go_challenge() {
		
		location.href = "/challenge/challenge_all";
		
	} // end of function go_challenge() {} -----
	
	function go_create() {
		
		location.href = "/challenge/add_challenge";
		
	} // end of function go_create() -----
	
	function go_certify(e) {
    
		location.href = "<%=ctxPath%>/challenge/certify?challenge_code=e";
		
	} // end of function go_certify() -----
	
	function go_lounge() {
		
		location.href = "/lounge/loungeAdd";
		
	} // end of function go_lounge() -----
	
</script>

	<div id="mainPosition">
		<!-- index 상단 제목 시작 -->
 		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h3 mb-0 text-gray-800 font_weight">진행중인 챌린지 현황</h1>
		</div>
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h5 class="mb-0 text-gray-800 text-danger">항목을 선택해주세요.</h5>
		</div>
		<!-- index 상단 제목 끝 -->
		
		<input type="hidden" id="ing_cnt" />
		<input type="hidden" id="fin_cnt" />
		
		<!-- index 메인 시작 -->
		<div class="row">
		
			<!-- 참가중인챌린지 시작 -->
			<div class="col-xl-4 col-md-6 mb-4">
 				<div class="card border-left-primary shadow h-100 py-2">
					<div class="card-body">
						<div class="row no-gutters align-items-center click_show" onclick="show_challenging(0);">
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
						<div class="row no-gutters align-items-center click_show" onclick="show_finish(0);">
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
						<div class="row no-gutters align-items-center click_show" onclick="show_create(0);">
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
			<div id="show_challenging_form" class="row mb-4" style="display:none;">
				<div class="col-lg-12 mb-8">
					<div id="notice" class="card shadow mb-8">
						<div class="card-header py-3">
							<h5 class="m-0 font-weight-bold">참여하고 있는 챌린지</h5>
							<form>
								<table style="width:95%;">
									<tr>
										<td class="tag_sort" onclick="show_challenging(1)">
											<i class="fa-solid fa-book fa-xl menu_icon" style="color: #c8632d;"></i>
										문화·예술</td>
										<td class="tag_sort" onclick="show_challenging(2)">
											<i class="fa-solid fa-dumbbell fa-xl menu_icon" style="color: black;"></i>
										운동·액티비티</td>							
										<td class="tag_sort" onclick="show_challenging(3)">
											<i class="fa-solid fa-utensils fa-xl menu_icon" style="color: #8cddee;"></i>
										푸드·드링크</td>
										<td class="tag_sort" onclick="show_challenging(4)">
											<i class="fa-solid fa-palette fa-xl menu_icon" style="color: #f7da45;"></i>
										취미</td>
										<td class="tag_sort" onclick="show_challenging(5)">
											<i class="fa-solid fa-truck-plane fa-xl menu_icon" style="color: #3830ab;"></i>
										여행·동행</td>
										<td class="tag_sort" onclick="show_challenging(6)">
											<i class="fa-solid fa-arrow-trend-up fa-xl menu_icon" style="color: #f43630;"></i>
										성장·자기계발</td>
										<td class="tag_sort" onclick="show_challenging(7)">
											<i class="fa-solid fa-user-group fa-xl menu_icon" style="color: black;"></i>
										동네·또래</td>
										<td class="tag_sort" onclick="show_challenging(8)">
											<i class="fa-solid fa-martini-glass-citrus fa-xl menu_icon" style="color: #959720;"></i>
										연애·소개팅</td>
									</tr>
								</table>
							</form>
 						</div>
						<div class="card-body card_body_style">
							<div id="show_challenging_ratio" class="row no-gutters align-items-center ratio_width">
							
							</div>
							<div id="show_challenging_table" class="row card-body">
							
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 참여하고 있는 챌린지 끝 -->

			<!-- 두번째 문단 시작 -->
			<div id="show_finish_form" class="row mb-4" style="display:none;">
				<!-- 완료된 챌린지 시작 -->
				<div class="col-lg-12 mb-8">
					<div id="notice" class="card shadow mb-8">
						<div class="card-header py-3">
							<h5 class="m-0 font-weight-bold">완료된 챌린지</h5>
							<form>
								<table style="width:95%;">
									<tr>
										<td class="tag_sort" onclick="show_finish(1)">
											<i class="fa-solid fa-book fa-xl menu_icon" style="color: #c8632d;"></i>
										문화·예술</td>
										<td class="tag_sort" onclick="show_finish(2)">
											<i class="fa-solid fa-dumbbell fa-xl menu_icon" style="color: black;"></i>
										운동·액티비티</td>							
										<td class="tag_sort" onclick="show_finish(3)">
											<i class="fa-solid fa-utensils fa-xl menu_icon" style="color: #8cddee;"></i>
										푸드·드링크</td>
										<td class="tag_sort" onclick="show_finish(4)">
											<i class="fa-solid fa-palette fa-xl menu_icon" style="color: #f7da45;"></i>
										취미</td>
										<td class="tag_sort" onclick="show_finish(5)">
											<i class="fa-solid fa-truck-plane fa-xl menu_icon" style="color: #3830ab;"></i>
										여행·동행</td>
										<td class="tag_sort" onclick="show_finish(6)">
											<i class="fa-solid fa-arrow-trend-up fa-xl menu_icon" style="color: #f43630;"></i>
										성장·자기계발</td>
										<td class="tag_sort" onclick="show_finish(7)">
											<i class="fa-solid fa-user-group fa-xl menu_icon" style="color: black;"></i>
										동네·또래</td>
										<td class="tag_sort" onclick="show_finish(8)">
											<i class="fa-solid fa-martini-glass-citrus fa-xl menu_icon" style="color: #959720;"></i>
										연애·소개팅</td>
									</tr>
								</table>
							</form>
 						</div>
						<div class="card-body card_body_style">
							<div id="show_finish_ratio" class="row no-gutters align-items-center ratio_width">
							
							</div>
							<div id="show_finish_table" class="row card-body">
							
							</div>
						</div>
					</div>
				</div>
				</div>
				<!-- 완료된 챌린지 끝 -->
			
			<!-- 두번째 문단 시작 -->
			<div id="show_create_form" class="row mb-4" style="display:none;">
				<!-- 개설한 챌린지 시작 -->
				<div class="col-lg-12 mb-8">
					<div id="notice" class="card shadow mb-8">
						<div class="card-header py-3">
							<h5 class="m-0 font-weight-bold">개설한 챌린지</h5>
							<form>
								<table style="width:95%;">
									<tr>
										<td class="tag_sort" onclick="show_create(1)">
											<i class="fa-solid fa-book fa-xl menu_icon" style="color: #c8632d;"></i>
										문화·예술</td>
										<td class="tag_sort" onclick="show_create(2)">
											<i class="fa-solid fa-dumbbell fa-xl menu_icon" style="color: black;"></i>
										운동·액티비티</td>							
										<td class="tag_sort" onclick="show_create(3)">
											<i class="fa-solid fa-utensils fa-xl menu_icon" style="color: #8cddee;"></i>
										푸드·드링크</td>
										<td class="tag_sort" onclick="show_create(4)">
											<i class="fa-solid fa-palette fa-xl menu_icon" style="color: #f7da45;"></i>
										취미</td>
										<td class="tag_sort" onclick="show_create(5)">
											<i class="fa-solid fa-truck-plane fa-xl menu_icon" style="color: #3830ab;"></i>
										여행·동행</td>
										<td class="tag_sort" onclick="show_create(6)">
											<i class="fa-solid fa-arrow-trend-up fa-xl menu_icon" style="color: #f43630;"></i>
										성장·자기계발</td>
										<td class="tag_sort" onclick="show_create(7)">
											<i class="fa-solid fa-user-group fa-xl menu_icon" style="color: black;"></i>
										동네·또래</td>
										<td class="tag_sort" onclick="show_create(8)">
											<i class="fa-solid fa-martini-glass-citrus fa-xl menu_icon" style="color: #959720;"></i>
										연애·소개팅</td>
									</tr>
								</table>
							</form>
 						</div>
 						<div class="card-body card_body_style">
							<div id="show_create_table" class="row card-body">
							
							</div>
						</div>
					</div>
				</div>
				</div>
				<!-- 완료된 챌린지 끝 -->
			
			
		</div>
		<!-- 메인 끝 -->


</body>
</html> 
