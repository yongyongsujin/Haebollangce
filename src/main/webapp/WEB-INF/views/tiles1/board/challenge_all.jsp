<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 


<%
   String ctxPath = request.getContextPath();
%>  



<style>

.challenge_title_a {
  width: 100%;
  height: auto;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  margin-top: 80px;
  background-color: white;
}

.challenge_title_b {
  font-weight: 700;
  font-size: 24px;
  line-height: 30px;
  display: flex;
  align-items: center;
  text-align: center;
  letter-spacing: -.4px;
  color: #3498d0;
  margin-bottom: 24px;
}

.challenge_title_c {
  font-weight: 700;
  font-size: 44px;
  line-height: 60px;
  display: flex;
  text-align: center;
  letter-spacing: -.4px;
  white-space: pre-wrap;
  color: #000;
  margin-bottom: 0;
}

.challenge_title_d {
font-weight: 400;
  font-size: 22px;
  line-height: 32px;
  letter-spacing: -.4px;
  color: #383535;
  display: flex;
  align-items: center;
  text-align: center;
}    






.challenge_title_e {
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  background-color: #f4f4f4;
}




.challenge_title_f {
  font-weight: 700;
  font-size: 24px;
  line-height: 30px;
  display: flex;
  align-items: center;
  text-align: center;
  letter-spacing: -.4px;
  color: #3498d0;
  margin-bottom: 24px;
}

.challenge_title_g {
  font-weight: 900;
  font-size: 44px;
  line-height: 60px;
  display: flex;
  text-align: center;
  letter-spacing: -.4px;
  white-space: pre-wrap;
  color: #000;
  margin-bottom: 0;
}

.challenge_title_h {
  font-weight: 700;
  font-size: 24px;
  line-height: 30px;
  display: flex;
  align-items: center;
  text-align: center;
  letter-spacing: -.4px;
  color: #ff8a7a;
  margin-bottom: 24px;
}



.challenge_category {
 list-style-type: none;
 width: auto;
 height: 84px;
 display: flex;
 background-color: #fefefe;
 justify-content: center;
 align-items: center;
 margin: 0;
 overflow-x: auto;
 overflow-y: hidden;
 scroll-behavior: smooth;
 position:sticky;
 top:78px;
 z-index: 2
}

.challenge_category_item {
  position: relative;
  font-weight: 600;
  font-size: 20px;
  line-height: 60px;
  letter-spacing: -1px;
  color: #383535;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
  margin-right: 25px;
  white-space: nowrap;
  cursor: pointer;
  min-height: 78px;
}

.challenge_category__image {
  margin-right: 10px;
  min-width: 15px;
}



.challenge_category_item:before,
.challenge_category_item:after {
  display: inline-block;
  opacity: 0;
  -webkit-transition: -webkit-transform 0.3s, opacity 0.2s;
  -moz-transition: -moz-transform 0.3s, opacity 0.2s;
  transition: transform 0.3s, opacity 0.2s;
}

.challenge_category_item:before {
  margin-right: 10px;
  content: '[';
  -webkit-transform: translateX(20px);
  -moz-transform: translateX(20px);
  transform: translateX(20px);
}

.challenge_category_item:after {
  margin-left: 10px;
  content: ']';
  -webkit-transform: translateX(-20px);
  -moz-transform: translateX(-20px);
  transform: translateX(-20px);
}

.challenge_category_item:hover:before,
.challenge_category_item:hover:after,
.challenge_category_item:focus:before,
.challenge_category_item:focus:after {
  opacity: 1;
  -webkit-transform: translateX(0px);
  -moz-transform: translateX(0px);
  transform: translateX(0px);
}



.All_content__card__a {
  background-color: #f4f4f4;
  width: 100%;
  height: auto;
  margin-left: auto;
  margin-right: auto;
  position: relative;
  overflow: hidden;
  list-style: none;
  padding: 0;
  display: flex;
}

.All_content__card__b {
  height: auto;
  position: relative;
  width: 100%;
  display: flex;
}

.All_content__card__c {
  width: 1536px;
  margin-right: 100px;
  height: auto;
  display: flex;
  justify-content: center;
  flex-shrink: 0;
  position: relative;
  margin-bottom: 50px
  
} 

