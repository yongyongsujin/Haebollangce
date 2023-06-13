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
	
	img#promainimg {
		height: 103px;
		border-radius: 50%;
		margin-right: 2%;
		margin-left: 3%;
		width: 8%;
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
	
	div.card_padding {
		padding: 1.25rem 3rem;
	}
	
	button.go_detail {
		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 7px 12px;
		text-align: center;
		font-size: 13pt;
		transition: 0.3s;
		border-radius: 35px;
	}
	
	button.go_detail:hover {
		background-color: #f43630;
		color: white;
	}
	
	button#go_deposit,
	button#go_reward {
		width: 99px;
		height: 35px;
		border: none;
		border-radius: 40px;
		background-color: #e6e1e1;
		color: black;
		font-size: 10pt;
		font-weight: bold;
	}
	
	button#go_deposit:hover,
	button#go_reward:hover {
		background-color: #f43630;
		color: white;
	}
	
	td.td_width_25 {
		width: 25%;
	}
	
	td.td_width_30 {
		width: 30%;
	}
	
	td.td_width_33 {
		width: 33%;
	}
	
	td.no_identify {
		padding: 30% 31% 30% 36%;
	}
	
	span#span_userid {
		font-size: 15pt;
		margin-left: 1%;
		color: black;
	}
	
	div.font_size_18pt {
		font-size: 18pt;
	}
	
	div.bar_size {
		width: 31%;
		height: 20px;
	}
	
	div.bar_size_2 {
		width: 80%;
	}
	
	td.td_width_33 {
		width: 33%;
	}
	
	img.cha_img {
		border-radius: 20%;
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
	
	div.height_px_ide {
		height: 507px;
		overflow: auto;
	}
	
	div.height_px {
		height: 534px;
		overflow: auto;
	}
	
	/* 하이차트 css 시작 */
	.highcharts-figure,
	.highcharts-data-table table {
		min-width: 310px;
		max-width: 800px;
		margin: 1em auto;
	}

	#container {
		height: 400px;
	}

	.highcharts-data-table table {
		font-family: Verdana, sans-serif;
		border-collapse: collapse;
		border: 1px solid #ebebeb;
		margin: 10px auto;
		text-align: center;
		width: 100%;
		max-width: 500px;
	}

	.highcharts-data-table caption {
		padding: 1em 0;
		font-size: 1.2em;
		color: #555;
	}

	.highcharts-data-table th {
		font-weight: 600;
		padding: 0.5em;
	}

	.highcharts-data-table td,
	.highcharts-data-table th,
	.highcharts-data-table caption {
		padding: 0.5em;
	}

	.highcharts-data-table thead tr,
	.highcharts-data-table tr:nth-child(even) {
		background: #f8f8f8;
	}

	.highcharts-data-table tr:hover {
		background: #f1f7ff;
	}
	/* 하이차트 css 끝 */
	
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		
		// 7일전 알아오기 시작 //
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
		
		// 지금 시간 알아오기 시작 // 
		const now = new Date();	// 현재 날짜 및 시간
		const hour = now.getHours();
		const minutes = now.getMinutes();
		const seconds = now.getSeconds();
		const dayLabel = now.getDay();  // 요일
       
		const now_time = hour + ":" + minutes + ":" + seconds;
    	// 지금 시간 알아오기 끝 // 
    	
		<%-- 사용자 정보 가져오기 시작 --%>
		$.ajax ({
			url:"/mypage/user_information_ajax",
			type:"get",
			data:{
				"userid":"jisu"
			},
			dataType:"json",
			success:function(json){
				// console.log(JSON.stringify(json));
				
				let html = "";
				
				let level = "";
				
				for(var i=0; i<json.length; i++) {
					
					let exp = json[i].exp;
					
					html = "<div class='auto'>";
					 
					if(exp < 100) {
						html += "<div id='user_level' style='color:#996633'>Bronze</div>";
					}
					else if(exp >= 100 && exp < 300) { 
						html += "<div id='user_level' style='color:#b3b3b3'>Sliver</div>";
					}
					else if(exp >=300 && exp < 800) {
						html += "<div id='user_level' style='color:#e6e600'>Gold</div>";
					}
					else if(exp >=800 && exp < 1600) {
						html += "<div id='user_level' style='color:#0052cc'>Sapphire</div>";
					}
					else if(exp >=1600 && exp < 2800) {
						html += "<div id='user_level' style='color:#4d4d4d'>Diamond</div>";
					}
					else {
						html += "<div id='user_level' style='color:#ff0000'>Vip</div>";
					}
					 
					 html += "		</div>"
					 	  +  "		<div class='col'>"
					 	  + "			<div class='progress progress-sm mr-2 bar_size'>";
					 	  
				 	if(exp <= 100) {
						html += "<div class='progress-bar bg-info' role='progressbar' style='width:" + exp + "%;' aria-valuenow='50' aria-valuemin='0' aria-valuemax='100'>"
							 +	"<span>다음까지 남은 경험치: " + (100-exp) +"</span>"
							 +  "</div>";
					}
					else if(exp > 100 && exp <= 300) {  
						
						let exp_width = (exp/300)*100;
						
						html += "<div class='progress-bar bg-info' role='progressbar' style='width:" + exp_width + "%;' aria-valuenow='50' aria-valuemin='0' aria-valuemax='100'>"
							 +	"<span>다음까지 남은 경험치: " + (300-exp_width) +"</span>"
							 +  "</div>";
					}
					else if(exp > 300 && exp <= 800) {
						
						let exp_width = (exp/800)*100;
						
						html += "<div class='progress-bar bg-info' role='progressbar' style='width:" + exp_width + "%;' aria-valuenow='50' aria-valuemin='0' aria-valuemax='100'>"
						 	 +	"<span>다음까지 남은 경험치: " + (800-exp_width) +"</span>"
						 	 +  "</div>";
					}
					else if(exp > 800 && exp <= 1600) {
						
						let exp_width = (exp/1600)*100;
						
						html += "<div class='progress-bar bg-info' role='progressbar' style='width:" + exp_width + "%;' aria-valuenow='50' aria-valuemin='0' aria-valuemax='100'>"
							 +	"<span>다음까지 남은 경험치: " + (1600-exp_width) +"</span>"
					 	 	 +  "</div>";
					}
					else if(exp > 1600 && exp <= 2800) {
						
						let exp_width = (exp/2800)*100;
						
						html += "<div class='progress-bar bg-info' role='progressbar' style='width:" + exp_width + "%;' aria-valuenow='50' aria-valuemin='0' aria-valuemax='100'>"
							 +	"<span>다음까지 남은 경험치: " + (2800-exp_width) +"</span>"
				 	 	 	 +  "</div>";
					}
					else {
						
						let exp_width = (exp/5000)*100;
						
						html += "<div class='progress-bar bg-info' role='progressbar' style='width:" + exp_width + "%;' aria-valuenow='50' aria-valuemin='0' aria-valuemax='100'></div>";
					}	  
					 	  
					html += "		</div>"
					 	 + "</div>";
				
					$("div#info_position").html(html);	
				
					html = json[i].user_all_deposit + " 원";
					
					$("div#deposit_position").html(html);
					
					html = json[i].user_all_reward + " 원";
					
					$("div#reward_position").html(html);
				}
				 
					 
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
		<%-- 사용자 정보 가져오기 끝 --%>
		
		
		<%-- 100% 인증한 챌린지들 가지고 오기 시작 --%>
		$.ajax ({
			url : "/mypage/finish_100_ajax",
            type : "get",
            data: {
            	"userid":"jisu"
            },
            dataType:"json",
            success:function(json){
              
            	// console.log("~~~ 확인용 : " + JSON.stringify(json));
                let html = "<div class='col-auto'>"
                		 + "	<div class='h5 mb-0 mr-3 font-weight-bold text-gray-800'>" + json.result + "%</div>"
                		 + "</div>"
                		 + "<div class='col'>"
                		 + "	<div class='progress progress-sm mr-2 bar_size_2'>"
                		 + "		<div class='progress-bar bg-info' role='progressbar' style='width:" + json.result + "%;' aria-valuenow='50' aria-valuemin='0' aria-valuemax='100'></div>"
                		 + "	</div>"
                		 + "</div>";
                		 
                $("div#certify_percent_position").html(html);
            	
            },
            error: function(request, status, error){
            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); 
		<%-- 100% 인증한 챌린지들 가지고 오기 끝 --%>
		
		
		<%-- 인증이 필요한 챌린지들 불러오기 시작 --%>
		$.ajax ({
			url : "/mypage/home_user_challenging_ajax",
            type : "get",
            data: {
            	"userid":"jisu"
            },
            dataType:"json",
            success:function(json){
              
            	// console.log("~~~ 확인용 : " + JSON.stringify(json));
                
				let html = "";
				
				if(json.length > 0) {
				 
            	   for(var i=0; i<json.length; i++) {

						if(resultToday <= json[i].finish_day && now_time >= json[i].hour_start && now_time <= json[i].hour_end) { 
            			   
							let freq = json[i].freq_type;
							// alert(freq);
							if( (freq == 100) 
									|| (freq == 101 && dayLabel != 0 && dayLabel != 6) 
									|| (freq == 102) && (dayLabel == 0 || dayLabel == 6) )  {
								
									html += "<tr>"
		               		        	 +  "	<td class='td_width_33'>"
		               		        	 +  "		<img class='img-fluid px-3 px-sm-4 mt-3 mb-4 cha_img'  src=" + json[i].thumbnail + " alt='챌린지이미지'>"
		               		        	 +  "	</td>"
		               		        	 +  "	<td>"
		               		        	 +	"		<div class='div_info div_title'>" + json[i].challenge_name + " 챌린지</div>"
		               		        	 +	"		<div class='div_info'>챌린지시작일자: " + json[i].startdate + "</div>"
		               		        	 +	"		<div class='div_info'>인증빈도: " + json[i].frequency + "</div>"
		               		        	 +	"		<div class='div_info'>인증시간: " + json[i].hour_start + " ~ " + json[i].hour_end + "</div>"
		               		        	 +	"	</td>"
		               		        	 +  "	<td><button type='button' class='go_detail' onclick='go_certify();'>인증하러가기</button></td>"
		               		        	 +  "</tr>";
								  	 
							}
		            		
               		        
            		   } // end of if(resultToday < json[i].finish_day) -----
            		   else {
							// json 은 있으나, 요일, 시간 등등이 안 맞을 경우
							html = "<tr><td class='no_identify'>인증이 필요한 챌린지가 없습니다.</td></tr>";
		                }
            		    
            	   } // end of for(var i=0; i<json.length; i++) -----
            	   
            	   $("table#show_identify").html(html);
            	   
               } // end of if(json.length > 0) -----
               else {
            	   
            	   html = "<tr><td class='td_width_33'>인증이 필요한 챌린지가 없습니다.</td></tr>";
            	   
            	   $("table#show_identify").html(html);
               }
                
            },
            error: function(request, status, error){
            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); 
		<%-- 인증이 필요한 챌린지들 불러오기 끝 --%>
		
		
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
							
							if(cnt > 3) {
								break;
							}
							
							html += "<tr>"
								 +	"	<td class='td_width_33'>"
								 +  "		<img class='img-fluid px-3 px-sm-4 mt-3 mb-4 cha_img' src='" + json[i].thumbnail + "' alt='챌린지이미지'>"
								 +	"	</td>"
								 +	"	<td>"
								 +	"		<div class='div_info div_title'>" + json[i].challenge_name + " 챌린지</div>"
								 +	"		<div class='div_info'>챌린지 시작일자 : " + json[i].startdate + "</div>"
								 +	"		<div class='div_info'>개설자 :" + json[i].fk_userid +"</div>"
								 +	"	</td>"
								 +	"	<td>"
								 +	"		<button type='button' class='go_detail' onclick='go_detail();'>상세보기</button>"
								 +  "	</td>"
								 + 	"</tr>";
								
							
						} // end of if(resultDate <= json[i].startdate) -----
						
					} // end of for(var i=0; i<json.length; i++) -----
					
					$("table#recommend_position").html(html);
					
				} // end of if(json.length > 0) -----
				
			},
			error: function(request, status, error){
				console.log("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		<%-- 챌린지 추천하기 끝 --%>
		
		
		<%-- 챌린지 그래프 시작 --%>
		$.ajax({
			url: "/mypage/chart_challenging",
			data:{
				"userid":"jisu"
			},
			dataType:"json",
			success:function(json1) {
				
				// console.log(JSON.stringify(json1));
				
				let month_challenging_arr = []; // 월별 참여한 챌린지
				
				$.each(json1, function(index, item){
					month_challenging_arr.push({
						 					name: item.month,
						 					y: Number(item.count),
		                 					drilldown: item.month
										});
				}); // end of $.each(json, function(index, item){}) -----
				
				let category_arr = []; // 참여한 챌린지별 태그 비율
				
				$.each(json1, function(index1, item1){
					
					$.ajax({
						url:"/mypage/chart_category",
						data:{
							"userid":"jisu",
							"month":item1.month
						},
						dataType:"json",
						success: function(json2){
							// 달 별 참여한 챌린지 태그 비율
							
							//console.log(JSON.stringify(json1));
							
							//console.log(item1.month +"  " + JSON.stringify(json2));
							
							let subArr = [];
							
							$.each(json2, function(index2, item2){
								subArr.push([item2.category_name,
				                        	 Number(item2.percentage)]);
							}); // end of $.each(json2, function(index2, item2){}) -----
							
							category_arr.push({
												name: item1.month,
					                			id: item1.month,
					                			data: subArr
											});
							
							Highcharts.chart('chart_container', {
							    chart: {
							        type: 'column'
							    },
							    title: {
							        align: 'left',
							        text: '올 해 챌린지 참여 횟수'
							    },
							    subtitle: {
							        align: 'left',
							        text: ''
							    },
							    accessibility: {
							        announceNewData: {
							            enabled: true
							        }
							    },
							    xAxis: {
							        type: 'category'
							    },
							    yAxis: {
							        title: {
							            text: '참여했던 챌린지 수(개)'
							        }

							    },
							    legend: {
							        enabled: false
							    },
							    plotOptions: {
							        series: {
							            borderWidth: 0,
							            dataLabels: {
							                enabled: true,
							                format: '{point.y}'
							            }
							        }
							    },

							    tooltip: {
							        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
							        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}</b> of total<br/>'
							    },

							    series: [
							        {
							            name: '챌린지명',
							            colorByPoint: true,
							            data:month_challenging_arr
							        }
							    ],
							    drilldown: {
							        breadcrumbs: {
							            position: {
							                align: 'right'
							            }
							        },
							        series: category_arr
							    }
							}); // end of chart
							////////////////////////
							
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		            }
				}); // end of ajax json2
				
			}); // end of each
						
			///////////////////////////////////////////////////////////////
			
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); // end of ajax
			
		<%-- 챌린지 그래프 끝 --%>
		
	}); // end of document.ready -----
	
	function go_certify() {
		
		location.href = "/challenge/certify"
		
	} // end of function go_certify() {} -----
	
	function go_detail() {
		
		location.href = "/challenge/certify"
		
	} // end of function go_detail() {} -----
	
</script>

	<div id="mainPosition">
		<div class="row">
			<div class="col-lg-12 mb-4" style="margin-bottom:41px;">
					<div class="card border-left-info shadow h-100 py-2">
						<div class="card-body">
							<div class="row no-gutters align-items-center ">
								 <img id='promainimg' alt='프로필사진' src='<%= ctxPath%>/images/${requestScope.udto.profilePic}'>
								<div class='col mr-2'>
						 			<div class='text-xs font-weight-bold text-info text-uppercase mb-1 font_size_18pt'>${requestScope.udto.name}<span id="span_userid">${requestScope.udto.userid}</span></div>
									<div id="info_position" class="row no-gutters align-items-center">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		
		
		<!-- index 메인 시작 -->
		<div class="row">
		
			<!-- 코인보유량 시작 -->
			<div class="col-lg-4 col-md-6 mb-4">
 				<div class="card border-left-primary shadow h-100 py-2">
					<div class="card-body card_padding">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">보유 예치금</div>
								<div id="deposit_position" class="h5 mb-0 font-weight-bold text-gray-800"></div>
							</div>
							<div class="col-auto">
								<button type="button" id="go_deposit" onClick="location.href='<%=ctxPath%>/mypage/depositPurchase'">
									<i class="fas fa-won-sign" style="color: #4b9156; margin-right: 7%;"></i>
									충전
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 코인보유량 끝 -->

			<!-- 보유상금 시작 -->
			<div class="col-lg-4 col-md-6 mb-4">
				<div class="card border-left-success shadow h-100 py-2">
					<div class="card-body card_padding">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-xs font-weight-bold text-success text-uppercase mb-1">보유 상금</div>
								<div id="reward_position" class="h5 mb-0 font-weight-bold text-gray-800"></div>
							</div>
							<div class="col-auto">
								<button type="button" id="go_reward" onClick="location.href='<%=ctxPath%>/mypage/change_reward'">
									<i class="fas fa-coins" style="color: #fff700; margin-right: 7%;"></i>
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
			<div class="col-lg-4 col-md-6 mb-4">
				<div class="card border-left-info shadow h-100 py-2">
					<div class="card-body card_padding">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-xs font-weight-bold text-info text-uppercase mb-1">100% 인증성공률</div>
   								<div id="certify_percent_position" class="row no-gutters align-items-center">
   								
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

			<!-- 알림 시작
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
			알림 끝 -->
           </div>
           
			<!-- 인증이 필요한 챌린지 시작 -->
			<div class="row">
				<div class="col-lg-6 mb-4">
					<div class="card shadow mb-4 height_px_ide">
						<div class="card-header py-3">
							<h5 class="m-0 font-weight-bold">인증이 필요한 챌린지</h5>
						</div>
						<div class="card-body">
							<div>
								<form>
									<table id="show_identify">
										
									</table>   
								</form>
							</div>
						</div>
					</div>
				</div>
				
				<div class="col-lg-6 mb-4 height_px">
					<div id="notice" class="card shadow mb-4">
						<div class="card-header py-3">
							<h5 class="m-0 font-weight-bold">새로운 챌린지 추천</h5>
 						</div>
						<div class="card-body">
							<form>
								<table id="recommend_position">
								
								</table>   
							</form>
						</div>
					</div>
				</div>
			</div>
			<!-- 인증이 필요한 챌린지 끝 -->

			<!-- 두번째문단 시작 -->
			<div class="row">
				<!-- 공지사항 시작 
				<div class="col-lg-4 mb-4">
					<div id="notice" class="card shadow mb-8">
						<div class="card-header py-3">
							<h5 class="m-0 font-weight-bold">공지사항</h5>
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
				공지사항 끝 -->
				
				<!-- 새로운 챌린지 추천 시작 
				<div class="col-lg-8 mb-4">
					<div id="notice" class="card shadow mb-8">
						<div class="card-header py-3">
							<h5 class="m-0 font-weight-bold">새로운 챌린지 추천</h5>
 						</div>
						<div class="card-body">
							<form>
								<table id="recommend_position">
								
								</table>   
							</form>
						</div>
					</div>
				</div>
				 새로운 챌린지 추천 끝 -->
			</div>
			<!-- 두번째문단 끝 -->
				
			<!-- 챌린지 리포트 시작-->
			<div class="row">
				<div class="col-lg-12 mb-8">
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h5 class="m-0 font-weight-bold">챌린지 리포트</h5>
						</div>
						<div class="card-body">
							<div id="chart_container" class="chart-bar">
							</div>
							<hr>
							올 해 챌린지 참여 횟수에는 진행중인 챌린지와 완료된 챌린지 모두 포함된 횟수입니다.
						</div>
					</div>
				</div>
			</div>
			<!-- 챌린지 리포트 끝 -->
			
		</div>
		<!-- 메인 끝 -->
		
</body>
</html> 
