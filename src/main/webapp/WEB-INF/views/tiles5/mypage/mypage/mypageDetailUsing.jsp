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
	
	td {
		font-size: 13pt;
	}
	
	.font_weight {
		font-weight: bold;
	}
	
	label.label_style {
		margin: 0 3%;
	}
	
	div#cal_position {
		text-align: center;
		margin: 2% 0;
	}
	
	div#div_table_show {
		background-color: white;
		padding: 3% 16% 5% 16%;
		border-radius: 4%;
	}
	
	table#table_show {
		width: 100%;
	}
	
	td.no_data {
		text-align: center;
		height: 50px;
	}
	
	td.purchase_date {
		text-align: center;
		width: 58%;
		height: 60px;
	}
	
	td.td_style {
		text-align: center;
	}
	
	td.blue_font {
		color: blue;
		font-weight: bold;
		font-size: 15pt;
	}
	
	td.red_font {
		color: red;
		font-weight: bold;
		font-size: 15pt;
	}
	
	tr.table_position {
		height: 77px;
		text-align: center;
		border-bottom: solid #aaaaaa 1px;
	}

	input.sort_value {
		margin-right: 8px;
	}
	
	li.li_current_pageno {
		display: inline-block; 
		width: 35px; 
		font-size: 14pt; 
		border: none; 
		color: white;
		background-color: red; 
		padding: 2px 4px;
	}
	
	li.li_no_current_pageno {
		display: inline-block; 
		width: 30px; 
		font-size: 14pt;
	}
	
	li.li_first_final {
		display: inline-block; 
		width: 70px; 
		font-size: 12pt;
	}
	
	li.li_next_before {
		display:i nline-block; 
		width: 50px; 
		font-size: 12pt;
	}
	
	/* 체크박스 시작 */
	.checks {
	    position: relative;
	    height: 20px;
	    padding: 30px;
	    line-height: 20px;
	    margin: 1% 0;
		text-align: center;
		font-size: 13pt;
	}
	.checks label {
	    font-size: 18px;
	    margin-right: 10px;
	    vertical-align: middle;
	}
	            
	.checks input[type="radio"] {
	    position: absolute;
	    width: 1px;
	    height: 1px;
	    padding: 0;
	    margin: -1px;
	    overflow: hidden;
	    clip: rect(0, 0, 0, 0);
	    border: 0;
	}
	.checks input[type="radio"]+label {
	    display: inline-block;
	    position: relative;
	    padding-left: 25px;
	    cursor: pointer;
	    -webkit-user-select: none;
	    -moz-user-select: none;
	    -ms-user-select: none;
	}
	            
	.checks input[type="radio"]+label:before {
	    content: '';
	    position: absolute;
	    left: 4px;
	    top: 0px;
	    width: 14px;
	    height: 14px;
	    text-align: center;
	    background: #fff;
	    border: 1px solid #cacece;
	    border-radius: 100%;
	    box-shadow: none;
	}
	.checks input[type="radio"]:checked+label:before {
	    background: #fff;
	    border-color: #e86138;
	} 
	            
	.checks input[type="radio"]:checked+label:after {
	    content: '';
	    position: absolute;
	    top: 1px;
	    left: 5px;
	    width: 14px;
	    height: 14px;
	    background: #e86138;
	    border-radius: 100%;
	    box-shadow: none;
	}
	/* 체크박스 끝 */
	
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
		    	
		    	search_data( $("input#sort").val(), 1);
		    });
		    
		    $("input#end").datepicker('setDate', 'today');
		   
		    $("input#end").change(function(){
		    	
		    	if($("input#start").val() > $(this).val()) {
		    		$(this).val($("input#start").val());
		    	}
		    	
		    	search_data( $("input#sort").val(), 1);
		    });
		    
		});
		
		<%-- 사용현황 가지고 오기 시작 --%>
		

		search_data( $("input#sort").val(), 1);
		
		
		$("input:radio[name=sort_value]").click(function(){
			
			// search_data( $(this).val() );
			
			$("input#sort").val( $(this).val() );
			
			search_data( $("input#sort").val(), 1);
			
		});
		<%-- 사용현황 가지고 오기 끝 --%>
		
	}); // end of document.ready -----
	
	function search_data(sort, current_pageno) {
		
		$.ajax ({
			url:"/mypage/search_paging_ajax",
			type:"GET",
			data:{
				"userid":$("input#userid").val(),
				"start":$("input#start").val(),
				"end":$("input#end").val(),
				"sort":sort,
				"current_pageno":current_pageno
			},
			dataType:"json",
			success:function(json){
				
				// console.log(JSON.stringify(json));
				
				let html = "";
				
				if( $("input#sort").val() == 1 ) {
					
					$("input#radio_1").prop("checked", true);
					
					let date = "";
					
					if(json.length > 0) {
						
						for(var i=0; i<json.length; i++) {
						
							let purchase_price = json[i].purchase_price.toLocaleString('en');
							
							if(date != json[i].purchase_date.substring(0,10)) {
								// 시,분,초가 다를 때 시,분,초를 뺀 날짜를 입력해준다.
								html += "<tr class='table_position'>"
									 +	"	<td colspan='3'>" + json[i].purchase_date.substring(0,10) + "</td>"
									 +	"</tr>"
							}
							
							html += "<tr>"
								 + "	<td class='purchase_date' rowspan='2'>"+json[i].purchase_date+"</td>";
							 
							if(json[i].purchase_status == 0) {
								
								html += "	<td class='td_style'>충전</td>"
									 +	"</tr>"
									 +  "<tr>"
									 +	"	<td class='blue_font td_style'>" + json[i].purchase_price + "</td>"
									 +	"</tr>";
							}
							else if(json[i].purchase_status == 1) {
								html += "	<td class='td_style'>취소</td>"
									 +	"</tr>"
									 +  "<tr>"
									 +	"	<td class='red_font td_style'>" + purchase_price + "</td>"
									 +	"</tr>";
							}
							html += "</tr>";
							
							date = json[i].purchase_date.substring(0,10);
							
						} // end of for(var i=0; i<json.length; i++) {} -----
						
					} // end of if(json.length > 0) {} -----
					else {
						html = "<tr><td class='no_data'>데이터가 없습니다.</td></tr>"
					}
					
					
					
				} // end of if( $("input#sort").val() == 1 ) {} -----
				
				else if( $("input#sort").val() == 2 ) {
					
					$("input#radio_2").prop("checked", true);
					
					let date = "";
					
					if(json.length > 0) {
						
						for(var i=0; i<json.length; i++) {
							
							let entry_fee = json[i].entry_fee.toLocaleString('en');
							
							if(date != json[i].startdate.substring(0,10)) {
								html += "<tr class='table_position'>"
									 + "	<td colspan='3'>"+json[i].startdate.substring(0,10)+"</td>"
									 + 	"</tr>";
							}
							
							html += "<tr>"
								 + "	<td class='purchase_date'>"+json[i].startdate+"</td>"
								 + "	<td class='td_style'>사용</td>"
								 +	"</tr>"
								 +  "<tr>"
								 +	"	<td class='blue_font td_style'>" + json[i].challenge_name + " 챌린지</td>"
								 +	"	<td class='blue_font td_style'>" + entry_fee + "</td>"
								 +	"</tr>";
							
							date = json[i].startdate.substring(0,10);
							
						} // end of for(var i=0; i<json.length; i++) {} -----
						
					} // end of if(json.length > 0) {} -----
					else {
						html = "<tr><td class='no_data'>데이터가 없습니다.</td></tr>"
					}
					
				} // end of else if( $("input#sort").val() == 2 ) {} -----
				
				else if( $("input#sort").val() == 3 ) {
					
					$("input#radio_3").prop("checked", true);
					
					let date = "";
					
					if(json.length > 0) {
						
						for(var i=0; i<json.length; i++) {
							
							let reward = json[i].reward.toLocaleString('en');
							
							if(date != json[i].reward_date.substring(0,10)) {
								html += "<tr class='table_position'>"
									 + "	<td colspan='3'>" + json[i].reward_date.substring(0,10) + "</td>"
									 + 	"</tr>";
							}
							
							html += "<tr>"
								 + "	<td class='purchase_date'>" + json[i].reward_date + "</td>"
								 + "	<td class='td_style'>적립</td>"
								 +	"</tr>"
								 +  "<tr>"
								 +	"	<td class='blue_font td_style'>" + json[i].challenge_name + " 챌린지</td>"
								 +	"	<td class='blue_font td_style'>" + reward + "</td>"
								 +	"</tr>";
							
							date = json[i].reward_date.substring(0,10);
						
						} // end of for(var i=0; i<json.length; i++) {} -----
					
					} // end of if(json.length > 0) {} -----
					else {
						html = "<tr><td class='no_data'>데이터가 없습니다.</td></tr>"
					}
					
				} // end of else if( $("input#sort").val() == 3 ) {} -----
				
				else {
					
					$("input#radio_4").prop("checked", true);

					let date = "";
					
					if(json.length > 0) {
						
						for(var i=0; i<json.length; i++) {
							
							let convert_reward = json[i].convert_reward.toLocaleString('en');
							
							if(date != json[i].convert_date.substring(0,10)) {
								html += "<tr class='table_position'>"
									 + "	<td colspan='3'>" + json[i].convert_date.substring(0,10) + "</td>"
									 + 	"</tr>";
							}
							
							html += "<tr>"
								 + "	<td class='purchase_date'  rowspan='2'>" + json[i].convert_date + "</td>"
								 + "	<td class='td_style'>환전</td>"
								 +	"</tr>"
								 +  "<tr>"
								 +	"	<td class='blue_font td_style'>" + convert_reward + "</td>"
								 +	"</tr>";
							
							date = json[i].convert_date.substring(0,10);
							
						} // end of for(var i=0; i<json.length; i++) {} -----
						
					} // end of if(json.length > 0) {} -----
					else {
						html = "<tr><td class='no_data'>데이터가 없습니다.</td></tr>"
					}
					
				} // end of else {} -----
			
				$("table#table_show").html(html);
				
				get_pagebar(sort, current_pageno);
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	} // end of function search_data(sort, currentShowPageNo) {} -----
	
	
	// ==== 댓글내용 페이지바 Ajax로 만들기 ==== //
  	function get_pagebar(sort, current_pageno) {
		
		$.ajax({
			url:"/mypage/get_pagebar_ajax",
			data:{
				"userid":"${requestScope.userid}",
				"page_size":"10",
				"start":$("input#start").val(),
				"end":$("input#end").val(),
				"sort":sort
			},
			type:"get",
			dataType:"json",
			success:function(json){
				console.log(JSON.stringify(json));
				
				if(json.total_page > 0) {
					
					// 댓글이 있는 경우
					const total_page = json.total_page;
					const block_size = 10;   // 페이지바를 10개 씩 보이겠다는 뜻
					
		            let loop = 1;
		            
					if(typeof current_pageno == "string") {
						// 혹시나 currentShowPageNo 에 문자열이 들어왔을 때를 대비하여 숫자로 또 바꿔준 것이다.
						current_pageno = Number(current_pageno);
					} 
		            
					let pageno = Math.floor( (current_pageno - 1)/block_size ) * block_size + 1;
		             
					let pagebar_HTML = "<ul style='list-style: none;'>";
		            
		            // === [맨처음][이전] 만들기 === //
		            if(pageno != 1) {
		            	pagebar_HTML += "<li class='li_first_final'>"
		            				 +	"	<a onclick='search_data("+$("input#sort").val()+",1)'>[맨처음]</a>"
		            				 +	"</li>";
		            				 
		            	pagebar_HTML += "<li class='li_next_before'>"
		            				 +	"	<a onclick='search_data("+$("input#sort").val()+"," + pageno-1 + ")'>[이전]</a>"
		            				 +	"</li>";
		            }
		            
		            while( !(loop > block_size || pageno > total_page) ) {
		               
		               if(pageno == current_pageno) {
		            	   pagebar_HTML += "<li class='li_current_pageno'>" + pageno + "</li>";  
		               }
		               
		               else {
		            	   pagebar_HTML += "<li class='li_no_current_pageno'>"
		            	   			    +  "	<a onclick='search_data("+$("input#sort").val()+"," + pageno + ")'>"+pageno+"</a>"
		            	   			    +  "</li>"; 
		               }
		               
		               loop++;
		               pageno++;
		               
		            }// end of while-----------------------
		            
		            
		            // === [다음][마지막] 만들기 === //
		            if( pageno <= total_page ) {
		            	pagebar_HTML += "<li class='li_first_next'>"
		            				 +  "	<a onclick='search_data("+$("input#sort").val()+" ,"+ pageno +")'>[다음]</a>"
		            				 +	"</li>";
		            				 
		            	pagebar_HTML += "<li class='li_first_final'>"
		            				 +	"	<a onclick='search_data("+$("input#sort").val()+" ,"+ total_page +")>[마지막]</a>"
		            				 +	"</li>"; 
		            }
		             
		            pagebar_HTML += "</ul>";
		             
		            $("div#page_bar").html(pagebar_HTML);
				
				} // end of if(json.length > 0)
			
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
		
	} // end of function makeCommentPageBar(currentShowPageNo) {} -----------------------------------------
  
</script>

<div id="mainPosition">

	<div class="row mb-4">
		
		<input type="hidden" id="userid" value="${requestScope.userid}" />
		<input type="hidden" id="sort" value="${requestScope.sort}" />
		
		<h3 class="font_weight">결제 사용현황</h3>
		
		<div class="col-lg-12 checks">
			<input type="radio" class="sort_value" name="sort_value" value="1" id="radio_1" />
			<label for="radio_1" class="label_style font_weight">예치금 결제·취소현황</label>
			
			<input type="radio" class="sort_value" name="sort_value" value="2" id="radio_2" />
			<label for="radio_2" class="label_style font_weight">예치금 사용현황</label>
			
			<input type="radio" class="sort_value" name="sort_value" value="3" id="radio_3" />
			<label for="radio_3" class="label_style font_weight">상금 획득현황</label>
			
			<input type="radio" class="sort_value" name="sort_value" value="4" id="radio_4" />
			<label for="radio_4" class="label_style font_weight">상금 환전현황</label>
		</div>
		
		<div id="cal_position" class="col-lg-12">
			<a style="margin-right:10px;">To</a>
			<input type="text" id="start" style="margin-right:100px;">
			<a style="margin-right:10px;">From</a>
			<input type="text" id="end">
		</div>
		
		<div id="div_table_show" class="col-lg-12">
			<table id="table_show">
				
			</table>
			
		</div>
		
	</div>
	<!-- 상금 입력 끝 -->
		
			<div style="display: flex; margin-bottom: 50px;">
          		<div id="page_bar" style="margin: auto; text-align: center;"></div>
      		</div>
	</div>

		
			

</body>
</html> 