.All_content__card__d {
  background-color: #f4f4f4;
  display: grid;
  grid-template-columns: repeat(2,571px);
  grid-auto-rows: 215px;
  grid-column-gap: 24px;
  column-gap: 24px;
  grid-row-gap: 24px;
  row-gap: 24px;
  justify-content: center;
  padding-top: 40px;
}


.ChallengeCard_card {
  padding: 20px 16px;
  background-color: #fefefe;
  border-radius: 12px;
  display: flex;
  text-decoration: none;
  margin: 0!important;
  font-family: Pretendard;
  color: -webkit-link;
  cursor: pointer;
}

.ChallengeCard_card_image {
  width: 160px;
  height: 160px;
  border-radius: 16px;
  margin-right: 16px;
  object-fit: cover;
  aspect-ratio: auto 160 / 160;
  overflow-clip-margin: content-box;
  overflow: hidden;
}

.ChallengeCard_info {
  width: calc(100% - 168px);
  display: flex;
  flex-direction: column;
  
}

.ChallengeCard_info__subject {
  display: flex;
  margin-bottom: 20px;
}

a:hover { text-decoration: none;}

.ChallengeCard_tag {
  letter-spacing: -.4px;
  font-size: 15px;
  line-height: 18px;
  padding: 6px 13px;
  border-radius: 16px;
  background-color: #f4f4f4;
  color: #666060;
  display: flex;
  justify-content: center;
  align-items: center;
  font-weight: 600;
  text-align: center;
  margin-right: 6px;
}

.ChallengeCard_info__title {
  font-size: 26px;
  line-height: 28px;
  letter-spacing: -.4px;
  color: #383535;
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
  display: block;
  font-weight: bold;
  margin-bottom: 10px
}

.ChallengeCard_info__describe {
  font-size: 20px;
    line-height: 24px;
    letter-spacing: -.4px;
    font-weight: 400;
    color: #999696;
    display: flex;
    margin-bottom: 20px;
    text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
}

.ChallengeCard_info_calender {
  width: 20px;
  height: 20px;
  margin-top: 2px;
  margin-left: 3.5px;
  margin-right: 3px;
  aspect-ratio: auto 20 / 20;
  overflow-clip-margin: content-box;
  overflow: clip;
}

.ChallengeCard_info_check {
  width: 20px;
  height: 20px;
  margin-top: 2px;
  margin-left: 7px;
  margin-right: 3px;
  aspect-ratio: auto 20 / 20;
  overflow-clip-margin: content-box;
  overflow: clip;
}

.ChallengeCard_info_participants {
  display: flex;
}

.ChallengeCard_participant {
  width: 35px;
  height: 28px;
  border: 4px solid #fefefe;
  left: -2px;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  position: relative;
  border-radius: 100%;
  flex-shrink: 0;
}

.ChallengeCard_participant_image {
  font-size: 16px;
    line-height: 19px;
    font-family: Pretendard;
    font-weight: 400;
    letter-spacing: -.4px;
    color: #999696;
  
  
}

.ChallengeCard_participant_more {
  width: 36px;
  height: 36px;
  left: -36px;
  background-color: #000;
  border-radius: 100%;
  opacity: .5;
  position: relative;
  flex-shrink: 0;
  aspect-ratio: auto 36 / 36;
  overflow-clip-margin: content-box;
  overflow: clip;
}

