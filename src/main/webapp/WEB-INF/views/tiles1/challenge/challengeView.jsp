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
							    max-width: 2000px;
							    width: 80%;
							    height: 90%;
							    margin: 0 auto;}
	div {
		border: 1px gray solid; 
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
    		height: 250px;
	    
	}
	
	.Main_content_Host_image {
		width: 150px;
    		height: auto;
	    object-fit: cover;
	    position: relative;
	    margin-top: -30px;
	}
	
	.Host_img {
		display: flex;
		width: 100px;
    		height: 100px;
    		align-items: center;
    		object-fit: cover;
   		border-radius: 50%;
   		margin: auto;
	}
	
	.Host_name {
		font-family: Pretendard;
    		font-weight: bold;
    		font-size: 14px;
	    line-height: 12px;
	    text-align: center;
	    letter-spacing: -.2px;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    color: #383535;
	    height: 40px;
	    white-space: nowrap;
	    margin-top: 10px;
	}
	
	.Main_content_title {
		font-family: Pretendard;
		width: fit-content;
	    font-style: normal;
	    font-weight: 600;
	    font-size: 25px;
	    text-align: center;
	    margin-top: 20px;
	}
	
	.challenge_frequency {
		margin-top: 10px;
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
		    border-top: 1px solid #f4f4f4;
		    
	}
	
	.challenge_join {
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    width: 100%;
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
	
	

</style>

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
					<div class="Main_content_title">${challengedto.challengeName}</div>
					<div class="challenge_frequency">${challengedto.frequency}</div>
					<div class="Info_notification__detail">
						<div class="Info_memberCount">
							<i class="fas fa-users fa-2x" style="color: #db4d4d;"></i>
						<div class="Info_memberCount_info">${challengedto.memberCount} 명</div>
					</div>
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

	                 <div class="col-lg-3">
	                 <img class="img-fluid" src="<%= ctxPath%>/images/${challengedto.successImg}" style=" width: 100%; height: 200px; object-fit: cover; border-radius: 12px 12px 0 0;" alt="인증성공예시" />
	                 <div style="height: 30px; margin-top: -5px; background-color:green; color:white; text-align:center;  line-height: 30px; font-size:15pt; border-radius: 0 0 12px 12px;">O</div>
					 </div>

	                 <div class="col-lg-3">
	                 <img class="img-fluid" src="<%= ctxPath%>/images/${requestScope.challengedto.failImg}" style="width: 100%; height: 200px; object-fit: cover; border-radius: 12px 12px 0 0;" alt="인증실패예시" />
	                 <div style="height: 30px; margin-top: -5px; background-color:red; color:white; text-align:center;  line-height: 30px; font-size:15pt; border-radius: 0 0 12px 12px;">X</div>
	                 </div>
  
			    </div>
				
			</div>
			
			<div class="Info_notification">
				<div class="Info_notification__title">안내사항</div>
				<div class="Info_notification__introduce">자세한 정보를 알려드릴게요</div>
				
				<div class="Info_certifyTime">
				<i class="far fa-clock" style="color: #db4d4d;"></i>
				<div class="Info_certifyTime_info">인증가능시간 : ${challengedto.hourStart} ~ ${challengedto.hourEnd}</div>
				</div>
				
				<div class="Info_startDate">
				<i class="far fa-clock" style="color: #db4d4d;"></i>
				<div class="Info_startDate_info">시작일 : ${challengedto.startDate}</div>
				</div>
				
				<div class="Info_challengeTerm">
				<i class="far fa-clock" style="color: #db4d4d;"></i>
				<div class="Info_startDate_info">챌린지 기간 : ${challengedto.startDate} ~ ${challengedto.enddate}</div>
				</div>
		</div>
		
		<div class="RecommendSwipe_template">
		
		
		
		</div>
		
		<div class="Banner_baner">
		
			<div class="banner_content">
				<button class="challenge_join" type="button">챌린지 참가</button>
			</div>
			
		</div>	
	</div>
  </div>
</div>    