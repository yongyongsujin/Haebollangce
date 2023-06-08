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
	
	div#position {
		background-color:white; 
		padding: 54px 1% 54px 4%;
	}
	
	div.card_position {
		min-height: 400px;
	}
	
	div.img_style {
		border-radius:60%; 
		width:35px;
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
				
				if(json.length > 0) {
					
					for(var i=0; i<json.length; i++) {
						
						html = "<div class='col-md-3 col-sm-6'>"
							 + "	<div class='card p-3 mb-5 card_position'>"
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
						
						$("div#position").append(html);
					}
					
				} // end of if(json.length > 0) {} -----
				
				else {
					html += "등록된 관심태그가 없습니다."
					
					$("div#position").html(html); 
				}
				 
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
		
		
			
	}); // end of $(document).ready(function(){} --------


</script>

	<div id="main_position">
		
		<!-- index 상단 제목 시작 -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h3 mb-0 text-gray-800">좋아요 누른 라운지글</h1>
		</div>
		<!-- index 상단 제목 끝 -->
		
		<!-- 첫번째 문단 시작 -->
		<div id="position" class="row"></div>
		<!-- 첫번째 문단 끝 -->
		
	</div>
	<!-- 메인 끝 -->

</body>
</html> 
