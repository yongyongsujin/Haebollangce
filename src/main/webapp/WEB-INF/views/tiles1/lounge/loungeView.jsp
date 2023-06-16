<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %> 

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 



<script type="text/javascript">

  	$(document).ready(function(){
	
  		lggoReadComment();  // 문자 시작되자마자 페이징 처리안한 댓글 읽어오기
  		
  		// -- 엔터치면 댓글입력됨 --
		$("input#commentContent").keyup(function(e){
			if (e.keyCode == 13) { 
				lgcgoAddWrite()
			}
		});
  		
		// 페이지 로딩 시 스크롤 위치를 저장
		/* $(window).addEventListener('beforeunload', function() {
		  	localStorage.setItem('scrollPosition', window.pageYOffset);
		}); */
		
  	});// end of $(document).ready(function(){})-------------------------------

  	
  	// === Function Declaration === //
  	
  	// == 스크롤위치 저장 == 
  	function restoreScrollPosition() {
	  	// 이전 스크롤 위치를 로컬 스토리지에서 가져옴
	  	var scrollPosition = localStorage.getItem('scrollPosition');

	  	// 이전 스크롤 위치가 존재하면 스크롤 이동
	  	if (scrollPosition) {
	    	window.scrollTo(0, scrollPosition);
	  	}
	}

  	// == 댓글쓰기 ==
  	function lgcgoAddWrite() {
  		
		const commentContent = $("input#commentContent").val().trim();
  		
  		if(commentContent == "") {
  			alert("댓글 내용을 입력하세요.");
  			return; // 종료
  		}
  		
  		const queryString = $("form[name='addWriteFrm']").serialize();
  		
  		$.ajax({
  			url:"<%= ctxPath%>/lounge/loungeaddComment",
  			data:queryString,
		    type:"post",
    		dataType:"json",
    		success:function(json){
    			// console.log("~~~ 확인뇽 : " + JSON.stringify(json));
    			// ~~~ 확인뇽 : {"name":"망나뇽수진","n":0}
    			
    			if(json.n == 0) {
    				alert("댓글쓰기 실패");
    			}
    			else {
    				lggoReadComment();	// 페이징 처리 안한 댓글 읽어오기
				}
    			$("input#commentContent").val(""); // 댓글이 써졌든 아니든 이제 댓글칸 비워주기 
    			location.href="javascript:history.go(0)";
    		},
    		error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
  			      
  		});//end of $.ajax()----------------------------------
  		
  	}//end of function lgcgoAddWrite()----------------
  
  	
 	// === 댓글 페이징 처리안하고 읽어오기  
  	function lggoReadComment() {
  		
  		$.ajax({
			url:'<%= ctxPath%>/lounge/loungereadComment',
			data: {"parentSeq":"${requestScope.lgboarddto.seq}"},
			dataType:"json",
			success:function(json){
				console.log("~~~ 확인뇽 : " + JSON.stringify(json));
			//	console.log("~~~ 확인뇽 json.length : " + json.length); //-> 여기서 값은 잘 나오지만 $ 앞에 \ 를 안써줘서 값이 안나왔었다
				
				let html = ``;
  				if(json.length > 0) {
  					$.each(json, function(index, item){
  						
  						if (item.depthno == 0) {
	  						html += ` <div class="d-flex flex-row mb-3"> 
			                		 	<img style="border: solid 3px #eee; border-radius: 100%; width:45px; height: 45px; vertical-align: top;" src="<%= ctxPath%>/images/\${item.lgcprofile}" /> 
			  	              		 	<div class="c-details"> 
			  	                     		<h5 class="mb-1 ml-3 lounge_comment_userid"><span class="lounge_comment_name">\${item.name}</span></h5> 
			  	                     		<input type="hidden" name="seq" id="seq" value="\${item.seq}" /> 
			  	                     		<div class="c-details">
			  		                 			<h6 class="mb-0 ml-3 lounge_comment_content">\${item.content}</h6>
			  	                	 		</div>
			  	                	 		<div class="c-details"> 
			  	                				<small class="mb-0 ml-3" style="color:gray;">\${item.regdate}</small>`;
			  	             if ("${requestScope.loginuser}" != "") {
			  	             		html += `	<small type="button" class="mb-0 ml-2" style="color:gray;" onclick="javascript:location.href='/lounge/loungeView?seq=\${item.parentSeq}&fk_seq=\${item.seq}&groupno=\${item.groupno}&depthno=\${item.depthno}&name=\${item.name}'">답글달기</small>`;
			  	             }
			  	             if (item.fk_userid == "${requestScope.loginuser.userid}") {				
			  	                				
				  	               html += `	<small type="button" class="mb-0 ml-1 p-1" style="color:gray; background-color:#eee; border-radius:5px;" onclick="lgcommentDel('\${item.seq}')">삭제</small>`;
			  	             }
			  	             html += `		</div>
			  	                		</div> 
		  	              		 	  </div>`; 
  						} 
  						
  						else if (item.depthno > 0) {
  							let padding = parseInt(item.depthno)*40;
  							html += ` <div class="d-flex flex-row mb-3" style="padding-left:\${padding}px"> 
  										<img style="border: solid 3px #eee; border-radius: 100%; width:45px; height: 45px; vertical-align: top;" src="<%= ctxPath%>/images/\${item.lgcprofile}" /> 
			  	              		 	<div class="c-details"> 
			  	                     		<h5 class="mb-1 ml-3 lounge_comment_userid"><span class="lounge_comment_name">\${item.name}</span></h5> 
			  	                     		<input type="hidden" name="seq" id="seq" value="\${item.seq}" /> 
			  	                     		<div class="c-details">
			  		                 			<h6 class="mb-0 ml-3 lounge_comment_content">\${item.content}</h6>
			  	                	 		</div>
			  	                	 		<div class="c-details"> 
			  	                				<small class="mb-0 ml-3" style="color:gray;">\${item.regdate}</small>`;
	                		if ("${requestScope.loginuser}" != "") {
			  	            	html += `		<small type="button" class="mb-0 ml-2" style="color:gray;" onclick="javascript:location.href='/lounge/loungeView?seq=\${item.parentSeq}&fk_seq=\${item.seq}&groupno=\${item.groupno}&depthno=\${item.depthno}&name=\${item.name}'">답글달기</small>`;
			  	            }			  	                				
  							if (item.fk_userid == "${requestScope.loginuser.userid}") {				
	                				
			  	                html += `		<small type="button" class="mb-0 ml-1 p-1" style="color:gray; background-color:#eee; border-radius:5px;" onclick="lgcommentDel('\${item.seq}')">삭제</small>`;
			  	            }
			  	             html += `		</div>
			  	                		</div> 
		  	              		 	  </div>`; 
  						}
  					});
  				}
  				else {
  					html += ` <div>댓글이 존재하지 않습니다.</div>`
  				}
  				$("div#lgcommentDisplay").html(html);
  			},
  			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
  			
  		});//end of $.ajax()--------------------------------------
  		
  	}//end of function lggoReadComment()----------------
  	
  	
  	// 라운지 특정 글에서 댓글  삭제하기  
  	function lgcommentDel(seq) {
  		
  		if(confirm("댓글을 삭제하면 하위 댓글들도 모두 삭제됩니다. 삭제 하시겠습니까?")) {
  			
  			$.ajax({
  	  			url:"<%= ctxPath%>/lounge/lgcommentDel",
  	  			data:{"parentSeq":"${requestScope.lgboarddto.seq}",
  				  	  "seq":seq},
  			    type:"post",
  	    		dataType:"json",
  	    		success:function(json){
  	    			
  	    			if(json.n == 0) {
  	    				alert("댓글삭제 실패");
  	    			}
  	    			else {
  	    				lggoReadComment();	// 페이징 처리 안한 댓글 읽어오기
  					}
  	    			location.href="javascript:history.go(0)";
  	    		},
  	    		error: function(request, status, error){
  	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
  	            }
  	  			      
  	  		});//end of $.ajax()----------------------------------

		}
  		
  	}//end of function lgcommentDel()-------------------
  	
  	
 	// 라운지 특정글에 대한 좋아요 등록하기 
   	function lggoLikeAdd(seq) {
   
      	if(${empty loginuser}) {
    	  	alert("좋아요를 누르려면 먼저 로그인 하셔야 합니다.");
    	  	return;
      	}
      
      	$.ajax({
			url:"<%= request.getContextPath()%>/lounge/loungelikeAdd",
			type:"post",
			data:{"fk_userid":$("input#fk_userid").val(),
				  "fk_seq":seq},
			dataType:"json",
			success: function(json){
				
				alert(json.message);
				location.href="javascript:history.go(0)";
			},
			error: function(request, status, error){
             		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
          	}
		});//end of ajax()--------------------------
      
   	}// end of golikeAdd(pnum)---------------------------
  	
	function goView(seq) {
		location.href = "<%= ctxPath%>/lounge/loungeView?seq="+seq+"&searchType=&searchWord="; 
	}
   	
