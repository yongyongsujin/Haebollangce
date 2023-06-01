<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>   

<script type="text/javascript">

	$(document).ready(function(){
		
		
		
	});// end of $(document).ready(function(){})-------------------------------

  
	// Function Declaration
	function goView() {
		
		location.href = "http://localhost:7070/lounge/loungeView"; 
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
			<c:forEach items="${requestScope.lgboardList}" var="lgboardvo">
			    <div class="col-md-3 col-sm-6">
			        <div class="card p-3 mb-5">
			            <div class="d-flex justify-content-between">
			                <div class="d-flex flex-row align-items-center">
		                        <div><img style="border-radius:60%; width:35px;" src="https://lh3.googleusercontent.com/ogw/AOLn63F1Ha6NDXd-seLYOJM9EFk7xFis5ODQaOFR0zDz0w=s32-c-mo" /> </div>
		                        <div class=" c-details">
		                            <h6 class="mb-0 ml-2">${lgboardvo.name}</h6> <span class="ml-2">${lgboardvo.regDate}</span>
		                        </div>
		                    </div>
		                    <div class="badge"> <span>follow</span> </div>
		                </div>
		                <div class="mt-3">
		                    <img style="width:100%;" src="http://images.munto.kr/production-feed/1684333844811-photo-hut52-101851-0?s=384x384" />
		                    <div class="mt-1">
		                        <div>
			                        🖤Black Party🖤: 
									Let me teach you how to ‘BLACK'.    7기 
									다들 첫차 타고 갔다는 소문을 들었어…..
									‘다들 집에는 갔니?…..’ 라는 재원이의 단톡방메세지🫢
		                        </div>
		                        <div class="mt-3"> <span class="text1"><img src="https://images.munto.kr/munto-web/ic_action_like-empty-black_30px.svg?s=32x32"/>좋아요수<span class="text2"><img src="https://images.munto.kr/munto-web/ic_action_comment_30px.svg?s=32x32"/>댓글수</span></span> </div>
		                    </div>
		                </div>
		            </div>
		        </div>
        	</c:forEach>
        </c:if>
        <div class="col-md-3 col-sm-6">
            <div class="card p-3 mb-5">
                <div class="d-flex justify-content-between">
                    <div class="d-flex flex-row align-items-center">
                        <div><img style="border-radius:60%; width:35px;" src="http://images.munto.kr/production-user/1684469607083-photo-g1p6z-101851-0?s=48x48" /> </div>
                        <div class=" c-details">
                            <h6 class="mb-0 ml-1">평일민주</h6> <span class="ml-1">1 days ago</span>
                        </div>
                    </div>
                    <div class="badge"> <span>follow</span> </div>
                </div>
                <div class="mt-3" onclick="goView(${lgboardvo.seq})" style="cursor:pointer;">
                    <img style="width:100%;" src="http://images.munto.kr/production-feed/1684289174510-photo-spznw-42282-0?s=1080x1080" />
                    <div class="mt-1">
                        <div>
	                        🖤Black Party🖤: 
							Let me teach you how to ‘BLACK'.    7기 
							다들 첫차 타고 갔다는 소문을 들었어…..
							‘다들 집에는 갔니?…..’ 라는 재원이의 단톡방메세지🫢
                        </div>
                        <div class="mt-3"> <span class="text1"><img src="https://images.munto.kr/munto-web/ic_action_like-empty-black_30px.svg?s=32x32"/>좋아요수<span class="text2"><img src="https://images.munto.kr/munto-web/ic_action_comment_30px.svg?s=32x32"/>댓글수</span></span> </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card p-3 mb-5">
                <div class="d-flex justify-content-between">
                    <div class="d-flex flex-row align-items-center">
                        <div><img style="border-radius:60%; width:35px;" src="http://images.munto.kr/production-user/1675570371826-photo-5nj9g-129563-0?s=48x48" /> </div>
                        <div class=" c-details">
                            <h6 class="mb-0 ml-1">서현이</h6> <span class="ml-1">1 days ago</span>
                        </div>
                    </div>
                    <div class="badge"> <span>follow</span> </div>
                </div>
                <div class="mt-3">
                    <img style="width:100%;" src="http://images.munto.kr/production-feed/1684333844811-photo-hut52-101851-0?s=384x384" />
                    <div class="mt-1">
                        <div>
	                        🖤Black Party🖤: 
							Let me teach you how to ‘BLACK'.    7기 
							다들 첫차 타고 갔다는 소문을 들었어…..
							‘다들 집에는 갔니?…..’ 라는 재원이의 단톡방메세지🫢
                        </div>
                        <div class="mt-3"> <span class="text1"><img src="https://images.munto.kr/munto-web/ic_action_like-empty-black_30px.svg?s=32x32"/>좋아요수<span class="text2"><img src="https://images.munto.kr/munto-web/ic_action_comment_30px.svg?s=32x32"/>댓글수</span></span> </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card p-3 mb-5">
                <div class="d-flex justify-content-between">
                    <div class="d-flex flex-row align-items-center">
                        <div><img style="border-radius:60%; width:35px;" src="https://lh3.googleusercontent.com/ogw/AOLn63F1Ha6NDXd-seLYOJM9EFk7xFis5ODQaOFR0zDz0w=s32-c-mo" /> </div>
                        <div class=" c-details">
                            <h6 class="mb-0 ml-1">sujin</h6> <span class="ml-1">1 days ago</span>
                        </div>
                    </div>
                    <div class="badge"> <span>follow</span> </div>
                </div>
                <div class="mt-3">
                    <img style="width:100%;" src="http://images.munto.kr/production-feed/1684333844811-photo-hut52-101851-0?s=384x384" />
                    <div class="mt-1">
                        <div>
	                        🖤Black Party🖤: 
							Let me teach you how to ‘BLACK'.    7기 
							다들 첫차 타고 갔다는 소문을 들었어…..
							‘다들 집에는 갔니?…..’ 라는 재원이의 단톡방메세지🫢
                        </div>
                        <div class="mt-3"> <span class="text1"><img src="https://images.munto.kr/munto-web/ic_action_like-empty-black_30px.svg?s=32x32"/>좋아요수<span class="text2"><img src="https://images.munto.kr/munto-web/ic_action_comment_30px.svg?s=32x32"/>댓글수</span></span> </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card p-3 mb-5">
                <div class="d-flex justify-content-between">
                    <div class="d-flex flex-row align-items-center">
                        <div><img style="border-radius:60%; width:35px;" src="https://lh3.googleusercontent.com/ogw/AOLn63F1Ha6NDXd-seLYOJM9EFk7xFis5ODQaOFR0zDz0w=s32-c-mo" /> </div>
                        <div class=" c-details">
                            <h6 class="mb-0 ml-1">sujin</h6> <span class="ml-1">1 days ago</span>
                        </div>
                    </div>
                    <div class="badge"> <span>follow</span> </div>
                </div>
                <div class="mt-3">
                    <img style="width:100%;" src="http://images.munto.kr/production-feed/1684333844811-photo-hut52-101851-0?s=384x384" />
                    <div class="mt-1">
                        <div>
	                        🖤Black Party🖤: 
							Let me teach you how to ‘BLACK'.    7기 
							다들 첫차 타고 갔다는 소문을 들었어…..
							‘다들 집에는 갔니?…..’ 라는 재원이의 단톡방메세지🫢
                        </div>
                        <div class="mt-3"> <span class="text1"><img src="https://images.munto.kr/munto-web/ic_action_like-empty-black_30px.svg?s=32x32"/>좋아요수<span class="text2"><img src="https://images.munto.kr/munto-web/ic_action_comment_30px.svg?s=32x32"/>댓글수</span></span> </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card p-3 mb-5">
                <div class="d-flex justify-content-between">
                    <div class="d-flex flex-row align-items-center">
                        <div><img style="border-radius:60%; width:35px;" src="https://lh3.googleusercontent.com/ogw/AOLn63F1Ha6NDXd-seLYOJM9EFk7xFis5ODQaOFR0zDz0w=s32-c-mo" /> </div>
                        <div class=" c-details">
                            <h6 class="mb-0 ml-1">sujin</h6> <span class="ml-1">1 days ago</span>
                        </div>
                    </div>
                    <div class="badge"> <span>follow</span> </div>
                </div>
                <div class="mt-3">
                    <img style="width:100%;" src="http://images.munto.kr/production-feed/1684333844811-photo-hut52-101851-0?s=384x384" />
                    <div class="mt-1">
                        <div>
	                        🖤Black Party🖤: 
							Let me teach you how to ‘BLACK'.    7기 
							다들 첫차 타고 갔다는 소문을 들었어…..
							‘다들 집에는 갔니?…..’ 라는 재원이의 단톡방메세지🫢
                        </div>
                        <div class="mt-3"> <span class="text1"><img src="https://images.munto.kr/munto-web/ic_action_like-empty-black_30px.svg?s=32x32"/>좋아요수<span class="text2"><img src="https://images.munto.kr/munto-web/ic_action_comment_30px.svg?s=32x32"/>댓글수</span></span> </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card p-3 mb-5">
                <div class="d-flex justify-content-between">
                    <div class="d-flex flex-row align-items-center">
                        <div class="icon"> <i class="bx bxl-reddit"></i> </div>
                        <div class=" c-details">
                            <h6 class="mb-0">Reddit</h6> <span>2 days ago</span>
                        </div>
                    </div>
                    <div class="badge"> <span>Design</span> </div>
                </div>
                <div class="mt-5">
                    <h3 class="heading">Software Architect <br>Java - USA</h3>
                    <div class="mt-5">
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                        <div class="mt-3"> <span class="text1">52 Applied <span class="text2">of 100 capacity</span></span> </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- lounge_content 끝 -->