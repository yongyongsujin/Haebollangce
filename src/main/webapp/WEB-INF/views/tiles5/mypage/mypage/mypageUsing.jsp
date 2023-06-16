<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%
    String ctxPath = request.getContextPath();
%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
    
<style type="text/css">
	div#mainPosition {
		margin: 99px 5% 0 5%;
	}
	
	button.go_button,
	button.add_button {
		width: 99px;
		height: 35px;
		border: none;
		border-radius: 40px;
		background-color: #e6e1e1;
		color: black;
		font-size: 10pt;
		font-weight: bold;
	}
	
	button#excel_button {
		float: right;
	}
	
	button.go_button:hover,
	button.add_button:hover {
		background-color: #f43630;
		color: white;
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
	
	tr.table_position {
		height: 77px;
		text-align: center;
		border-bottom: solid #aaaaaa 1px;
	}
	
	div#cal_position {
		margin: 10px 0 43px 0;
		padding: 0 70px;
	}
	
	td.tag_sort {
		cursor: pointer;
	}
	
	.blue_font {
		color: blue;
		font-size: 13pt;
	}
	
	.red_font {
		color: red;
		font-size: 13pt;
	}
	
	.font_bold {
		font-weight: bold;	
	}
	
	table#cancel_position {
		width: 100%;
	}
	
	td.cancel_td {
		padding: 0 10%;
		height: 42px;
		text-align: center;
	}
	
	td.no_data {
		text-align: center;
		height: 50px;
		padding: 29%;
	}
	
	td.purchase_date {
		text-align: center;
		width: 58%;
		height: 50px;
	}
	
	td.td_style {
		text-align: center;
		height: 30px;
	}
	
	.change_tag_sort {
		color: red;
		font-weight: bold;
	}
	
	table.table_tag_sort {
		width: 96%;
		margin-top: 30px;
	}
	
	div.height_px {
		height: 504px;
		overflow: auto;
	}
	
	div.height_px_2 {
		height: 458px;
		overflow: auto;
	}
	
	table#using_info {
		width: 100%;
		height: 164px;
		overflow: auto;
	}
	
	td.td_padding {
		padding: 30% 33%;
	}
	
	td.td_width_19 {
		width: 19%;
	}

	td.no_list {
		padding: 33%;
	}
	
	/* 차트 시작 */
	.highcharts-figure,
	.highcharts-data-table table {
	    min-width: 360px;
	    max-width: 800px;
	    margin: 1em auto;
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
	/* 차트 끌 */
	
</style>

<script type="text/javascript">

	// 날짜 시작
	// 1년전
	let year_date = new Date();
	
	let year_date_year = year_date.getFullYear() - 1;
	let year_date_month = year_date.getMonth() + 1;
	let year_date_day = year_date.getDate();
	
	if(year_date_month < 10) {year_date_month = "0" + year_date_month};
	if(year_date_day < 10) {year_date_day = "0" + year_date_day};
	
	let result_year = year_date_year + "-" + year_date_month + "-" + year_date_day;
	
	
	// 7일전
	let nowDate = new Date();
	let weekDate = nowDate.getTime() -(7*24*60*60*1000);
	nowDate.setTime(weekDate);
	
	let weekYear = nowDate.getFullYear() - 1;
	let weekMonth = nowDate.getMonth() + 1;
	let weekDay = nowDate.getDate();
	
	if(weekMonth < 10) {weekMonth = "0" + weekMonth};
	if(weekDay < 10) {weekDay = "0" + weekDay};
	
	let result_date = weekYear + "-" + weekMonth + "-" + weekDay;

	
	// 오늘 
	let today = new Date();
	
	let today_month = today.getDate() + 1;
	let today_day = today.getDate();
	
	// console.log("todayMonth: " + todayMonth);
	// console.log("todayDay: " + todayDay);
	
	if(today_month < 10) {today_month = "0" + today_month};
	if(today_day < 10) {today_day = "0" + today_day};
	
	let result_today = today.getFullYear() + "-" + today_month + "-" + today_day;
	// 날짜 끝

	$(document).ready(function(){
		
		<%-- 글씨 색 변화주기 시작 --%>
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
		<%-- 글씨 색 변화주기 끝 --%>
		
		<%-- 엑셀 버튼에 툴팁 넣어주기 시작 --%>
		$('[data-toggle="tooltip"]').tooltip();   
		<%-- 엑셀 버튼에 툴팁 넣어주기 끝 --%>
	
		<%-- 예치금 그래프 보여주기 시작 --%>
		$.ajax ({
			url:"/mypage/deposit_chart_ajax",
			type:"GET",
			data:{
				"userid":"${requestScope.userid}"
			},
			dataType:"json",
			success:function(json) {
				
				// console.log(JSON.stringify(json));
				
				// 충전예치금
				let deposit_arr = [];
				
				for(var i=0; i<json.length; i++) {
					
					deposit_arr.push(Number(json[i].purchase_price));
					
				}
				
				// console.log(deposit_arr);
				
				// 사용한 예치금
				let entry_arr = [];
				
				for(var i=0; i<json.length; i++) {
					
					entry_arr.push(Number(json[i].entry_fee));
					
				} 
				
				// 예치금 보유량
				let price_arr = [];
				
				for(var i=0; i<json.length; i++) {
					
					price_arr.push(Number(json[i].price));
					
				} 
				
				//////////////////////////////////////////////////////
				Highcharts.chart('chart_deposit', {

				    title: {
				        text: '1년 동안 충전·사용한 예치금',
				        align: 'left'
				    },
				
				    subtitle: {
				        text: '',
				        align: 'left'
				    },
				
				    yAxis: {
				        title: {
				            text: '원'
				        }
				    },
				
				    xAxis: {
				        accessibility: {
				            rangeDescription: 'Range: 1 to 12'
				        }
				    },
				
				    legend: {
				        layout: 'vertical',
				        align: 'right',
				        verticalAlign: 'middle'
				    },
				
				    plotOptions: {
				    	
				        line: {
				            dataLabels: {
				                enabled: true
				            },
				            enableMouseTracking: false
				        }
				    },
				
				    series: [{
				        name: '예치금 충전',
				        data: deposit_arr
				    }, {
				        name: '사용 예치금',
				        data: entry_arr
				    }, {
				        name: '보유 예치금',
				        data: price_arr
				    }],
				
				    responsive: {
				        rules: [{
				            condition: {
				                maxWidth: 500
				            },
				            chartOptions: {
				                legend: {
				                    layout: 'horizontal',
				                    align: 'center',
				                    verticalAlign: 'bottom'
				                }
				            }
				        }]
				    }
				
				});
				//////////////////////////////////////////////////////
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		<%-- 예치금 그래프 보여주기 끝 --%>
		
		
		<%-- 상금 그래프 보여주기 시작 --%>
		$.ajax ({
			url:"/mypage/reward_chart_ajax",
			type:"GET",
			data:{
				"userid":"${requestScope.userid}"
			},
			dataType:"json",
			success:function(json) {
				
				// console.log(JSON.stringify(json));
				
				// 받은상금
				let reward_arr = [];
				
				for(var i=0; i<json.length; i++) {
					
					reward_arr.push(Number(json[i].reward));
					
				}
				
				// console.log(deposit_arr);
				
				// 환전한 상금
				let convert_arr = [];
				
				for(var i=0; i<json.length; i++) {
					
					convert_arr.push(Number(json[i].convert));
					
				} 
				
				// 상금 보유량
				let user_reward_arr = [];
				
				for(var i=0; i<json.length; i++) {
					
					user_reward_arr.push(Number(json[i].user_reward));
					
				} 
				
				//////////////////////////////////////////////////////
				Highcharts.chart('chart_reward', {

				    title: {
				        text: '1년 동안 충전·사용한 예치금',
				        align: 'left'
				    },
				
				    subtitle: {
				        text: '',
				        align: 'left'
				    },
				
				    yAxis: {
				        title: {
				            text: '원'
				        }
				    },
				
				    xAxis: {
				        accessibility: {
				            rangeDescription: 'Range: 1 to 12'
				        }
				    },
				
				    legend: {
				        layout: 'vertical',
				        align: 'right',
				        verticalAlign: 'middle'
				    },
				
				    plotOptions: {
				    	
				        line: {
				            dataLabels: {
				                enabled: true
				            },
				            enableMouseTracking: false
				        }
				    },
				
				    series: [{
				        name: '획득 상금',
				        data: reward_arr
				    }, {
				        name: '환전한 상금',
				        data: convert_arr
				    }, {
				        name: '보유 상금',
				        data: user_reward_arr
				    }],
				
				    responsive: {
				        rules: [{
				            condition: {
				                maxWidth: 500
				            },
				            chartOptions: {
				                legend: {
				                    layout: 'horizontal',
				                    align: 'center',
				                    verticalAlign: 'bottom'
				                }
				            }
				        }]
				    }
				
				});
				//////////////////////////////////////////////////////
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		<%-- 상금 그래프 보여주기 끝 --%>
		
		
		<%-- 결제 취소하기 시작 --%>
		cancel_data();
		<%-- 결제 취소하기 끝 --%>
			
	}); // end of $(document).ready(function(){} --------
			
	<%-- 사용자가 선택한 현황 보여주기 시작 --%>
	function tag_sort(sort) {
		
		$("input[name=sort]").val(sort);
		
		$.ajax ({
			url:"/mypage/search_data_ajax",
			type:"GET",
			data:{
				"userid":"${requestScope.userid}",
				"start":result_year,
				"end":result_today,
				"sort":$("input[name=sort]").val()
			},
			dataType:"json",
			success:function(json){
				
				// console.log(JSON.stringify(json));
				
				let date = "";
				
				if(json.length > 0) {
					
					if(sort == 1) {
						
						html = "";
						 
						let cnt = 0;
						
						for(var i=0; i<json.length; i++) {
							
							let purchase_price = json[i].purchase_price.toLocaleString('en');
							
							
							
							if(json.length >= 7 && cnt == 7) {
								html += "<tr>"
									 +	"	<td class='td_style' colspan='2'>"
									 +	"		<form name='detail_form'>"
									 +	"			<input type='hidden' name='userid' value='${requestScope.userid}' />"
									 +	"			<input type='hidden' name='sort' value='1' />"
									 +	"			<button class='add_button' onclick='go_detail();'>더보기</button>"
									 +	"		</form>"
									 +	"	</td>"
									 +	"</tr>";
								break;
							}
							
							if(date != json[i].purchase_date.substring(0,10)) {
								html += "<tr class='table_position'>"
									 + "	<td colspan='3' class='font_bold'>"+json[i].purchase_date.substring(0,10)+"</td>"
									 + 	"</tr>";
							}
							
							html += "<tr>"
								 + "	<td class='purchase_date' rowspan='2'>"+json[i].purchase_date+"</td>";
							 
							if(json[i].purchase_status == 0) {
								
								html += "	<td class='td_style'>충전</td>"
									 +	"</tr>"
									 +  "<tr>"
									 +	"	<td class='blue_font font_bold td_style'>" + purchase_price + " 원</td>"
									 +	"</tr>";
							}
							else {
								html += "	<td class='td_style'>취소</td>"
									 +	"</tr>"
									 +  "<tr>"
									 +	"	<td class='red_font font_bold td_style'>" + purchase_price + " 원</td>"
									 +	"</tr>";
							}
							html += "</tr>";
							
							date = json[i].purchase_date.substring(0,10);
							
							cnt++;
						}  
							
					} // end of if(sort == 1) {} -----
					
					else if (sort == 2) {
						
						html = "";
						
						let cnt = 0;
						
						for(var i=0; i<json.length; i++) {
							
							let entry_fee = json[i].entry_fee.toLocaleString('en');
							
							if(json.length >= 5 && cnt == 5) {
								html += "<tr>"
									 +	"	<td class='td_style' colspan='2'>"
									 +	"		<form name='detail_form'>"
									 +	"			<input type='hidden' name='userid' value='${requestScope.userid}' />"
									 +	"			<input type='hidden' name='sort' value='2' />"
									 +	"			<button class='add_button' onclick='go_detail();'>더보기</button>"
									 +	"		</form>"
									 +	"	</td>"
									 +	"</tr>";
								break;
							}
							
							if(date != json[i].startdate.substring(0,10)) {
								html += "<tr class='table_position'>"
									 + "	<td colspan='3' class='font_bold'>"+json[i].startdate.substring(0,10)+"</td>"
									 + 	"</tr>";
							}
							
							html += "<tr>"
								 + "	<td class='purchase_date'>"+json[i].startdate+"</td>"
								 + "	<td class='td_style'>사용</td>"
								 +	"</tr>"
								 +  "<tr>"
								 +	"	<td class='red_font font_bold td_style'>" + json[i].challenge_name + " 챌린지</td>"
								 +	"	<td class='red_font font_bold td_style'>" + entry_fee + " 원</td>"
								 +	"</tr>";
							
							date = json[i].startdate.substring(0,10);
							
							cnt++;
						}
						
					} // end of if(sort == 2) {} -----
					
					else if (sort == 3) {
						
						html = "";
						
						let cnt = 0;
						
						for(var i=0; i<json.length; i++) {
							
							let reward = json[i].reward.toLocaleString('en');
							
							if(json.length >= 5 && cnt == 5) {
								html += "<tr>"
									 +	"	<td class='td_style' colspan='2'>"
									 +	"		<form name='detail_form'>"
									 +	"			<input type='hidden' name='userid' value='${requestScope.userid}' />"
									 +	"			<input type='hidden' name='sort' value='3' />"
									 +	"			<button class='add_button' onclick='go_detail();'>더보기</button>"
									 +	"		</form>"
									 +	"	</td>"
									 +	"</tr>";
								break;
							}
							
							if(date != json[i].reward_date.substring(0,10)) {
								html += "<tr class='table_position'>"
									 + "	<td colspan='3' class='font_bold'>" + json[i].reward_date.substring(0,10) + "</td>"
									 + 	"</tr>";
							}
							
							html += "<tr>"
								 + "	<td class='purchase_date'>" + json[i].reward_date + "</td>"
								 + "	<td class='td_style'>적립</td>"
								 +	"</tr>"
								 +  "<tr>"
								 +	"	<td class='blue_font font_bold td_style'>" + json[i].challenge_name + " 챌린지</td>"
								 +	"	<td class='blue_font font_bold td_style'>" + reward + " 원</td>"
								 +	"</tr>";
							
							date = json[i].reward_date.substring(0,10);
						
							cnt++;
						}
						
					} // end of if(sort == 3) {} -----
					
					else if (sort == 4) {
						
						html = "";
						
						let cnt = 0;
						
						for(var i=0; i<json.length; i++) {
							
							let convert_reward = json[i].convert_reward.toLocaleString('en');
							
							if(json.length >= 5 && cnt == 5) {
								
								html += "<tr>"
									 +	"	<td class='td_style' colspan='2'>"
									 +	"		<form name='detail_form'>"
									 +	"			<input type='hidden' name='userid' value='${requestScope.userid}' />"
									 +	"			<input type='hidden' name='sort' value='4' />"
									 +	"			<button class='add_button' onclick='go_detail();'>더보기</button>"
									 +	"		</form>"
									 +	"	</td>"
									 +	"</tr>";
								break;
								
							}
							
							if(date != json[i].convert_date.substring(0,10)) {
								html += "<tr class='table_position'>"
									 + "	<td class='font_bold' colspan='3'>" + json[i].convert_date.substring(0,10) + "</td>";
							}
						
							html += "<tr>"
								 + "	<td class='purchase_date' rowspan='2'>" + json[i].convert_date + "</td>"
								 + "	<td class='td_style'>환전</td>"
								 +	"</tr>"
								 +  "<tr>"
								 +	"	<td class='red_font font_bold td_style'>" + convert_reward + " 원</td>"
								 +	"</tr>";
							
							date = json[i].convert_date.substring(0,10);
							
							cnt++;
						}
						
					} // end of if(sort == 4) {} -----
					
					$("table#using_info").html(html);
					
				} // end of if(json.length > 0) -----
				else {
					html = "<tr><td class='no_data'>데이터가 없습니다.</td></tr>"
				}
				
				$("table#using_info").html(html);
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	} // end of function tag_sort(sort) {} -----
	<%-- 사용자가 선택한 현황 보여주기 끝 --%>
	
	
	<%-- 취소가능한 결제 내역 보여주시 시작 --%>
	function cancel_data(){
		
		$.ajax ({
			url:"/mypage/cancel_data_ajax",
			type:"GET",
			data:{
				"userid":"${requestScope.userid}",
				"start":result_date,
				"end":result_today,
				"sort":"1"
			},
			dataType:"json",
			success:function(json){
				
				// console.log(JSON.stringify(json));
				
				let date = "";
				
				if(json.length > 0) {
					
					html = "";
					
					for(var i=0; i<json.length; i++) {
						
						let purchase_price = json[i].purchase_price.toLocaleString('en');
						
						if(result_date < json[i].purchase_date.substring(0,10)) {
						
							if(json[i].purchase_status == 0 && json[i].user_all_deposit > json[i].purchase_price){
							
								if(date != json[i].purchase_date.substring(0,10)) {
									
									html += "<tr class='table_position'>"
										 +  "	<td colspan='3'>"+json[i].purchase_date.substring(0,10)+"</td>"
										 + "	<td></td>"
										 + "	<td></td>"
										 + 	"</tr>";
								}
								
								html += "<tr>"
									 +  "	<td class='cancel_td'>"+json[i].purchase_date+"</td>";
										
								html += "	<td class='cancel_td'></td>"
									 +	"</tr>"
									 +  "<tr>"
									 +	"	<td class='cancel_td blue_font'>결제금액: " + purchase_price + " 원</td>"
									 +	" 	<td class='cancel_td'>"
									 +  "		<button type='button' class='go_button' onclick='purchase_cancel("+json[i].purchase_code+");'>취소하기</button>"
									 +  "	</td>"
									 +	"</tr>";
								 
										 
								date = json[i].purchase_date.substring(0,10);
								
							} // end of if (json[i].user_all_deposit > json[i].purchase_price) -----
						}
					} // end of for -----
				
					$("table#cancel_position").html(html);
					
				} // end of if(json.length > 0) -----
				else {
					html =  "<tr>"
					 	 +	"	<td class='cancel_td no_list'>결제 내역이 없습니다.</td>"
					 	 +	"<tr>"
				}
				
				$("table#cancel_position").html(html);
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	};
	<%-- 취소 가능한 결제내역 보여주기 끝 --%>
	
	
	<%-- 더보기 페이지로 가기 시작 --%>
	function go_detail() {

		const frm = document.detail_form;
		
		frm.action = "mypageDetailUsing";
		frm.method = "post";
		frm.submit();
		
	}
	<%-- 더보기 페이지로 가기 끝 --%>
	
	
	<%-- 결제 취소하기 시작 --%>
	function purchase_cancel(code) {
		
		$.ajax ({
			url:"/mypage/purchase_cancel_ajax",
			type:"GET",
			data:{
				"userid":"${requestScope.userid}",
				"purchase_code":code
			},
			dataType:"json",
			success:function(json){
				
				// console.log(JSON.stringify(json));
				
				alert("취소가 완료되었습니다.\n영업일기준 7일 이내 환불될 예정입니다.");
				
				cancel_data();
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		
		});
	}
	<%-- 결제 취소하기 끝 --%>
	
	function make_excel() {
		
		const frm = document.test;
		
		frm.method = "post";
		frm.action = "/mypage/make_excel";
		frm.submit();
		
	}
	
</script>

	<div id="mainPosition">
	
		<!-- index 상단 제목 시작 -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h3 class="mb-0 text-gray-800 font-weight-bold">사용자 예치금 및 상금 사용 현황</h3>
		</div>
		<!-- index 상단 제목 끝 -->
		
		<!-- 첫번째 문단 시작 -->
		<div class="row">
			
			<div class="col-lg-6 mb-4">
				<div id="notice" class="card shadow mb-4">
					<div class="card-header py-3">
						<h5 class="m-0 font-weight-bold">예치금</h5>
						</div>
					<div class="card-body">
						<div class="row no-gutters">
							<table style="width:100%; text-align:center;">
								<tr>
									<td>총 충전 예치금</td>
									<td rowspan="2">
										<i class="fas fa-minus-circle" style="color: #f50000;"></i>
									</td>
									<td>챌린지 참가중</td>
									<td rowspan="2">
										<i class="fas fa-equals fa-lg" style="color: #f43630;"></i>
									</td>
									<td>현재 보유 예치금</td>
									<td rowspan="2" class="td_width_19">
										<button type="button" class="go_button" onclick="location.href='<%=ctxPath%>/mypage/depositPurchase'">충전하러 가기</button>
									</td>
								</tr>
								<tr>
									<td id="user_deposit_position">
										 <fmt:formatNumber value="${requestScope.depo_dto.purchasePrice}" pattern="#,###"/>원 
									</td>
									<td id="during_challenge_position">
										<fmt:formatNumber value="${requestScope.depo_dto.entryFee}" pattern="#,###"/> 원
									</td>
									<td id="all_deposit_position">
										<fmt:formatNumber value="${requestScope.depo_dto.allDeposit}" pattern="#,###"/> 원
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-lg-6 mb-4">
				<div id="notice" class="card shadow mb-4">
					<div class="card-header py-3">
						<h5 class="m-0 font-weight-bold">상금</h5>
						</div>
					<div class="card-body">
						<div class="row no-gutters">
							<table style="width:100%; text-align:center;">
								<tr>
									<td class="tag_sort">총 받은 상금</td>
									<td rowspan="2">
										<i class="fas fa-minus-circle" style="color: #f50000;"></i>
									</td>
									<td class="tag_sort">전환한 상금</td>
									<td rowspan="2"> 
										<i class="fas fa-equals fa-lg" style="color: #f43630;"></i>
									</td>
									<td class="tag_sort">현재 보유 상금</td>
									<td rowspan="2" class="td_width_19">
										<button type="button" class="go_button" onClick="location.href='<%=ctxPath%>/mypage/change_reward'">환전하러 가기</button>
									</td>
								</tr>
								<tr>
									<td id="user_reward_position">
										<fmt:formatNumber value="${requestScope.reward_dto.reward}" pattern="#,###"/> 원
									</td>
									<td id="convert_reward_position">
										<fmt:formatNumber value="${requestScope.reward_dto.convertReward}" pattern="#,###"/> 원
									</td>
									<td id="all_reward_position">
										<fmt:formatNumber value="${requestScope.reward_dto.allReward}" pattern="#,###"/> 원
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 첫번째 문단 끝 -->
			
			
		<!-- 두번째문단 시작 -->
		<div class="row">
			<div class="col-lg-6 mb-4">
				<div id="notice" class="card shadow mb-4">
					<div class="card-header py-3">
						<form name="test">
							<input type="hidden" name="userid" value="${requestScope.userid}" />
						</form>
						<button type="button" id="excel_button" class="go_button" data-toggle="tooltip" 
							title="1년 동안 사용한 예치금 및 상금 내역을 다운 받을 수 있습니다." onclick="make_excel();">xlsx다운받기</button>
						
						<h5 class="py-1 font-weight-bold">예치금·상금 사용내역</h5>
						<h6 class="text-danger">사용내역은 가장 최근 내역 7건만 나타납니다. 7건 이외의 내역은 '더보기' 버튼을 눌러주세요.</h6>
						<form>
							<table class="table_tag_sort">
								<tr style="text-align:center;">
									<td id="tag_sort_1" class="tag_sort" onclick="tag_sort(1)">예치금결제·취소</td>
									<td id="tag_sort_2" class="tag_sort" onclick="tag_sort(2)">챌린지참가</td>
									<td id="tag_sort_3" class="tag_sort" onclick="tag_sort(3)">상금획득내역</td>
									<td id="tag_sort_4" class="tag_sort" onclick="tag_sort(4)">상금출금</td>
								</tr>
							</table>
							<input type="hidden" id="sort" name="sort" />
						</form>
						</div>
					<div class="card-body height_px_2">
					
						<div class="row no-gutters align-items-center">
								
						<table id="using_info">
							<tr><td class="td_padding">보고자 하는 항목을 선택해주세요.</td></tr>
						</table> 
							
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-lg-6 mb-4">
				<div id="notice" class="card shadow mb-4">
					<div class="card-header py-3">
						<h5 class="py-1 font-weight-bold">결제취소</h5>
						<h6 class="text-danger">결제취소는 7일 이내 결제건만 취소가 가능하며, 사용한 예치금은 취소가 불가능합니다.</h6>
						</div>
					<div class="card-body height_px">
				
						<div class="row no-gutters align-items-center">
							<table id="cancel_position">
								
							</table>	
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 두번째문단 끝 -->
		
		<!-- 세번째 문단 시작 -->
		<div class="row mb-4">
			<!-- 예치금 리포트 시작-->
				<div class="col-lg-6 mb-8">
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h5 class="m-0 font-weight-bold">예치금 리포트</h5>
						</div>
						<div class="card-body">
							<div id="chart_deposit" class="chart-bar">
							</div>
							<hr>
							결제 취소를 제외하고 1년 동안 예치금량을 보여드립니다.
						</div>
					</div>
				</div>
			<!-- 예치금 리포트 끝 -->
			
			<!-- 상금 리포트 시작-->
				<div class="col-lg-6 mb-8">
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h5 class="m-0 font-weight-bold">상금 리포트</h5>
						</div>
						<div class="card-body">
							<div id="chart_reward" class="chart-bar">
							</div>
							<hr>
							1년 동안 상금량을 보여드립니다.
						</div>
					</div>
				</div>
			<!-- 상금 리포트 끝 -->
		</div>
		<!-- 세번째 문단 끝 -->
			
	</div>
</body>
</html> 
