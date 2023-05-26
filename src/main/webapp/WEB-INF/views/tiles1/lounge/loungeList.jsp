<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>   

<script type="text/javascript">

	$(document).ready(function(){
		
		$('span.subject').on('mouseover', function(e){
			$(e.target).addClass('subjectStyle');
		});
	  
		$('span.subject').on('mouseout', function(e){
			$('span.subject').removeClass('subjectStyle');
		});
		
		$('input#searchWord').on('keydown', function(e){
			
			if(e.keyCode == 13) {
				goSearch();
			}
		});
		
		if(${not empty requestScope.paraMap}) {
			$('select#searchType').val('${paraMap.searchType}');
			$('input#searchWord').val('${paraMap.searchWord}');
			
		}
		
		<%-- === #107. 검색어 입력시 자동완성하기 2 (처음에 감추기) === --%>
		$('div#displayList').hide();
		
		$('input#searchWord').keyup(function(){
			
			// 검색어에서 공백을 제거한 길이를 알아온다.
			const wordLength = $(this).val().trim().length;
			
			if(wordLength == 0) {
				$('div#displayList').hide();
				// 검색어가 공백 || 검색어 입력 후 전부 지울 시 내용이 안 나오도록 한다.
			} else {
				$.ajax({
					url:'<%=ctxPath%>/wordSearchShow.action',
					type:'GET',
					data:{"searchType":$('select#searchType').val(),
						  "searchWord":$('input#searchWord').val()},
					dataType:'JSON',
					success:function(json){
						// console.log(JSON.stringify(json));
						
						<%-- === #112. 검색어 읿력시 자동글 완성하기 7 === --%>
						if(json.length > 0) {
							// 검색된 데이터 있는 경우
							
							let html = "";
							
							$.each(json, function(index, item){
								const word = item.word;
								// word ==> 오라클 JAVA 를 배우고 싶어요~
								const idx = word.toLowerCase().indexOf($('input#searchWord').val().toLowerCase());
								// 검색어(JaVa)가 나오는 idx == 4
								
								const len = $('input#searchWord').val().length;
								// 검색어(JaVa)의 길이 len 은 4가 된다.
							
								// console.log('--- 시작 ---');
								// console.log(word.substring(0, idx));		// 검색어 앞까지의 글자 "오라클 "
								// console.log(word.substring(idx, idx+len));	// 검색어 : "JaVa"
								// console.log(word.substring(idx+len));		// 검색어(JaVa) 뒤부터 끝까지 " 를 배우고 싶어요~"
								// console.log('--- 끝 ---');
							
								const result = word.substring(0, idx) +
									"<span style='color:blue;'>"+
									word.substring(idx,idx+len) + "</span>"+word.substring(idx+len);
								
								html += "<span class='searchResult' style='cursor:pointer;'>" + result + "</span><br>";
							});
							
							// 검색결과 div 의 width 크기를 검색어 입력 input 태그의 width 와 일치시키기
							const input_width = $('input#searchWord').css('width');
							

							$('div#displayList').html(html);
							$('div#displayList').show();
							$('div#displayList').css('width', input_width);
							
						}
						
					},
			    	error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			        }
				});
			}
		}); // end of $('input#searchWord').keyup() ------------
		
		
		<%-- === #113. 검색어 읿력시 자동글 완성하기 8 === --%>
		$(document).on('click', 'span.searchResult', function(){
			
			const word = $(this).text();
			$('input#searchWord').val(word); // 텍스트박스에 검색된 결과의 문자열을 입력해준다.
			$('div#displayList').hide();
			goSearch();
		});
		
		
	});// end of $(document).ready(function(){})-------------------------------

  
	// Function Declaration
	function goView(seq) {
		
		<%--location.href = '<%=ctxPath%>/view.action?seq='+seq; --%>
		
		// === #124. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
	    //           사용자가 목록보기 버튼을 클릭했을 때 돌아갈 페이지를 알려주기 위해
	    //           현재 페이지 주소를 뷰단으로 넘겨준다.

	    const goPrevURL = '${goPrevURL}';
		
		alert(goPrevURL);
		 
		 const searchType = $('select#searchType').val();
		 const searchWord = $('input#searchWord').val();
		 
		 
		location.href = '<%=ctxPath%>/view.action?seq='+seq+'&searchType='+searchType+'&searchWord='+searchWord+'&goPrevURL='+goPrevURL;
	}
	
	function goSearch() {
		const frm = document.searchFrm;
		frm.method = 'GET';
		frm.action = '<%=ctxPath%>/list.action';
		frm.submit();
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
        <div class="col-md-3 col-sm-6">
            <div class="card p-3 mb-5">
                <div class="d-flex justify-content-between">
                    <div class="d-flex flex-row align-items-center">
                        <div><img style="border-radius:60%; width:35px;" src="https://lh3.googleusercontent.com/ogw/AOLn63F1Ha6NDXd-seLYOJM9EFk7xFis5ODQaOFR0zDz0w=s32-c-mo" /> </div>
                        <div class=" c-details">
                            <h6 class="mb-0 ml-2">sujin</h6> <span class="ml-2">1 days ago</span>
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
                        <div><img style="border-radius:60%; width:35px;" src="http://images.munto.kr/production-user/1684469607083-photo-g1p6z-101851-0?s=48x48" /> </div>
                        <div class=" c-details">
                            <h6 class="mb-0 ml-1">평일민주</h6> <span class="ml-1">1 days ago</span>
                        </div>
                    </div>
                    <div class="badge"> <span>follow</span> </div>
                </div>
                <div class="mt-3" onclick="goView()" style="cursor:pointer;">
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