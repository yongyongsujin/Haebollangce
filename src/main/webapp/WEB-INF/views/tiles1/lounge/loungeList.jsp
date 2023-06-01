<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>   

<style type="text/css">
	
	div.lgcontent {
		overflow: hidden;
	    text-overflow: ellipsis;
	    display: -webkit-box;
	    -webkit-line-clamp: 3; /* 라인수 */
	    -webkit-box-orient: vertical;
	    word-wrap:break-word; 
	    line-height: 1.2em;
	    height: 3.6em; /* line-height 가 1.2em 이고 3라인을 자르기 때문에 height는 1.2em * 3 = 3.6em */
	}

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		
	});// end of $(document).ready(function(){})-------------------------------

  
	// Function Declaration
	function goView(seq) {
		location.href = "<%= ctxPath%>/lounge/loungeView?seq="+seq; 
	}
	
</script>

<!-- lounge_introduce 시작 -->
<div class="lounge_title_a bg-white" >
	<div class="lounge_title_b">
	    <img alt="lounge-mark" src="https://images.munto.kr/munto-web/ic_info_lounge-fill_24px.svg" width="18" height="18" decoding="async" data-nimg="1" loading="lazy" style="color:transparent"/>라운지
	</div>
	<div class="lounge_title_c">비슷한 관심사를 가진<br/>멤버들의 취향 피드 구독하기
	</div>
	<div class="lounge_title_d">
	    나와 비슷한 멤버를 찾아 팔로우하면<br/>언제 어디서나 더 가깝게 연결될 수 있어요.
	</div>
	<div></div>
</div>
<!-- lounge_introduce 끝 -->

<!-- lounge_content 시작 -->
<div class="container mt-5 mb-5">
    <div class="row">
    	<c:if test="${not empty requestScope.lgboardList}">
			<c:forEach items="${requestScope.lgboardList}" var="lgboarddto">
			    <div class="col-md-3 col-sm-6">
			        <div class="card p-3 mb-5 " style="min-height: 400px;">
			            <div class="d-flex justify-content-between">
			                <div class="d-flex flex-row align-items-center">
		                        <div><img style="border-radius:60%; width:35px;" src="https://lh3.googleusercontent.com/ogw/AOLn63F1Ha6NDXd-seLYOJM9EFk7xFis5ODQaOFR0zDz0w=s32-c-mo" /> </div>
		                        <div class=" c-details">
		                            <h6 class="mb-0 ml-2">${lgboarddto.name}</h6> 
		                            <span class="ml-2">
		                            	<c:if test="${lgboarddto.regDate_ago == 0}">today new</c:if>
		                            	<c:if test="${lgboarddto.regDate_ago > 0}">${lgboarddto.regDate_ago} days ago</c:if>
		                            </span>
		                        </div>
		                    </div>
		                    <div class="badge"> <span>follow</span> </div>
		                </div>
		                <div class="mt-3" onclick="goView(${lgboarddto.seq})" style="cursor:pointer;">
		                    <img style="width:100%;" src="http://images.munto.kr/production-feed/1684333844811-photo-hut52-101851-0?s=384x384" />
		                    <div class="mt-2">
		                        <div class="lgcontent">${lgboarddto.subject}</div>
		                        <div class="mt-3"> 
		                        	<span class="text1">
		                        		<img src="https://images.munto.kr/munto-web/ic_action_like-empty-black_30px.svg?s=32x32"/>${lgboarddto.likeCount}
			                        	<span class="text2">
			                        		<img src="https://images.munto.kr/munto-web/ic_action_comment_30px.svg?s=32x32"/>${lgboarddto.commentCount}
			                        	</span>
			                        	<img src="https://images.munto.kr/munto-web/info_group.svg?s=32x32"/>${lgboarddto.readCount}
		                        	</span> 
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </div>
        	</c:forEach>
        </c:if>
        <c:if test="${empty requestScope.lgboardList}">
        	<h2>등록된 게시물이 존재하지 않습니다.</h2>
        </c:if>
        
    </div>
</div>
<!-- lounge_content 끝 -->