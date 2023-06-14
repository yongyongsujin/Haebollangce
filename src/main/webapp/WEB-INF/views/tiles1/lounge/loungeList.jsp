<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>   

<style type="text/css">
	
	/* 페이지바 */
	div.pagination-wrapper {
		border-radius: 35px;
		background-color: white;
		width: fit-content;
	}
	
	ul.pagination {
		justify-content: center;
	}

	a.lgpage-link {
		display: block;
		padding: 0 20px;
		float: left;
		transition: 300ms ease;
		color: black;
		font-size: 18px;
		line-height: 40px;
	}
	
	a.lgpage-link.active {
		display: block;
		padding: 0 25px;
		float: left;
		transition: 300ms ease;
		color: white !important;
		font-size: 18px;
		line-height: 50px;
	}

	.lgpage-link:hover,
	.lgpage-item.active {
		background-color: #ff8a7a;
		color: white;
	}
	
	a.prev, a.next {
    	color: gray;
	}
	
	a.prev:hover, a.next:hover {
		background-color: transparent;
    	color: #ff8a7a;
	}
	/* 페이지바끝 */
	
	
	div.lgsubject{
		overflow: hidden;
	    text-overflow: ellipsis;
	    display: -webkit-box;
	    -webkit-line-clamp: 1; /* 라인수 */
	    -webkit-box-orient: vertical;
	    word-wrap:break-word; 
	    line-height: 1.2em;
	}
		
	div.lgcontent {
		overflow: hidden;
	    text-overflow: ellipsis;
	    display: -webkit-box;
	    -webkit-line-clamp: 3; /* 라인수 */
	    -webkit-box-orient: vertical;
	    word-wrap:break-word; 
	    line-height: 1.2em;
	    height: 3.6em; /* line-height 가 1.2em 이고 3라인을 자르기 때문에 height는 1.2em * 3 = 3.6em */
		font-size: 15px; 
	}
	
	
	/* 글검색 폼 */

	body{
	
	  background-color: #eee; 
	}
	
	.card{
	
	  background-color: #fff;
	  padding: 15px;
	  border:none;
	}
	
	.input-box{
	  position: relative;
	}
	
	.input-box i {
	  position: absolute;
	  right: 13px;
	  top:15px;
	  color:#ced4da;
	
	}
	
	.form-control{
	
	  height: 50px;
	  background-color:#eeeeee69;
	}
	
	.form-control:focus{
	  background-color: #eeeeee69;
	  box-shadow: none;
	  border-color: #eee;
	}
	
	
	.list{
	
	  padding-top: 20px;
	  padding-bottom: 10px;
	  display: flex;
	  align-items: center;
	
	}
	
	.border-bottom{
	
	  border-bottom: 2px solid #eee;
	}
	
	.list i{
	  font-size: 19px;
	  color: red;
	}
	
	.list small{
	
	  color:#dedddd;
	}

	div.oneresult:hover {
	  background-color: #eee;
	}

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// -- 엔터치면 검색됨 --
		$("input#searchWord").keyup(function(e){
			if (e.keyCode == 13) { 
				goSearch();
			}
		});
		
		// -- 검색시 검색조건 및 검색어 유지시키기 --
		if( ${not empty requestScope.paraMap} ) {
			$("select#searchType").val("${requestScope.paraMap.searchType}");
			$("input#searchWord").val("${requestScope.paraMap.searchWord}");
		}
		
		<%-- 검색어 입력시 자동글 완성하기 2 --%>
		$("div#displayList").hide(); // 처음에는 숨겨놓는다
		
		$("input#searchWord").keyup(function(){
			
			const wordLength = $(this).val().trim().length; // 검색어에서 공백을 제거한 길이를 알아온다.
			if(wordLength == 0) {
				$("div#displayList").hide(); // 검색어가 공백이거나 검색어 입력 후 백스페이스키를 모두 지우면 검색된 내용이 안 나오도록 해야한다.
			}
			else {
				$.ajax({
					url:"<%= ctxPath%>/lounge/lgwordSearchShow",
					type:"get",
					data:{"searchType":$("select#searchType").val(),
						  "searchWord":$("input#searchWord").val()},
					dataType:"json",
					success:function(json){
						
						if(json.length > 0) { // 검색된 데이터가 있는 경우
							
							let html = "";
							$.each(json, function(index, item){
								
								const lgword = item.lgword;
								const idx = lgword.toLowerCase().indexOf($("input#searchWord").val().toLowerCase()) ;
								const len = $("input#searchWord").val().length;
								const result = "<div class='oneresult'>" + lgword.substring(0,idx) + "<span style='color:#ff8a7a;'>" + lgword.substring(idx, idx+len) + "</span>" + lgword.substring(idx+len) + "</div>";
								html += "<span style='cursor:pointer;' class='result'>" + result + "</span>";
								
							});//end of $.each()----------------------------------
							
							const input_width = $("input#searchWord").css("width"); // 검색어 input 태그의 width 알아오기
							$("div#displayList").css({"width":input_width}); 		// 검색결과 div 의 width 크기를 검색어 입력 input 태그의 width 와 일치시키기  
							
							$("div#displayList").html(html);
							$("div#displayList").show();
						}
						
					},
					error: function(request, status, error){
		                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
					
				});//end of $.ajax({})------------------------------------------------------
				
			}//end of if~else()---------------------------------------------------------
			
		});//end of $("input#searchWord").keyup(function(){})-----------------------
		
		<%-- === #113. 검색어 입력 시 자동 글 완성하기 8 === --%>
		$(document).on("click", "span.result", function(){	
			const lgword = $(this).text();
			$("input#searchWord").val(lgword); // 텍스트 박스에 검색된 결과의 문자열을 입력해준다.
			$("div#displayList").hide();	 // 나머지는 가림
			goSearch();

		});//end of click span.result----------------------------------------------------
		
	});// end of $(document).ready(function(){})-------------------------------

  
	// Function Declaration
	function goView(seq) {
		const searchType = $("select#searchType").val();
  		const searchWord = $("input#searchWord").val();
		location.href = "<%= ctxPath%>/lounge/loungeView?seq="+seq+"&searchType="+searchType+"&searchWord="+searchWord; 
	}
	
	function goSearch() {
  		const frm = document.searchFrm;
  		frm.method = "get";
  		frm.action = "<%= ctxPath%>/lounge/loungeList";
  		frm.submit(); 
  	}//end of function goSearch()----------------------------------------------- 
	
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
	
	<%-- === (#101.) 글검색 폼 추가하기 : 글제목, 글쓴이, 글내용으로 검색을 하도록 한다. === --%>
    <form name="searchFrm" class="my-5">
    	<div class="row d-flex justify-content-end ">
			<div class="col-md-5">
				<div class="card">
					
					<select name="searchType" id="searchType" type="button" class="col-sm-3 btn dropdown-toggle" data-toggle="dropdown">
                    	<option value="subject">글제목</option>
        				<option value="name">글쓴이</option>
                    </select>
				
		            <div class="input-box">
		              	<input type="text" class="form-control" name="searchWord" id="searchWord" autocomplete="off" /> 
      					<input type="text" style="display: none;"/> 
      					<%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
		              	
		              	<i type="button" class="fa fa-search" onclick="goSearch()"></i> 
		            </div>
	
					<%-- 검색어 입력시 자동글 완성하기 1 --%>
					<div id="displayList" style="height:80px; margin-top:10px; overflow:auto;">
				   	</div>
					
				</div>
			</div>
		</div>
	</form>
	
	<!-- 글검색 폼 추가 끝 -->


    <div class="row">
    	<c:if test="${not empty requestScope.lgboardList}">
			<c:forEach items="${requestScope.lgboardList}" var="lgboarddto">
			    <div class="col-lg-3 col-md-4 col-sm-6">
			        <div class="card p-3 mb-5 " style="min-height: 400px;">
			            <div class="d-flex justify-content-between">
			                <div class="d-flex flex-row align-items-center">
		                        <div><img style="border-radius:60%; width:35px;" src="<%= ctxPath%>/images/${lgboarddto.lgbprofile}" /> </div>
		                        <div class=" c-details">
		                            <h6 class="mb-0 ml-2">${lgboarddto.name}</h6> 
		                            <span class="ml-2">
		                            	<c:if test="${lgboarddto.regDateAgo == 0}">today new</c:if>
		                            	<c:if test="${lgboarddto.regDateAgo > 0}">${lgboarddto.regDateAgo} days ago</c:if>
		                            </span>
		                        </div>
		                    </div>
		                    <div class="badge"> <span>chat me</span> </div>
		                </div>
		                <div class="mt-3" onclick="goView(${lgboarddto.seq})" style="cursor:pointer;">
		                	<div style="width: 100%; height: 0; padding-bottom: 100%; position: relative;">
		                    	<img style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;" src="<%= ctxPath%>/images/lgthumFiles/${lgboarddto.thumbnail}" />
		                    </div>
		                    <div class="mt-2">
		                    
		                    	<!-- === 첨부파일이 없는 경우 === -->
		        				<c:if test="${lgboarddto.orgFilename == null}">
		                        	<div class="lgsubject mb-1">${lgboarddto.subject}</div>
		                        	<div class="lgcontent">${lgboarddto.content}</div>
		                        </c:if>
		                        <!-- === 첨부파일이 있는 경우 === -->
			        			<c:if test="${lgboarddto.orgFilename != null}">
			        				<div class="lgsubject mb-1">${lgboarddto.subject}&nbsp;&nbsp;<i class="fa-solid fa-file-arrow-down" style="color: #fed85d;"></i></div>
			        				<div class="lgcontent">${lgboarddto.content}</div>
			        			</c:if>
			        			
		                        <div class="mt-3"> 
		                        	<span class="text1">
		                        		<img src="https://images.munto.kr/munto-web/ic_action_like-empty-black_30px.svg?s=32x32" />${lgboarddto.likeCount}
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
        	<div style="margin: 0 auto; padding-bottom:50px;">
        		<h2>등록된 게시물이 존재하지 않습니다.</h2>
        	</div>
        </c:if>
        
    </div>
    
 	<%-- === #3-3. 페이지바 보여주기 === --%>  
    <div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto; ">
    	${requestScope.pageBar}
    </div>
    
        	
</div>
<!-- lounge_content 끝 -->