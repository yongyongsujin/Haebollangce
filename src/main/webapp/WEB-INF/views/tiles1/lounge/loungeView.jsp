<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 


<style type="text/css">

    span.move {cursor: pointer; color: navy;}
    .moveColor {color: #660029; font-weight: bold; background-color: #ffffe6;}
    
    td.comment {text-align: center;}
    
    a {text-decoration: none !important;}

</style>   
    
<script type="text/javascript">
	$(document).ready(function(){
     
		goReadComment(); // 페이징  처리 안한 댓글 읽어오기
   
         
	});// end of $(document).ready(function(){})------------------------
  
  
  // Function Declaration
  
	// == 댓글쓰기 == 
	function goAddWrite() {
			
		const commentContent = $('input#commentContent').val().trim();
		
		if(commentContent.length == 0) {
			alert('댓글 내용을 입력하세요');
			return;
		}
		
		if($('input#attach').val() == '') {
			// 첨부파일이 x 댓글쓰기인 경우
			goAddWrite_noAttach();
		} else {
			// 첨부파일이 o 댓글쓰기인 경우
			goAddWrite_withAttach();
		}
		
		
	} // end of function goAddWrite() ---------------------
  
	// 파일첨부가 없는 댓글쓰기 
	function goAddWrite_noAttach() {
		
	<%--
		
		http://localhost:9090/board/list.action?currentShowPageNo=5&searchType=name&searchWord=이순신
	
	    // 	보내야할 데이터를 선정하는 또 다른 방법
	    // 	jQuery에서 사용하는 것으로써,
	    // 	form태그의 선택자.serialize(); 을 해주면 form 태그내의 모든 값들을 name값을 키값으로 만들어서 보내준다.
	    	const queryString = $("form[name='addWriteFrm']").serialize();
    --%>

    const queryString = $("form[name='addWriteFrm']").serialize();
    
    $.ajax({
    	url:'<%=request.getContextPath()%>/addComment.action',
    	data:{"fk_userid":$('input#fk_userid').val(),
    			"name":$('input#name').val(),
    			"content":$('input#commentContent').val(),
    			"parentSeq":$('input#parentSeq').val()},
    	type:'POST',
    	dataType:'JSON',
    	success:function(json){
    		
    		if(json.n == 0) {
    			alert(json.name + '님의 포인트는 300점을 초과하여 댓글쓰기가 불가능합니다');
    		} else {
    			// 페이징 처리 안 한 댓글 읽어오기
    			goReadComment();
    			// 페이징 처리 한 댓글 읽어오기
    		}
    		
    		$('input#commentContent').val('');
    		
    	},
    	error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }

    });
		
		
	} // end of goAddWrite_noAttach(){} -------------------
  
  
  // ==== #169. 파일첨부가 있는 댓글쓰기 ==== // 
  
  
  
	// === 페이징 처리 안한 댓글 읽어오기  === //
	function goReadComment() {
		
		$.ajax({
			url:'<%=request.getContextPath()%>/readComment.action',
			data: {"parentSeq":"${requestScope.boardvo.seq}"},
			type:"GET",
			dataType:"JSON",
			success:function(json){
				
				let html = ``;
				if(json.length > 0) {
					$.each(json, function(index, item){
						html += `<tr>
								 	<td class="comment">\${index+1}</td>
								 	<td class="comment">\${item.content}</td>
								 	<td></td>
								 	<td></td>
								 	<td class="comment">\${item.name}</td>
								 	<td class="comment">\${item.regdate}</td>
								 </tr>`;
						
					});
					
				} else {
					html += `<tr><td colspan="6" class="comment">댓글이 없습니다.</td></tr>`;
				}
				
				
				$('tbody#commentDisplay').html(html);
			},
	    	error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
	}
  
  // === #127. Ajax로 불러온 댓글내용을  페이징 처리 하기  === //
  
  
  // ==== 댓글내용 페이지바 Ajax로 만들기 ==== //
  
  
</script>

<div style="display: flex;">
<div style="margin: auto; padding-left: 3%;">

   <h2 style="margin-bottom: 30px;">글내용보기</h2>

    <c:if test="${not empty boardvo}">
       <table style="width: 1024px" class="table table-bordered table-dark">
          <tr>
              <th style="width: 15%">글번호</th>
              <td>${boardvo.seq}</td>
          </tr>
          <tr>
              <th>성명</th>
              <td>${boardvo.name}</td>
          </tr>
          <tr>
              <th>제목</th>
              <td>${boardvo.subject}</td>
          </tr>
          <tr>
              <th>내용</th>
              <td>
                <p style="word-break: break-all;">${boardvo.content}</p>
                <%-- 	style="word-break: break-all; 은 공백없는 긴영문일 경우 width 크기를 뚫고 나오는 것을 막는 것임. 
						그런데 style="word-break: break-all; 나 style="word-wrap: break-word; 은
						테이블태그의 <td>태그에는 안되고 <p> 나 <div> 태그안에서 적용되어지므로 <td>태그에서 적용하려면
						<table>태그속에 style="word-wrap: break-word; table-layout: fixed;" 을 주면 된다.
				--%>
              </td>
          </tr>
          <tr>
              <th>조회수</th>
              <td>${boardvo.readCount}</td>
          </tr>
          <tr>
              <th>날짜</th>
              <td>${boardvo.regDate}</td>
          </tr>
          
          <%-- === #162. 첨부파일 이름 및 파일크기를 보여주고 첨부파일을 다운로드 되도록 만들기 === --%>
         <tr>
            <th>첨부파일</th>
            <td>
               
            </td>
         </tr>
         <tr>
            <th>파일크기(bytes)</th>
            <td></td>
         </tr>
          
       </table>
       <br/>
       
       <c:set var="v_gobackURL" value='' />
       
       <%-- 글조회수 1증가를 위해서  view.action 대신에 view_2.action 으로 바꾼다. --%>
       <div style="margin-bottom: 1%;">이전글제목&nbsp;&nbsp;<span class="move" onClick="javascript:location.href='view_2.action/?seq=${boardvo.previousseq}&searchType=${paraMap.searchType}&searchWord=${paraMap.searchWord}'">${boardvo.previoussubject}</span></div>
       <div style="margin-bottom: 1%;">다음글제목&nbsp;&nbsp;<span class="move" onClick="javascript:location.href='view_2.action/?seq=${boardvo.nextseq}&searchType=${paraMap.searchType}&searchWord=${paraMap.searchWord}'">${boardvo.nextsubject}</span></div>
       <br/> 
              
       <button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%=request.getContextPath()%>/list.action'">전체목록보기</button>
       
       <%-- === #126. 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
                                      사용자가 목록보기 버튼을 클릭했을 때 돌아갈 페이지를 알려주기 위해
                                      현재 페이지 주소를 뷰단으로 넘겨준다. === --%>
       <button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%=request.getContextPath()%>${goPrevURL}'">검색된결과목록보기</button>
       
       <button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%=request.getContextPath()%>/edit.action?seq=${requestScope.boardvo.seq}'">글수정하기</button>
       <button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%=request.getContextPath()%>/del	.action?seq=${requestScope.boardvo.seq}'">글삭제하기</button>
       
       <%-- === #141. 어떤글에 대한 답변글쓰기는 로그인 되어진 회원의 gradelevel 컬럼의 값이 10인 직원들만 답변글쓰기가 가능하다.  === --%>


<%-- === #83. 댓글쓰기 폼 추가 === --%>
	<c:if test="${not empty sessionScope.loginuser}">
		<h3 style="margin-top: 50px;">댓글쓰기</h3>
	    <form name="addWriteFrm" id="addWriteFrm" style="margin-top: 20px;">
			<table class="table" style="width: 1024px">
	            <tr style="height: 30px;">
	                <th width="10%">성명</th>
	                <td>
		                	<input type="hidden" name="fk_userid" id="fk_userid" value="${sessionScope.loginuser.userid}"/>
		                	<input type="text" name="name" id="name" value="${sessionScope.loginuser.name}" readonly/>
	                	
	                </td>
	            </tr>
	            <tr style="height: 30px;">
	                <th>댓글내용</th>
	                <td>
	                	<input type="text" name="content" id="commentContent" size="100" />
	                	
	                	<%-- 댓글에 달리는 원게시물 글번호(즉, 댓글의 부모글 글번호) --%>
	                	<input type="hidden" name="parentSeq" id="parentSeq" value="${boardvo.seq}" />
	                </td>
	            </tr>
	               
	            <tr style="height: 30px;">
	                <th>파일첨부</th>
	                <td>
	                    <input type="file" name="attach" id="attach" />  
	            	</td>
	            </tr>
	               
	            <tr>
	                <th colspan="2">
	                    <button type="button" class="btn btn-success btn-sm mr-3" onclick="goAddWrite()">댓글쓰기 확인</button>
	                	<button type="reset" class="btn btn-success btn-sm">댓글쓰기 취소</button>
	            	</th>
	        	</tr>
	      	</table>         
	      </form>
	</c:if>

       
	<%-- === #94. 댓글 내용 보여주기 === --%>
	<h3 style="margin-top: 50px;">댓글내용</h3>
	<table class="table" style="width: 1024px; margin-top: 2%; margin-bottom: 3%;">
	<thead>
		<tr>
		    <th style="width: 6%;  text-align: center;">번호</th>
			<th style="text-align: center;">내용</th>
		
			<%-- 첨부파일 있는 경우 시작 --%>
			<th style="width: 15%;">첨부파일</th>
			<th style="width: 8%;">내용</th>
			<%-- 첨부파일 있는 경우 끝 --%>
		
			<th style="width: 8%; text-align: center;">작성자</th>
			<th style="width: 12%; text-align: center;">작성일자</th>
		</tr>
	</thead>
	<tbody id="commentDisplay"></tbody>
	</table>
       
      
      <%-- ==== #136. 댓글 페이지바 ==== --%>
       
       
    </c:if>

   <c:if test="${empty boardvo}">
       <div style="padding: 50px 0; font-size: 16pt; color: red;" >존재하지 않습니다</div>
    </c:if>
    
</div>
</div>    