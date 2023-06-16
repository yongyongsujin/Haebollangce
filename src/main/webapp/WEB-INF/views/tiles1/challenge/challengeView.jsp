<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<% String ctxPath = request.getContextPath();
	// /challenge
%>

    
    <!-- Font Awesome 5 Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style type="text/css">

	html, body{
		height: 90%;
	}
	
	.detail_challenge_template{ display: flex;
							    align-items: center;
							    flex-direction: column;
							    border: 1px gray solid; 
							    max-width: 1200px;
							    width: 80%;
							    height: 90%;
							    margin: 0 auto;}
	div {
		border: 0px gray solid; 
		}
		
	.detail_challenge_content {
		width: 100%; 
		position:relative;
    		display: flex;
    		justify-content: center;
    		align-items: center;
    		flex-direction: column;
		
	}				
	
	.Main_template {
		width: 100%;
    		height: auto;
    		display: flex;
    		justify-content: center;
    		align-items: center;
    		flex-direction: column;
    		position: relative;
    		background-color: #f4f4f4;
	}			    
	
	.challenge_main_image {
		height: 400px;
		object-fit: cover;
		width:100%;
		
	}
	
	.Main_content {
		display: flex;
	    justify-content: center;
	    align-items: center;
	    flex-direction: column;
	    background-color: #fefefe;
	    position: relative;
	    width: calc(100% - 28px);
	    border-radius: 16px;
	    top: -100px;
    		height: 300px;
    		overflow: inherit;
	    
	}
	
	.Main_content_Host_image {
		width: 150px;
    		height: auto;
	    object-fit: cover;
	    position: relative;
	    margin-top: -60px;
	}
	
	.Host_img {
		display: flex;
		width: 100px;
    		height: 100px;
    		align-items: center;
    		object-fit: cover;
   		border-radius: 50%;
   		margin: auto;
   		border: solid 1px gray;
	}
	
	.Host_name {
		font-family: Pretendard;
    		font-weight: bold;
    		font-size: 20px;
	    line-height: 12px;
	    text-align: center;
	    letter-spacing: -.2px;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    color: #383535;
	    white-space: nowrap;
	    margin-top: 10px;
	}
	
	.Main_content_title {
		font-family: Pretendard;
		width: 90%;
	    font-style: normal;
	    font-weight: 600;
	    font-size: 35px;
	    text-align: center;
	    margin-top: 40px;
	}
	
	.challenge_frequency {
		margin-top: 10px;
		font-size: 20px;
	}
	
	.Commenter_introduce {
		margin-top: -85px;
		position: relative;
	    width: calc(100% - 28px);
	    height: auto;
	    background-color: #f4f4f4;
	    padding: 8px 14px 41px;
	    color: #383535;
	    font-size: 16px;
	    line-height: 26px;
	    letter-spacing: -.6px;
	    font-weight: 400;
	    font-family: Pretendard;
	}
	
	.Commenter_introduce_content {
		display: inline;
	    height: auto;
	    white-space: pre-line;
	}
	
	.Info_template {
		width: 100%;
    		height: auto;
	    display: flex;
	    margin-top: 15px;
	    justify-content: center;
	    align-items: center;
	    flex-direction: column;
	    position: relative;
	    background-color: #f4f4f4;
	    font-family: Pretendard;
	}
	
	.Info_certification {
		width: calc(100% - 28px);
	    display: flex;
	    flex-direction: column;
	    padding: 0 14px;
	    align-items: center;
	}
	
	.Info_certification_introduce {
		font-weight: 600;
	    font-size: 18px;
	    line-height: 33px;
	    height: auto;
	    letter-spacing: -.4px;
	    float: left;
	    color: #242424;
	    text-align: center;
	}
	.Info_certification_How {
		display: flex;
		width: 35%;
		justify-content: center;
	    align-items: center;
	    height: auto;
	    border-radius: 16px;
	    background-color: black;
	    color: white; 
	    font-size: 18px;
	    font-weight: bold;
	    line-height: 30px;
	    text-align: center;
	    margin-top: 20px;
	    margin-bottom: 20px;
	    padding: 5px;
		
	}
	
	.Info_notification {
	    width: calc(100% - 28px);
	    height: auto;
	    display: flex;
	    flex-direction: column;
	    padding: 0 14px;
	    margin-top: 55px;
	    margin-bottom: 40px;
	    letter-spacing: -.4px;
	}
	
	.Info_notification__title {
	    font-weight: bold;
    		font-size: 20px;
    		line-height: 40px;
    		color: #f43630;
    		letter-spacing: 1px;
    		float: left;
	}
	
	.Info_notification__introduce {
		font-weight: 600;
    		font-size: 18px;
    		line-height: 33px;
    		float: left;
    		color: #242424;
    		border-bottom: 2px solid;
	}
	
	.Info_notification__detail {
	    margin-top: 5px;
	    display: flex;
	    justify-content: flex-start;
	    flex-direction: column;
	    letter-spacing: -.4px;
	}
	
	.Info_memberCount {
		display: flex;
    		align-items: center;
    		margin-bottom: 7px;
    		letter-spacing: -.4px;
	}
	
	.Info_memberCount_info {
		font-weight: 400;
	    font-size: 20px;
	    line-height: 26px;
	    letter-spacing: -.4px;
	    color: #383535;
	    height: 21px;
	    white-space: pre-line;
	    margin-bottom: 3px;
	    margin-left: 10px;
	}
	
	.Banner_baner {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    width: 100%;
		    border: 0;
		    border-radius: 0;
		    margin: 0 auto;
		    left: 0;
		    right: 0;
		    height: 74px;
		    position: fixed;
		    border-radius: 9px;
		    bottom: -2px;
		    z-index: 999;
		    
	}
	
	.banner_content {
		    max-width: 600px;
		    width: 100%;
		    padding: 0 12px;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    height: calc(100% - 26px);
		    
	}
	
	.challenge_join {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    width: 50%;
		    height: 48px;
		    background-color: #f43630;
		    color: #fff;
		    font-weight: 600;
		    font-size: 16px;
		    line-height: 24px;
		    letter-spacing: -.4px;
		    border: 0;
		    border-radius: 40px;
	}
	
	.Info_certifyTime, .Info_startDate, .Info_challengeTerm {
		display: flex;
	}
	
	.square-image-container {
		border: 1px gray solid; 
		background-color : #cccccc;
        position: relative;
        width: 100%;
        padding-bottom: 100%;
        overflow: hidden;
        border-radius: 12px 12px 0 0;
    }
    .square-image-inner {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .square-image-inner img {
        max-width: 100%;
        max-height: 100%;
        object-fit: contain;
    }
    
	

</style>

<script type="text/javascript">

		function participate() { // 참가하기 클릭시 
			
			if("${userid}" != "") {
				location.href='<%= ctxPath%>/challenge/join?challenge_code='+${challengedto.challengeCode};
			}
			else {
				location.href='<%= ctxPath%>/user/login';
			}
		}
		
		function challdel() {
		      
		      location.href='<%= ctxPath%>/challenge/challengedel?challengeCode='+${challengedto.challengeCode};
		      
		} 
		

</script>

<div class="detail_challenge_template">
		<div class="detail_challenge_content">
			<div class="Main_template">
				<img src="<%= ctxPath%>/images/${challengedto.thumbnail}" alt="챌린지 메인 이미지" class="challenge_main_image">
				
				<div class="Main_content">
					<div class="Main_content_Host_image">
						<a>
								 <img class="Host_img" alt="방장 사진" src="<%= ctxPath%>/images/${challengedto.profilePic}"> 
						</a>
						<div class="Host_name">${challengedto.fkUserid}</div>
					</div>
					<div class="Main_content_title">${challengedto.challengeName}
						<c:if test="${likecount != 1}">
						<i id="not_like" class="far fa-bookmark" data-likeyn="${likecount}" style="float: right; color: #db4d4d; cursor: pointer;" onclick="likeadd('${challengedto.challengeCode}', 'not_like')"></i>
						<i id="like" class="fas fa-bookmark" data-likeyn="${likecount}" style="float: right; color: #db4d4d; cursor: pointer; display: none;" onclick="likeadd('${challengedto.challengeCode}', 'like')"></i>
						</c:if>
						
						<c:if test="${likecount == 1}">
						<i id="like" class="fas fa-bookmark" data-likeyn="${likecount}" style="float: right; color: #db4d4d; cursor: pointer;" onclick="likeadd('${challengedto.challengeCode}', 'like')"></i>
						<i id="not_like" class="far fa-bookmark" data-likeyn="${likecount}" style="float: right; color: #db4d4d; cursor: pointer; display: none;" onclick="likeadd('${challengedto.challengeCode}', 'not_like')"></i>
						</c:if>
						
					</div>
					
					<div class="challenge_frequency">${challengedto.frequency}</div>
					<div class="Info_notification__detail">
						<div class="Info_memberCount">
							<i class="fas fa-users fa-2x" style="color: #db4d4d;"></i>
						<div class="Info_memberCount_info">${challengedto.memberCount} 명</div>
					</div>
				</div>
				<div class="edit_delete"  style="float: right; width:95%;">
					<c:if test="${userid == challengedto.fkUserid && challengedto.checkDate > 0}">
						 <i class="fa-regular fa-trash-can btn btnDelete" style="color:gray; float: right;" onclick="challdel()">&nbsp;챌린지 삭제하기</i>
					</c:if>	
				</div>
			</div>
			<div class="Commenter_introduce">
				<div class="Commenter_introduce_content">
					${challengedto.content}
				</div>
			</div>
		</div>
		
		<div class="Info_template">
			<div class="Info_certification">
				<div class="Info_certification_introduce">
				이렇게 인증해주세요
				</div>
				<div class="Info_certification_How">
				${challengedto.example}
				</div>
				
				<div class="row justify-content-around" style="height: auto; display: flex; width: 100%;">

	                 <div class="col-lg-5">
					    <div class="square-image-container">
					        <div class="square-image-inner">
					            <img class="img-fluid" src="<%= ctxPath%>/images/${challengedto.successImg}" alt="인증성공예시" />
					        </div>
					    </div>
					    <div style="height: 30px; margin-top: -5px; background-color:green; color:white; text-align:center; line-height: 30px; font-size:15pt; border-radius: 0 0 12px 12px;">O</div>
					    <div style="text-align: center; font-weight: bold;">올바른 인증 사진</div>
					</div>
					
					<div class="col-lg-5">
					    <div class="square-image-container">
					        <div class="square-image-inner">
					            <img class="img-fluid" src="<%= ctxPath%>/images/${requestScope.challengedto.failImg}" alt="인증실패예시" />
					        </div>
					    </div>
					    <div style="height: 30px; margin-top: -5px; background-color:red; color:white; text-align:center; line-height: 30px; font-size:15pt; border-radius: 0 0 12px 12px;">X</div>
					    <div style="text-align: center; font-weight: bold;">잘못된 인증 사진</div>
					</div>
	         
  
			    </div>
				
			</div>
			
			<div class="Info_notification">
				<div class="Info_notification__title">안내사항</div>
				<div class="Info_notification__introduce">자세한 정보를 알려드릴게요</div>
				<br>
				<div class="Info_certifyTime">
				<i class="far fa-clock" style="color: #db4d4d; padding-top:5px;"></i>
				<div class="Info_certifyTime_info">&nbsp;인증가능시간 : ${challengedto.hourStart} ~ ${challengedto.hourEnd}</div>
				</div>
				
				<div class="Info_startDate">
				<i class="fas fa-calendar-day" style="color: #db4d4d; padding-top:5px;"></i>
				<div class="Info_startDate_info">&nbsp;시작일 : ${challengedto.startDate}</div>
				</div>
				
				<div class="Info_challengeTerm">
				<i class="far fa-calendar-alt" style="color: #db4d4d;  padding-top:5px;"></i>
				<div class="Info_startDate_info">&nbsp;챌린지 기간 : ${challengedto.startDate} ~ ${challengedto.enddate} 까지</div>
				</div>
		</div>
		<div>
			<input type="hidden" id="userid" value="${userid}">
			<input type="hidden" id="challengeCode" value="${challengedto.challengeCode}">
		</div>
		
		<div class="Banner_baner">
		
			
			<div class="banner_content">

				<c:if test="${userid == '' || challengedto.checkJoinUser != 1}">
					<button class="challenge_join" type="button" onclick="participate()">챌린지 참가</button>
				</c:if>
				
				<c:if test="${userid != '' && challengedto.checkJoinUser != 0}">
					<button class="challenge_join" type="button" onclick="location.href='<%=ctxPath%>/challenge/certify?challenge_code=${challengedto.challengeCode}'">챌린지 인증하기</button>
				</c:if>

			</div>

		</div>	
	</div>
  	</div>
	</div>   
<script>

	//전역 변수로 선택된 아이콘을 저장할 변수 선언
	let selectedIcon = "";
	
	function likeadd(challengeCode, iconId) {
		
		  selectedIcon = document.getElementById(iconId); // like / not_like
		  var otherIcon = (iconId === "like") ? document.getElementById("not_like") : document.getElementById("like");
		  
		  // 선택된 아이콘에 대한 처리 로직 작성
		  if (selectedIcon.style.display === "none") {
		    // 선택된 아이콘이 숨겨져 있는 경우
		    // 선택된 아이콘을 보이도록 설정하고, 다른 아이콘을 숨깁니다.
		    selectedIcon.style.display = "inline";
		    otherIcon.style.display = "none";
		  } else {
		    // 선택된 아이콘이 보이는 경우
		    // 선택된 아이콘을 숨기고, 다른 아이콘을 보이도록 설정합니다.
		    selectedIcon.style.display = "none";
		    otherIcon.style.display = "inline";
		  }
		  
		  /* var data = document.getElementById('like');*/
		  
		  
		  /* likeyn = data.dataset.likeyn; */
		  
		  console.log(selectedIcon);
		  
		}
	
	window.onbeforeunload = function() {
		  // 아이콘 상태에 따라 서버에 AJAX 요청을 보내고 DB 작업을 처리하는 로직 작성
		  /* var likeIcon = document.getElementById('like');
		  var notLikeIcon = document.getElementById('not_like');
		   */
		  let likeyn = "";
		  
		  likeyn = ${likecount}; // DB에 있는 like값 (있으면 1, 없으면 0)
	      console.log(likeyn); 
		   
		  if(selectedIcon == "") {
			  // 아무것도 안하면 그냥 리턴
			  return;
		  } 
		  else {
				if ( (likeyn == 1 && selectedIcon.id == "not_like") ||
					 (likeyn == 0 && selectedIcon.id == "like") ) {
					return;
				}
				else if ( ( selectedIcon.id == "not_like" ) ) {
					// insert 로 가기
					
					$.ajax({
						url:"<%= ctxPath%>/challenge/challengelikeadd",
						data:{"userid":"${userid}",
							  "challengeCode":"${challengedto.challengeCode}"},
					    type:"post",
		  	    			dataType:"json",
		  	    			success:function(json){
		  	    				console.log("북마크 변경 완료");
		  	    			},
					    error: function(request, status, error){
		             		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		          	    }	  
					});
					
				}
				else if ( (selectedIcon.id == "like") ) {
					// delete 로 가기
					$.ajax({
						url:"<%= ctxPath%>/challenge/likedelete",
						data:{"userid":"${userid}",
							  "challengeCode":"${challengedto.challengeCode}"},
					    type:"post",
		  	    			dataType:"json",
		  	    			success:function(json){
		  	    				console.log("북마크 변경 완료");
		  	    			},
					    error: function(request, status, error){
		             		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		          	    }	  
					});
				}
			  
		  }
	};
	
	
	
	

</script> 
