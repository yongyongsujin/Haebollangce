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
	
	button.go_button {
		width: 99px;
		height: 35px;
		border: none;
		border-radius: 40px;
		background-color: #f43630;
		color: white;
		font-size: 10pt;
		font-weight: bold;
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
	
	.tag_sort_change {
		text-shadow:1px 1px 3px #f43630;
	}
	
	td.blue_font {
		color: blue;
	}
	
	td.red_font {
		color: red;
	}
	
	table#cancel_position {
		width: 100%;
	}
	
	td.cancel_td {
		padding: 0 10%;
		height: 42px;
		text-align: center;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// === 전체 datepicker 옵션 일괄 설정하기 === //
		// 한 번의 설정으로 $("input#fromDate") , $("input#toDate") 의 옵션을 모두 설정할 수 있다.
		$(function() {
		    //모든 datepicker에 대한 공통 옵션 설정
		    $.datepicker.setDefaults({
		         dateFormat: 'yy-mm-dd' //Input Display Format 변경
		        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		        ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
		        ,changeYear: true //콤보박스에서 년 선택 가능
		        ,changeMonth: true //콤보박스에서 월 선택 가능           
		        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] 
		        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
		        ,dayNamesMin: ['일','월','화','수','목','금','토'] 
		        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
		    
		    });
		    
		    $("input#start").datepicker();
		    $("input#end").datepicker();

		    $("input#start").datepicker('setDate', '-1Y');
		    
		    
		    $("input#start").change(function(){
		    	
		    	if($(this).val() > $("input#end").val()) {
		    		$(this).val($("input#end").val());
		    	}
		    	
		    	tag_sort($("input[name=sort]").val());
		    });
		    
		    $("input#end").datepicker('setDate', 'today');
		   
		    $("input#end").change(function(){
		    	
		    	if($("input#start").val() > $(this).val()) {
		    		$(this).val($("input#start").val());
		    	}
		    	
		    	tag_sort($("input[name=sort]").val());
		    });
		    
		});
		
		<%-- 두번째문단 보유예치금,상금 보여주기 시작 --%>
		$.ajax ({
			url: "/mypage/user_deposit_ajax",
			type: "GET",
			data: {
				"userid":"jisu"
			},
			dataType:"json",
			success:function(json){
				
				$("input#user_deposit_input").val(json.user_all_deposit);
				
				$("div#user_deposit").html(json.user_all_deposit + " 원");
				
				$("td#user_deposit_position").html(json.user_deposit + " 원");
				$("td#during_challenge_position").html(json.user_challenge_deposit + " 원");
				$("td#all_deposit_position").html(json.user_all_deposit + " 원");
				
				$("div#user_reward").html(json.user_all_reward + " 원");
				
				$("td#user_reward_position").html(json.user_reward + " 원");
				$("td#convert_reward_position").html(json.user_convert + " 원");
				$("td#all_reward_position").html(json.user_all_reward + " 원");
				
				
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		<%-- 두번째문단 보유예치금,상금 보여주기 끝 --%>
		
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
				"userid":"jisu",
				"start":$("input#start").val(),
				"end":$("input#end").val(),
				"sort":$("input[name=sort]").val()
			},
			dataType:"json",
			success:function(json){
				
				console.log(JSON.stringify(json));
				
				let date = "";
				
				if(json.length > 0) {
					
					if(sort == 1) {
						
						html = "";
						
						for(var i=0; i<json.length; i++) {
							if(date != json[i].purchase_date.substring(0,10)) {
								html += "<tr class='table_position'>"
									 + "	<td>"+json[i].purchase_date.substring(0,10)+"</td>"
									 + "	<td></td>"
									 + "	<td></td>"
									 + 	"</tr>";
							}
							
							html += "<tr>"
								 + "	<td>"+json[i].purchase_date+"</td>";
							 
							if(json[i].purchase_status == 0) {
								
								html += "	<td>충전</td>"
									 +	"</tr>"
									 +  "<tr>"
									 +	"	<td></td>"
									 +	"	<td class='blue_font'>" + json[i].purchase_price + "</td>"
									 +	"</tr>";
							}
							else {
								html += "	<td>취소</td>"
									 +	"</tr>"
									 +  "<tr>"
									 +	"	<td></td>"
									 +	"	<td class='red_font'>" + json[i].purchase_price + "</td>"
									 +	"</tr>";
							}
							html += "</tr>";
							
							date = json[i].purchase_date.substring(0,10);
							
						} 
							
					} // end of if(sort == 1) {} -----
					
					else if (sort == 2) {
						
						html = "";
						
						for(var i=0; i<json.length; i++) {
							
							if(date != json[i].startdate.substring(0,10)) {
								html += "<tr class='table_position'>"
									 + "	<td>"+json[i].startdate.substring(0,10)+"</td>"
									 + "	<td></td>"
									 + "	<td></td>"
									 + 	"</tr>";
							}
							
							html += "<tr>"
								 + "	<td>"+json[i].startdate+"</td>"
								 + "	<td>사용</td>"
								 +	"</tr>"
								 +  "<tr>"
								 +	"	<td class='blue_font'>" + json[i].challenge_name + " 챌린지</td>"
								 +	"	<td class='blue_font'>" + json[i].entry_fee + "</td>"
								 +	"</tr>";
							
							date = json[i].startdate.substring(0,10);
							
						}
						
					} // end of if(sort == 2) {} -----
					
					else if (sort == 3) {
						
						html = "";
						
						for(var i=0; i<json.length; i++) {
							
							if(date != json[i].reward_date.substring(0,10)) {
								html += "<tr class='table_position'>"
									 + "	<td>" + json[i].reward_date.substring(0,10) + "</td>"
									 + "	<td></td>"
									 + "	<td></td>"
									 + 	"</tr>";
							}
							
							html += "<tr>"
								 + "	<td>" + json[i].reward_date + "</td>"
								 + "	<td>적립</td>"
								 +	"</tr>"
								 +  "<tr>"
								 +	"	<td class='blue_font'>" + json[i].challenge_name + " 챌린지</td>"
								 +	"	<td class='blue_font'>" + json[i].reward + "</td>"
								 +	"</tr>";
							
							date = json[i].reward_date.substring(0,10);
							
						}
						
					} // end of if(sort == 3) {} -----
					
					else if (sort == 4) {
						
						html = "";
						
						for(var i=0; i<json.length; i++) {
							
							if(date != json[i].convert_date.substring(0,10)) {
								html += "<tr class='table_position'>"
									 + "	<td>" + json[i].convert_date.substring(0,10) + "</td>"
									 + "	<td></td>"
									 + "	<td></td>"
									 + 	"</tr>";
							}
							
							html += "<tr>"
								 + "	<td>" + json[i].convert_date + "</td>"
								 + "	<td>환전</td>"
								 +	"</tr>"
								 +  "<tr>"
								 +	"	<td class='blue_font'>" + json[i].convert_reward + "</td>"
								 +	"</tr>";
							
							date = json[i].convert_date.substring(0,10);
							
						}
						
					} // end of if(sort == 4) {} -----
					
					$("table#using_info").html(html);
					
				} // end of if(json.length > 0) -----
				else {
					html = "<tr><td>데이터가 없습니다.</td></tr>"
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
		
		// 7일전 = start
		let nowDate = new Date();
		let weekDate = nowDate.getTime() -(7*24*60*60*1000);
		nowDate.setTime(weekDate);
		
		let weekYear = nowDate.getFullYear();
		let weekMonth = nowDate.getMonth() + 1;
		let weekDay = nowDate.getDate();
		
		if(weekMonth < 10) {weekMonth = "0" + weekMonth};
		if(weekDay < 10) {weekDay = "0" + weekDay};
		
		let resultDate = weekYear + "-" + weekMonth + "-" + weekDay;
		
		
		// 오늘 = end
		let today = new Date();
		
		let todayMonth = today.getDate() + 1;
		let todayDay = today.getDate();
		
		// console.log("todayMonth: " + todayMonth);
		// console.log("todayDay: " + todayDay);
		
		if(todayMonth < 10) {todayMonth = "0" + todayMonth};
		if(todayDay < 10) {todayDay = "0" + todayDay};
		
		let resultToday = today.getFullYear() + "-" + todayMonth + "-" + todayDay;
		
		
		
		$.ajax ({
			url:"/mypage/cancel_data_ajax",
			type:"GET",
			data:{
				"userid":"jisu",
				"start":resultDate,
				"end":resultToday,
				"sort":"1"
			},
			dataType:"json",
			success:function(json){
				
				// console.log(JSON.stringify(json));
				
				let date = "";
				
				if(json.length > 0) {
					
					html = "";
					
					for(var i=0; i<json.length; i++) {
						
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
								 +	"	<td class='cancel_td blue_font'>결제금액: " + json[i].purchase_price + "</td>"
								 +	" 	<td class='cancel_td'>"
								 +  "		<button type='button' class='go_button' onclick='purchase_cancel("+json[i].purchase_code+");'>취소하기</button>"
								 +  "	</td>"
								 +	"</tr>";
							 
									 
							date = json[i].purchase_date.substring(0,10);
						} // end of if (json[i].user_all_deposit > json[i].purchase_price) -----
						
					} // end of for -----
				
					
				
						
					$("table#cancel_position").html(html);
					
				} // end of if(json.length > 0) -----
				else {
					html = "<div>결제 내역이 없습니다.</div>"
				}
				
				$("table#cancel_position").html(html);
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	};
	<%-- 취소 가능한 결제내역 보여주기 끝 --%>
	
	
	
	<%-- 결제 취소하기 시작 --%>
	function purchase_cancel(code) {
		
		$.ajax ({
			url:"/mypage/purchase_cancel_ajax",
			type:"GET",
			data:{
				"userid":"jisu",
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
	
</script>

	<div id="mainPosition">
		<input type="hidden" id="user_deposit_input" />
		
		<!-- index 상단 제목 시작 -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h3 mb-0 text-gray-800">사용자 예치금 및 상금 사용 현황</h1>
		</div>
		<!-- index 상단 제목 끝 -->
		
		<!-- 첫번째 문단 시작 -->
		<div class="row">
			<!-- 코인보유량 시작 -->
			<div class="col-lg-6 col-md-6 mb-4">
 				<div class="card border-left-primary shadow h-100 py-4">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-xs font-weight-bold text-primary text-uppercase mb-1">보유 예치금</div>
								<div id="user_deposit" class="h5 mb-0 font-weight-bold text-gray-800"></div>
							</div>
							<div class="col-auto">
								<button type="button" class="go_button" onclick="location.href='<%=ctxPath%>/mypage/depositPurchase'">충전하러 가기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 코인보유량 끝 -->

			<!-- 보유상금 시작 -->
			<div class="col-lg-6 col-md-6 mb-4">
				<div class="card border-left-success shadow h-100 py-4">
					<div class="card-body">
						<div class="row no-gutters align-items-center">
							<div class="col mr-2">
								<div class="text-xs font-weight-bold text-success text-uppercase mb-1">보유 상금</div>
								<div id="user_reward" class="h5 mb-0 font-weight-bold text-gray-800"></div>
							</div>
							<div class="col-auto">
								<button type="button" class="go_button" onClick="location.href='<%=ctxPath%>/mypage/change_reward'">환전하러 가기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 보유상금 끝 -->
		</div>
		<!-- 첫번째 문단 끝 -->
		
			<!-- 두번째 문단 시작 -->
			<div class="row mb-4">
				<!-- 코인 시작 -->
				<div class="col-lg-6 mb-4">
					<div id="notice" class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">예치금</h6>
 						</div>
						<div class="card-body">
							<div class="row no-gutters">
									<table style="width:100%; text-align:center;">
										<tr>
											<td>총 충전 예치금</td>
											<td></td>
											<td>챌린지 참가중</td>
											<td></td>
											<td>현재 보유 예치금</td>
										</tr>
										<tr>
											<td id="user_deposit_position"></td>
											<td><i class="fas fa-minus-circle" style="color: #f50000;"></i></td>
											<td id="during_challenge_position"></td>
											<td><i class="fas fa-equals fa-lg" style="color: #f43630;"></i></td>
											<td id="all_deposit_position"></td>
										</tr>
									</table>
							</div>

						</div>
					</div>
				</div>
				<!-- 코인 끝 -->
				
				<!-- 상금 시작 -->
				<div class="col-lg-6 mb-4">
					<div id="notice" class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">상금</h6>
 						</div>
						<div class="card-body">
							<div class="row no-gutters">
									<table style="width:100%; text-align:center;">
										<tr>
											<td class="tag_sort">총 받은 상금</td>
											<td></td>
											<td class="tag_sort">전환한 상금</td>
											<td></td>
											<td class="tag_sort">현재 보유 상금</td>
										</tr>
										<tr>
											<td id="user_reward_position"></td>
											<td><i class="fas fa-minus-circle" style="color: #f50000;"></i></td>
											<td id="convert_reward_position"></td>
											<td><i class="fas fa-equals fa-lg" style="color: #f43630;"></i></td>
											<td id="all_reward_position"></td>
										</tr>
									</table>
							</div>

						</div>
					</div>
				</div>
				<!-- 상금 끝 -->
			</div>
			<!-- 두번째 문단 끝 -->
			
			
			<!-- 두번째문단 시작 -->
			<div class="row">
				<div class="col-lg-6 mb-4">
					<div id="notice" class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">코인·상금 사용내역</h6>
							<form name="search_form">
								<table style="width:100%; margin-top:30px;">
									<tr style="text-align:center;">
										<td id="tag_sort_2" class="tag_sort" onclick="tag_sort(1)">예치금결제·취소</td>
										<td id="tag_sort_4" class="tag_sort" onclick="tag_sort(2)">챌린지참가</td>
										<td id="tag_sort_5" class="tag_sort" onclick="tag_sort(3)">상금획득내역</td>
										<td id="tag_sort_6" class="tag_sort" onclick="tag_sort(4)">상금출금</td>
									</tr>
								</table>
								<input type="hidden" id="sort" name="sort" />
							</form>
 						</div>
						<div class="card-body">
						
							<div class="row no-gutters align-items-center">
								<div id="cal_position">
									<a style="margin-right:10px;">To</a>
									<input type="text" id="start" style="margin-right:100px;">
									<a style="margin-right:10px;">From</a>
									<input type="text" id="end">
								</div>	
							<table id="using_info" style="width:100%;">
							
							</table> 
								
						</div>
					</div>
				</div>
			</div>
			
			<div class="col-lg-6 mb-4">
					<div id="notice" class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">결제취소</h6>
 						</div>
						<div class="card-body">
						
							<div class="row no-gutters align-items-center">
								<table id="cancel_position">
									
								</table>	
						</div>
					</div>
				</div>
			</div>
			
			</div>
			<!-- 두번째문단 끝 -->
			
		</div>
		<!-- 메인 끝 -->

</body>
</html> 
