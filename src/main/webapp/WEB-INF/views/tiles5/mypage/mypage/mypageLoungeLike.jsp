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
		padding: 54px 5% 54px 5%;
	}
	
	div.card_position {
		min-height: 400px;
	}
	
	img.img_style {
		border-radius:60%; 
		width:35px;
		object-fit: cover;
	}
	
	div.card_style {
		border: solid 1px gray;
	}
	
	div.no_like_style {
		padding: 14% 39%;
		font-size: 15pt;
	}
	
	button.button_style {
		margin: 17% 18% 0 18%;
		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 5% 5%;
		text-align: center;
		transition: 0.3s;
		border-radius: 35px;
	}
	
	button.button_style:hover {
		background-color: #f43630;
		color: white;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$.ajax ({
			url: "/mypage/like_lounge_ajax",
			type: "get",
			data: {
				"userid":"sudin"
			},
			dataType: "json",
			success:function(json){
				// console.log(JSON.stringify(json));
			
				let html = "";
				
				let cnt = "";
				
				if(json.length > 0) {
					
					for(var i=0; i<json.length; i++) {
						
						html = "<div class='col-md-3 col-sm-6'>"
							 + "	<div class='card p-3 mb-5 card_position card_style'>"
							 + "		<div class='d-flex justify-content-between'>"
							 + "			<div class='d-flex flex-row align-items-center'>"
							 + "				<div><img class='img_style' src='<%= ctxPath%>/images/" + json[i].profile_pic + "' /></div>"
							 + "				<div class='c-details'>"
							 + "					<h6 class='mb-0 ml-2'>" + json[i].name + "</h6> "
							 + "				</div>"
							 + "			</div>"
							 + "		</div>"
							 + "	<div class='mt-3' onclick='goView(" + json[i].seq + ")' style='cursor:pointer;'>"
							 + "		<img style='width:100%;' src='<%= ctxPath%>/images/" + json[i].filename + "' />"
							 + "		<div class='mt-2'>"
							 + "			<div class='lgcontent'>" + json[i].subject + "</div>"
							 + "			<div class='mt-3'>"
							 + "				<span class='text1'>"
							 + "					<img src='https://images.munto.kr/munto-web/ic_action_like-empty-black_30px.svg?s=32x32'/>" + json[i].likeCount
							 + "					<span class='text2'>"
							 + "						<img src='https://images.munto.kr/munto-web/ic_action_comment_30px.svg?s=32x32'/>" + json[i].commentCount
							 + "					</span>"
							 + "					<img src='https://images.munto.kr/munto-web/info_group.svg?s=32x32'/>" + json[i].readCount
							 + "				</span>"
							 + "			</div>"
							 + "		</div>"
							 + "	</div>"
							 + "</div>"
							 + "</div>";
						
					}
					
				} // end of if(json.length > 0) {} -----
				
				else {
					html += "<div class='no_like_style'>좋아요를 누른 라운지글이 없습니다.<div>"
						 +  "<button type='button' class='button_style' onclick='go_lounge();'>라운지 글 보러가기</button>"
					
				}
				
				$("div#position").html(html); 
				 
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
		
	}); // end of $(document).ready(function(){} --------

	function go_lounge() {
		
		location.href = "/lounge/loungeAdd";
		
	} // end of function go_lounge() {} -----

</script>

	<div id="main_position">
		
		<!-- index 상단 제목 시작 -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h3 mb-0 text-gray-800 font_weight">좋아요 누른 라운지글</h1>
		</div>
		<!-- index 상단 제목 끝 -->
		
		<!-- 첫번째 문단 시작 -->
		<div id="position" class="row"></div>
		<!-- 첫번째 문단 끝 -->
		
	</div>
	<!-- 메인 끝 -->

</body>
</html> 