.ChallengeCard_member {
  margin-left: 8.12px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.ChallengeCard_member_count {
  font-size: 16px;
  line-height: 19px;
  font-family: Pretendard;
  font-weight: 400;
  letter-spacing: -.4px;
  color: #999696;
}

.ChallengeCard_card {
  transition: all 0.6s cubic-bezier(.25,.8,.25,1);
}

.ChallengeCard_card:hover {
  box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
  transform: translate(0, -10px);
  
}


.sa span img {
  -webkit-filter: blur(2px);
  filter: blur(2px);

}

.All_content__card__e span img {
  -webkit-filter: blur(2px);
  filter: blur(2px);

}

.ChallengeCard_card:hover img{
  -webkit-filter: blur(0);
  filter: blur(0);
}


/* Scroll Animation (sa, 스크롤 애니메이션) */
.sa {
  opacity: 0;
  transition: all 0.6s ease;
  display: block;
  width: 571px;
  height: 176px;
  
}

/* 아래에서 위로 페이드 인 */
.sa-up {
  transform: translate(0, -70px);
}

.sa.show {
  opacity: 1;
  transform: none;
}


.Socialing_more {
  width: 180px;
  height: 68px;
  background: #fefefe;
  border-radius: 68px;
  font-weight: 600;
  font-size: 16px;
  line-height: 19px;
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
  letter-spacing: -.4px;
  margin-top: 15px;
  text-decoration: none;
  margin-left: 500px;
  color: inherit; 

}

.Socialing_more__text {
  display: flex;
  align-items: center;
}




.start_challenge {
  text-decoration: none;
  color: white;
  padding: 10px 30px;
  display: inline-block;
  position: relative;
  border: 1px solid rgba(0,0,0,0.21);
  border-bottom: 4px solid rgba(0,0,0,0.21);
  border-radius: 4px;
  text-shadow: 0 1px 0 rgba(0,0,0,0.15);
  background: rgba(102,152,203,1);
  background: -moz-linear-gradient(top, rgba(102,152,203,1) 0%, rgba(92,138,184,1) 100%);
  background: -webkit-gradient(left top, left bottom, color-stop(0%, rgba(102,152,203,1)), color-stop(100%, rgba(92,138,184,1)));
  background: -webkit-linear-gradient(top, rgba(102,152,203,1) 0%, rgba(92,138,184,1) 100%);
  background: -o-linear-gradient(top, rgba(102,152,203,1) 0%, rgba(92,138,184,1) 100%);
  background: -ms-linear-gradient(top, rgba(102,152,203,1) 0%, rgba(92,138,184,1) 100%);
  background: linear-gradient(to bottom, rgba(102,152,203,1) 0%, rgba(92,138,184,1) 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6698cb', endColorstr='#5c8ab8', GradientType=0 );
  -ms-user-select: none; 
  -moz-user-select: -moz-none;
  -khtml-user-select: none;
  -webkit-user-select: none;
  user-select: none;
}

.start_challenge:active   {background: #608FBF;}
</style>
<script>


  $(document).ready(function() {
	
	  
	  
	  
	    
		
	  
	    window.onload = function() {
		  fetchCategories(); // 전체 카테고리를 가져오기 위해 categoryCode를 null로 설정합니다.
		};


		function fetchCategories(categoryCode) {
			  
		      window.scrollTo({top:0, behavior:'smooth'});
		      
		      $.ajax({
		        url: '<%=ctxPath%>/challenge/challengelist',
		        method: 'GET',
		        data: {
		        	categoryCode: categoryCode,
		        },
		        success: function(data) {
		        				    
		        	var container = $('#All_content__card__d');
		        	container.empty(); // 기존 데이터 비우기
		        	// 데이터를 반복하여 HTML 요소를 생성하고 쌓습니다.
		        	for (var key in data) {
		        	  if (data.hasOwnProperty(key)) {
		        	    var items = data[key];
		        	    items.forEach(function(item) {
		        	      var cardDiv = $('<div class="sa sa-up"></div>');
		        	      cardDiv.attr('onclick', 'goView(' + item.challengeCode + ')');
		        	      var cardLink = $('<a class="ChallengeCard_card"></a>');
		        	      var startDate = new Date(item.startDate);
		                  var month = startDate.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해줍니다.
		                  var day = startDate.getDate();
		                  var dayOfWeek = startDate.getDay(); // 요일을 가져옵니다.
		                  var daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
		                  var dayString = daysOfWeek[dayOfWeek];
		        	      // HTML 컨텐츠를 생성하고 요소에 추가합니다.
	                  	 cardLink.append('<span><img src="/images/'+item.thumbnail+'" class="ChallengeCard_card_image"/></span>');
		        	     cardLink.append('<div class="ChallengeCard_info">' +
		        	                     '<div class="ChallengeCard_info__subject">' +
		        	                     '<div class="ChallengeCard_tag">' + item.categoryName + '</div>' +
		        	                     '</div>' +
		        	                     '<div class="ChallengeCard_info__title">' + item.challengeName + '</div>' +
		        	                     '<div class="ChallengeCard_info__describe">' +
		        	                     '챌린지 ·&nbsp;<img alt="info-calender" class="ChallengeCard_info_calender" src="/images/캘린더.png"/>' +
		        	                     '<div style="font-size:18px;">' + month + '.' + day + '('+dayString+')</div> '+ '&nbsp;· '+ item.setDate +   // 월과 일을 화면에 표시합니다.
		        	                     '<img alt="info-check" src="https://images.munto.kr/munto-web/ic_action_check_off_24px.svg?s=48x48" class="ChallengeCard_info_check"/>주' +
		        	                     '<div>' + item.fkDuringType + '</div>' +
		        	                     '회' +
		        	                     '</div>' +
		        	                     '<div class="ChallengeCard_info_participants">' +
		        	                     '<div class="ChallengeCard_participant_image">'+'개설자ID&nbsp; : ' + item.fkUserid + '</div>' +	        	                      
		        	                     '<div class="ChallengeCard_member">' +
		        	                     '&nbsp;&nbsp;<img src="https://images.munto.kr/munto-web/ic_info_person_14px.svg?s=32x32"/>' +
		        	                     '<div class="ChallengeCard_member_count">' + item.memberCount + '명</div>' +
		        	                     '</div>' +
		        	                     '</div>');
		        	      
		        	      // 컨테이너에 생성된 요소를 추가합니다.
		        	      cardDiv.append(cardLink);
		        	      container.append(cardDiv);
		        	    });
		        	  }
		        	}

		        	if(items == null) {
	        		    html = '<div class="challenge_none" id="challenge_none" style="font-size: 30px; color: black; font-weight: bold; margin-top: 70px; margin-bottom: 30px">개설된 챌린지가 없습니다.</div>';
		        	    html += '<div class="start_challeng" type="button" style="font-weight: bold; font-size: 20px; margin-bottom: 30px; margin-left: 60px ">';
		        	    html += '<style>'
		        		html += '.All_content__card__a { background-color: white; }';
		        		html += '.All_content__card__c { background-color: white; }';
		        		html += '.All_content__card__b { background-color: white; }';
		        		html += '.All_content__card__d { background-color: white; padding-top: 0;}';
		        		
		                 html += '</style>'

		        	    html += '</div>';
		        	   
	        	   
	        	     $('#chal_none').append(html);
	        		  
	        	     }
		      		
		        	var categoryElement = document.querySelector('.challenge_title_c');

		        	// 카테고리 클래스 바로 위의 요소를 찾기 위해 previousElementSibling을 사용합니다.
		        	var targetElement = categoryElement.previousElementSibling;

		        	// targetElement가 존재하면 스크롤을 수행합니다.
		        	if (targetElement) {
		        	  targetElement.scrollIntoView({ behavior: 'smooth', block: 'start' });
		        	}
		        	
		          
		          
		          const saDefaultMargin = 0;
		          let saTriggerMargin = 0;
		          let saTriggerHeight = 0;
		          const saElementList = document.querySelectorAll('.sa');

		          const saFunc = function() {
		            for (const element of saElementList) {
		              if (!element.classList.contains('show')) {
		                if (element.dataset.saMargin) {
		                  saTriggerMargin = parseInt(element.dataset.saMargin);
		                } else {
		                  saTriggerMargin = saDefaultMargin;
		                }

		                if (element.dataset.saTrigger) {
		                  saTriggerHeight = document.querySelector(element.dataset.saTrigger).getBoundingClientRect().top + saTriggerMargin;
		                } else {
		                  saTriggerHeight = element.getBoundingClientRect().top + saTriggerMargin;
		                }

		                if (window.innerHeight > saTriggerHeight) {
		                  let delay = (element.dataset.saDelay) ? element.dataset.saDelay : 0;
		                  setTimeout(function() {
		                    element.classList.add('show');
		                  }, delay);
		                }
		              }
		            }
		          }
		          
		          
		          const fadeInElements = document.querySelectorAll('.sa-up');

		          const fadeInOptions = {
		            threshold: 0.5,
		            rootMargin: '0px 0px -100px 0px' // 스크롤 이벤트 발생 시점을 조절하기 위한 여유값
		          };

		          const fadeInObserver = new IntersectionObserver((entries, observer) => {
		            entries.forEach(entry => {
		              if (entry.isIntersecting) {
		                entry.target.classList.add('show');
		                fadeInObserver.unobserve(entry.target);
		              }
		            });
		          }, fadeInOptions);

		          fadeInElements.forEach(element => {
		            fadeInObserver.observe(element);
		          });
		          
		          
		          window.addEventListener('load', saFunc);
		          window.addEventListener('scroll', saFunc);
		          
		          
		        },
		    error: function() {
		      // 에러 처리
		    }
		  });
		}
		
		
		
		
		
		
		
	  
    const saDefaultMargin = 300;
    let saTriggerMargin = 0;
    let saTriggerHeight = 0;
    const saElementList = document.querySelectorAll('.sa');

    const saFunc = function() {
      for (const element of saElementList) {
        if (!element.classList.contains('show')) {
          if (element.dataset.saMargin) {
            saTriggerMargin = parseInt(element.dataset.saMargin);
          } else {
            saTriggerMargin = saDefaultMargin;
          }

          if (element.dataset.saTrigger) {
            saTriggerHeight = document.querySelector(element.dataset.saTrigger).getBoundingClientRect().top + saTriggerMargin;
          } else {
            saTriggerHeight = element.getBoundingClientRect().top + saTriggerMargin;
          }

          if (window.innerHeight > saTriggerHeight) {
            let delay = (element.dataset.saDelay) ? element.dataset.saDelay : 0;
            setTimeout(function() {
              element.classList.add('show');
            }, delay);
          }
        }
      }
    }
    
    
    const fadeInElements = document.querySelectorAll('.sa-up');

    const fadeInOptions = {
      threshold: 0.5,
      rootMargin: '0px 0px -100px 0px' 
    };

    const fadeInObserver = new IntersectionObserver((entries, observer) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('show');
          fadeInObserver.unobserve(entry.target);
        }
      });
    }, fadeInOptions);

    fadeInElements.forEach(element => {
      fadeInObserver.observe(element);
    });
    
    
    
    window.addEventListener('load', saFunc);
    window.addEventListener('scroll', saFunc); 
    	
	
    
    $(".challenge_category_item").click(function() {
	      var categoryCode = $(this).data("category_code");
	      
	      window.scrollTo({middle:0, behavior:'smooth'});
	      
	      $.ajax({
	        url: '<%=ctxPath%>/challenge/challengelist',
	        method: 'GET',
	        data: {
	        	categoryCode: categoryCode,
	            
	        },
	        success: function(data) {
	        	var container = $('#All_content__card__d');
	        	
	        	container.empty();
	        	var html = "";
	        	$('#chal_none').html("");

	        	for (var key in data) {
	        	  if (data.hasOwnProperty(key)) {
	        		 var items = data[key];
	        	    console.log(items);
	        	    
	        	    
	        	    items.forEach(function(item) {
	        	      var cardDiv = $('<div class="sa sa-up" data-></div>');
	        	      cardDiv.attr('onclick', 'goView(' + item.challengeCode + ')');
	        	      var cardLink = $('<a class="ChallengeCard_card"></a>');
	        	      

	        	      var startDate = new Date(item.startDate);
	                  var month = startDate.getMonth() + 1; 
	                  var day = startDate.getDate();
	                  var dayOfWeek = startDate.getDay(); 
	                  var daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
	                  var dayString = daysOfWeek[dayOfWeek];

	                  cardLink.append('<span><img src="/images/'+item.thumbnail+'" class="ChallengeCard_card_image"/></span>');
	        	      cardLink.append('<div class="ChallengeCard_info">' +
	        	                      '<div class="ChallengeCard_info__subject">' +
	        	                      '<div class="ChallengeCard_tag">' + item.categoryName + '</div>' +
	        	                      '</div>' +
	        	                      '<div class="ChallengeCard_info__title">' + item.challengeName + '</div>' +
	        	                      '<div class="ChallengeCard_info__describe">' +
	        	                      '챌린지 ·&nbsp;<img alt="info-calender" class="ChallengeCard_info_calender" src="/images/캘린더.png"/>' +
	        	                      '<div style="font-size:18px;">' + month + '.' + day + '('+dayString+')</div> '+ '&nbsp;· '+ item.setDate +   // 월과 일을 화면에 표시합니다.
	        	                      '<img alt="info-check" src="https://images.munto.kr/munto-web/ic_action_check_off_24px.svg?s=48x48" class="ChallengeCard_info_check"/>주' +
	        	                      '<div>' + item.fkDuringType + '</div>' +
	        	                      '회' +
	        	                      '</div>' +
	        	                      '<div class="ChallengeCard_info_participants">' +
	        	                      '<div class="ChallengeCard_participant_image">'+'개설자ID&nbsp; : ' + item.fkUserid + '</div>' +	        	                      
	        	                      '<div class="ChallengeCard_member">' +
	        	                      '&nbsp;&nbsp;<img src="https://images.munto.kr/munto-web/ic_info_person_14px.svg?s=32x32"/>' +
	        	                      '<div class="ChallengeCard_member_count">' + item.memberCount + '명</div>' +
	        	                      '</div>' +
	        	                      '</div>');
	        	      
	        	      // 컨테이너에 생성된 요소를 추가합니다.
	        	      cardDiv.append(cardLink);
	        	      container.append(cardDiv);
					
	        	      
	        	      
	        	    });
	        	  }
  
	        	}
	        	
	        	
				
				if(items == null) {
	        		    html = '<div class="challenge_none" id="challenge_none" style="font-size: 30px; color: black; font-weight: bold; margin-top: 70px; margin-bottom: 30px">개설된 챌린지가 없습니다.</div>';
		        	    html += '<div class="start_challeng" type="button" style="font-weight: bold; font-size: 20px; margin-bottom: 30px; margin-left: 60px ">';
		        	    html += '<style>'
		        		html += '.All_content__card__a { background-color: white; }';
		        		html += '.All_content__card__c { background-color: white; }';
		        		html += '.All_content__card__b { background-color: white; }';
		        		html += '.All_content__card__d { background-color: white; padding-top: 0;}';
		        		
		                 html += '</style>'

		        	    html += '</div>';
		        	   
	        	   
	        	    $('#chal_none').append(html);
	        		  
	        	  }
	        		
	        	
	        	var categoryElement = document.querySelector('.challenge_title_d');

	        	// 카테고리 클래스 바로 위의 요소를 찾기 위해 previousElementSibling을 사용합니다.
	        	var targetElement = categoryElement.previousElementSibling;

	        	// targetElement가 존재하면 스크롤을 수행합니다.
	        	if (targetElement) {
	        	  targetElement.scrollIntoView({ behavior: 'smooth', block: 'start' });
	        	}
	          
	          
	          const saDefaultMargin = 300;
	          let saTriggerMargin = 0;
	          let saTriggerHeight = 0;
	          const saElementList = document.querySelectorAll('.sa');

	          const saFunc = function() {
	            for (const element of saElementList) {
	              if (!element.classList.contains('show')) {
	                if (element.dataset.saMargin) {
	                  saTriggerMargin = parseInt(element.dataset.saMargin);
	                } else {
	                  saTriggerMargin = saDefaultMargin;
	                }

	                if (element.dataset.saTrigger) {
	                  saTriggerHeight = document.querySelector(element.dataset.saTrigger).getBoundingClientRect().top + saTriggerMargin;
	                } else {
	                  saTriggerHeight = element.getBoundingClientRect().top + saTriggerMargin;
	                }

	                if (window.innerHeight > saTriggerHeight) {
	                  let delay = (element.dataset.saDelay) ? element.dataset.saDelay : 0;
	                  setTimeout(function() {
	                    element.classList.add('show');
	                  }, delay);
	                }
	              }
	            }
	          }
	          
	          
	          const fadeInElements = document.querySelectorAll('.sa-up');

	          const fadeInOptions = {
	            threshold: 0.5,
	            rootMargin: '0px 0px -100px 0px' // 스크롤 이벤트 발생 시점을 조절하기 위한 여유값
	          };

	          const fadeInObserver = new IntersectionObserver((entries, observer) => {
	            entries.forEach(entry => {
	              if (entry.isIntersecting) {
	                entry.target.classList.add('show');
	                fadeInObserver.unobserve(entry.target);
	              }
	            });
	          }, fadeInOptions);

	          fadeInElements.forEach(element => {
	            fadeInObserver.observe(element);
	          });
	          
	          
	          window.addEventListener('load', saFunc);
	          window.addEventListener('scroll', saFunc);
	        	
	        	
	          
	        },
	        error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
	      });
	    });
	   
    
    
    });// end of $(document).ready(function()--------------------
  	
    function goView(challengeCode) {
		 location.href = "<%= ctxPath%>/challenge/challengeView?challengeCode="+challengeCode; 
	}		
    		
  