</script>


<div class=" container-fluid mt-5 mb-5 mx-auto bg-white">
	<div class="row col-lg-6 col-md-6 col-sm-6 mx-auto my-5 justify-content-center">
	
		<c:if test="${not empty requestScope.lgboarddto}">
			<div class="card p-3 mb-5 mt-5" >
		        <div class="d-flex justify-content-between">
		            <div class="d-flex flex-row align-items-center">
		                <div><img style="border-radius:60%; width:60px; height: 60px;" src="<%= ctxPath%>/images/${lgboarddto.lgbprofile}" /> </div>
		                <div class="c-details">
		                    <h6 class="mb-0 ml-4">${lgboarddto.name}</h6> 
		                    <span class="ml-4">
		                    	<c:if test="${lgboarddto.regDateAgo == 0}">today new</c:if>
		                        <c:if test="${lgboarddto.regDateAgo > 0}">${lgboarddto.regDateAgo} days ago</c:if>
		                    </span>
		                </div>
		            </div>
		            <c:if test="${loginuser != null && loginuser.userid == lgboarddto.fkUserid}">
		            	<div class="badge2"> <span style="font-size=5pt;" onclick="javascript:location.href='/mypage/mypageHome'">프로필편집</span> </div>
		            </c:if>
		            <c:if test="${loginuser != null && loginuser.userid != lgboarddto.fkUserid}">
		            	<div class="badge2"> <span>follow</span> </div>
		            </c:if>
		            <c:if test="${loginuser == null}">
		            	<div class="badge2"> <span>follow</span> </div>
		            </c:if>
		        </div>
		        <div class="mt-4" style="padding:10px;">
		   			<img style="width:100%;" src="/images/lgthumFiles/${lgboarddto.thumbnail}" />
		            <div class="mt-3">
		            	<h4>${lgboarddto.subject}</h4>
		                <div>${lgboarddto.content}</div>
		                <c:if test="${lgboarddto.orgFilename != null}">
			                <div style="border:solid 1px silver; border-radius:7px; margin:10px; padding:7px;"> 첨부파일 |  
			                	<c:if test="${loginuser != null}">
			               			<a href="/lounge/lgdownload?seq=${lgboarddto.seq}" style="color:black;">${lgboarddto.orgFilename} ( <fmt:formatNumber value="${lgboarddto.fileSize}" pattern="#,###" /> bytes ) </a>
			               		</c:if>
			               		<c:if test="${loginuser == null}">
			               			${lgboarddto.orgFilename}
			               		</c:if>
			                </div>
		                </c:if>
		                <div class="mt-4"> 
		                	<span class="text1 ">
		                		<c:if test="${requestScope.n == 1 && loginuser != null}"> <%-- 로그인한 유저가 좋아요를 누른상태면 빨간하트를 --%>
		                			<img src="/images/lounge-redheart.jpg" alt="Lounge Like"  width="29" height="29" style="cursor: pointer;" onclick="lggoLikeAdd('${lgboarddto.seq}')"/>
		                		</c:if>
		                		<c:if test="${requestScope.n == 0 || loginuser == null}"> <%-- 로그인한 유저가 좋아요를 누르지 않은 상태면 빈 하트를 보이자  --%>
		                			<img src="/images/lounge-emptyheart.jpg" alt="Lounge Like"  width="29" height="29" style="cursor: pointer;" onclick="lggoLikeAdd('${lgboarddto.seq}')"/>
		                		</c:if>
		                		${lgboarddto.likeCount}
		                		<img src="/images/comment.png" width="29" height="29" style="cursor: pointer;" onclick="goView(${lgboarddto.seq})"/>${lgboarddto.commentCount}
		                		<img src="/images/readcount.png" width="29" height="29" style="cursor: pointer;" />${lgboarddto.readCount}	
		                	</span> 
		                	<c:if test="${loginuser.userid == lgboarddto.fkUserid}">
						        <span class="dropup">
									<a class="nav-link dropdown-toggle headerfont" data-toggle="dropdown"><i class="fa-solid fa-ellipsis" style="color: #0d0d0d;"></i></a>
									<ul class="dropdown-menu">
										<li><i class="dropdown-item fa-solid fa-pen btnEdit" style="color: gray;" onclick="javascript:location.href='/lounge/loungeEdit?seq=${requestScope.lgboarddto.seq}'">&nbsp;글 수정하기</i></li>
										<li><i class="dropdown-item fa-solid fa-trash btnDelete" style="color:gray;" onclick="javascript:location.href='/lounge/loungeDel?seq=${requestScope.lgboarddto.seq}'">&nbsp;글 삭제하기</i></li>
									</ul>
								</span>
		                	</c:if>
		                </div>
		            </div>
		        </div>
		     
		    	<!-- 댓글쓰기 폼 추가 (로그인했을때만 가능)-->
		    	<c:if test="${empty loginuser}">
			    	<div class="d-flex flex-row align-items-center">
			                <div > 
			                	<img style="border: solid 3px #eee; border-radius: 100%; width:45px; height: 45px; vertical-align: top;" src="/images/defaultProfic.png"/>
			                </div>
			                <div style="width:100%;">
			                	<div class=" c-details">
			                    	<h6 class="mb-0 ml-2 lounge_comment_content align-items-center">
			                    		<input type="text" name="content" id="commentContent" style="border-radius:10px; border: solid 3px #eee; height: 35px; width:90%;" placeholder="로그인 후 댓글을 남겨 보세요~^^" readonly/> 
				                    </h6>
			                	</div>
			                </div>
			            </div>
		    	</c:if>
		   		<c:if test="${not empty loginuser}">
			    	<form name="addWriteFrm" id="addWriteFrm" style="margin-top: 20px;" onsubmit="return false;">
				    	<div class="d-flex flex-row align-items-center">
			                <div > 
			                	<img style="border: solid 3px #eee; border-radius: 100%; width:45px; height: 45px; vertical-align: top;" src="<%= ctxPath%>/images/${loginuser.profilePic}"/>
			                </div>
			                <div style="width:100%;">
			                	<input type="hidden" name="fkUserid" id="fk_userid" value="${loginuser.userid}" /> 
			                	<input type="hidden" name="name" id="name" value="${loginuser.name}" />
			                    
			                    <div class=" c-details">
			                    	<h6 class="mb-0 ml-2 lounge_comment_content align-items-center">
			                    		
			                    		<!-- 댓글쓰기인 경우 -->
			                    		<c:if test="${requestScope.fk_seq eq ''}">
					                    	<input type="text" name="content" id="commentContent" style="border-radius:10px; border: solid 3px #eee; height: 35px; width:90%;" placeholder=" 댓글달기.." /> 
				                    	</c:if>
				                    	
				                    	<!-- 대댓글쓰기인 경우 -->
			                    		<c:if test="${requestScope.fk_seq ne ''}">
					                    	<input type="text" name="content" id="commentContent" style="border-radius:10px; border: solid 3px #eee; height: 35px; width:90%;" placeholder=" @ ${requestScope.name} 님에게 댓글달기.." /> 
				                    	</c:if>
				                    	
									   	<%-- === #9-4. 답변글쓰기가 추가된 경우 시작 === --%>
									   	<input type="hidden" name="fk_seq" value="${requestScope.fk_seq}" /> 
									   	<input type="hidden" name="groupno" value="${requestScope.groupno}" />   	
									   	<input type="hidden" name="depthno" value="${requestScope.depthno}" />  
									   	<%--=== 답변글쓰기가 추가된 경우 끝 === --%>
	   	
				                    	<%-- 댓글에 달리는 원게시물의 글번호(즉, 부모글 글번호) --%>
				                    	<input type="hidden" name="parentSeq" id="parentSeq" value="${requestScope.lgboarddto.seq}"/>&nbsp;
				                    	<button type="button" class="btn btn-habol btn-sm" style="width:50px;" onclick="lgcgoAddWrite()">게시</button>
			                    	</h6>
			                	</div>
			                </div>
			            </div>
			        </form>
		    	</c:if>
		    	<!-- 댓글쓰기끝 -->
		    	
		    	<hr style="border: solid 1px #eee;">
		    	
		    	<!-- 댓글보기 -->
				<div id="lgcommentDisplay"></div>
	            <!-- 댓글보기 끝-->
	            
		    </div>
	    </c:if>
	</div>
</div>

