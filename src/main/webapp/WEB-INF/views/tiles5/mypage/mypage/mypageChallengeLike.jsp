<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%
    String ctxPath = request.getContextPath();
%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	div#main_position {
		margin: 99px 5% 0 5%;
	}
	
	.font_weight {
		font-weight: bold;
	}
	
	div#position {
		background-color:white; 
		padding: 54px 1% 54px 4%;
	}
	
	div.card {
		border: solid 1px gray;
		padding: 0!important;
		margin-left: 1%;
		margin-bottom: 1%;
		max-width: 23%;
		width: 100%;
	}
	
	div.challenge_date {
		margin-top: 30px;
	}
	
	span.challenge_span {
		margin-left: 10px;
	}
	
	a.btn:hover {
		background-color: #f43630;
		border: solid 1px #f43630;
	}
	
	div.card-body {
		padding: 0.25rem;
	}
	
	div.no_like_style {
		padding: 10% 32% 0 32%;
		font-size: 15pt;
	}
	
	button.go_button_style {
		margin: 10% 14% 0 14%;
		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 5% 8%;
		text-align: center;
		transition: 0.3s;
		border-radius: 35px;
	}
	
	button.go_button_style:hover {
		background-color: #f43630;
		color: white;
	}
	
	
	div.button_div_style {
		padding: 3% 44% 13% 42%;
		width: 100%;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$.ajax ({
			url: "/mypage/like_challenge_ajax",
			type: "get",
			data: {
				userid:"jisu"
			},
			dataType: "json",
			success:function(json){
				// console.log(JSON.stringify(json));
			
				let html = "";
				
				let cnt = 0;
				
				const now = new Date();
				
				let todayMonth = now.getMonth() + 1;
				let todayDay = now.getDate();
				
				if(todayMonth < 10) {todayMonth = "0" + todayMonth};
				if(todayDay < 10) {todayDay = "0" + todayDay};
				
				let resultToday = now.getFullYear() + "-" + todayMonth + "-" + todayDay;
				
				if(json.length > 0) {
					
					for(var i=0; i<json.length; i++) {
						
						if(resultToday <= json[i].startdate) {
						
							html += "<div class='card h-100 card_body'>"
								 +  "	<img class='card-img-top' src='" + json[i].thumbnail + "' alt='...' />"
								 +  "	<div class='card-body py-4'>"
								 +  "		<div class='text-center'>"
								 +  "			<h5 class='fw-bolder'>" + json[i].challenge_name + "</h5>"
								 +  "			<div class='challenge_date'>챌린지 기간<span class='challenge_span'>" + json[i].startdate + "~" + json[i].enddate + "</span></div>"
								 +  "		</div>"
								 +  "	</div>"
								 +  "	<div class='card-footer p-2 pt-0 border-top-0 bg-transparent'>"
								 +  "		<div class='text-center'><a class='btn btn-outline-dark mt-auto' href='#'>상세보기</a></div>"
								 +  "	</div>"
								 +  "</div>";
								 
						}
						else {
							cnt++;							
						}
					}
					
					if(cnt == json.length) {
						html = "<div class='no_like_style'>찜한 챌린지가 없거나, 찜한 챌린지의 시작 날짜가 지났습니다.</div>"
							 + "<div class='button_div_style'>"
							 + "	<button type='button' class='go_button_style' onclick='go_challenge();'>챌린지보러가기</button>"
							 + "</div>";
					}
					
				} // end of if(json.length > 0) {} -----
				
				else {
					html = "<div class='no_like_style'>찜한 챌린지가 없거나, 찜한 챌린지의 시작 날짜가 지났습니다.</div>"
						 + "<div class='button_div_style'>"
						 + "	<button type='button' class='go_button_style' onclick='go_challenge();'>챌린지보러가기</button>"
						 + "</div>";
				}
				 
				$("div#position").html(html); 
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
		
	}); // end of $(document).ready(function(){} --------

			
	function go_challenge() {
		
		location.href = "/challenge/challenge_all";
		
	} // end of function go_challenge() {} -----

</script>

	<div id="main_position">
		
		<!-- index 상단 제목 시작 -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h3 mb-0 text-gray-800 font_weight">찜한 챌린지</h1>
		</div>
		<!-- index 상단 제목 끝 -->
		
		<!-- 첫번째 문단 시작 -->
		<div id="position" class="row"></div>
		<!-- 첫번째 문단 끝 -->
		
	</div>
	<!-- 메인 끝 -->

</body>
</html> 