</script>


   
<div class="challenge_title_a">

  <div class="challenge_title_b" style="margin-top: 20px">
      <img src="https://images.munto.kr/munto-web/ic_info_challengeleader_16px.svg"/>챌린지
  </div>
  <div class="challenge_title_c">같은 목표를 가진<br/>멤버들과 함께 도전해요
  </div>
  <div class="challenge_title_d" style="margin-bottom: 20px">
      혼자 하기 어려운 큰 목표부터 작은 목표까지<br/>멤버들과 함께 즐기면서 쉽게 달성해요!
  </div>
  
  <div class="start_challenge" type="button" style="font-weight: bold; font-size: 20px; margin-bottom: 30px; ">
  						
	<a href="<%= ctxPath%>" style="color: inherit;">챌린지 개설하기</a>
    	    
  </div>
		        	   
 
   
	

	<c:if test="${not empty requestScope.challengeList}">
	<ul class=challenge_category  style="border-bottom:3px dashed #3498d0;" >
		<li class="challenge_category_item" >전체</li>				
		<c:forEach var="cavo" items="${requestScope.categoryList}">
		
			<c:choose>
				<c:when test="${cavo.categoryCode == 1}">
					<li class="challenge_category_item" data-category_code="1"><img src="https://images.munto.kr/munto-web/culture_icon.svg" class="challenge_category__image">${cavo.categoryName}</li>
				</c:when>
				
				<c:when test="${cavo.categoryCode == 2}">
					<li class="challenge_category_item" data-category_code="2"><img src="https://images.munto.kr/munto-web/activite_icon.svg" class="challenge_category__image">${cavo.categoryName}</li>
				</c:when>
				
				<c:when test="${cavo.categoryCode == 3}">
				<li class="challenge_category_item" data-category_code="3"><img src="https://images.munto.kr/munto-web/food_icon.svg" class="challenge_category__image">${cavo.categoryName}</li>
				</c:when>
				
				<c:when test="${cavo.categoryCode == 4}">
				<li class="challenge_category_item" data-category_code="4"><img src="https://images.munto.kr/munto-web/hobby_icon.svg" class="challenge_category__image">${cavo.categoryName}</li>
				</c:when>
				
				<c:when test="${cavo.categoryCode == 5}">
				<li class="challenge_category_item" data-category_code="5"><img src="https://images.munto.kr/munto-web/trip_icon.svg" class="challenge_category__image">${cavo.categoryName}</li>
				</c:when>
				
				<c:when test="${cavo.categoryCode == 6}">
				<li class="challenge_category_item" data-category_code="6"><img src="https://images.munto.kr/munto-web/growth_icon.svg" class="challenge_category__image">${cavo.categoryName}</li>
				</c:when>
				
				<c:when test="${cavo.categoryCode == 7}">
				<li class="challenge_category_item" data-category_code="7"><img src="https://images.munto.kr/munto-web/icon_category_peer.svg" class="challenge_category_image">${cavo.categoryName}</li>
				</c:when>
				
				<c:when test="${cavo.categoryCode == 8}">
				<li class="challenge_category_item" data-category_code="8"><img src="https://images.munto.kr/munto-web/icon_category_blind-date.svg" class="challenge_category_image">${cavo.categoryName}</li>
				</c:when>

			</c:choose>
		</c:forEach>
	</ul>
		
		<div id="chal_none">
        
        </div>
		
        
		<div class="All_content__card__a " id="All_content__card__a" style="background-color: #f4f4f4">
		<div class="All_content__card__b" >
		<div class="All_content__card__c" style="background-color: #f4f4f4">
		<div class="All_content__card__d" id="All_content__card__d" >
		</div>
		</div>
		</div>
		</div>
		
		
		
    </c:if>     	 
      	

 

     
      
  

  