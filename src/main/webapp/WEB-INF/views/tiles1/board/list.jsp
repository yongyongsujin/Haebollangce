<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   String ctxPath = request.getContextPath();
%>   

<style type="text/css">

	th {background-color: #DDD}

	.subjectStyle {
		font-weight: bold;
        color: navy;
        cursor: pointer;
	}

    a {text-decoration: none !important;}
    
</style>

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

<div style="display: flex;">
<div style="margin: auto; padding-left: 3%;">

   <h2 style="margin-bottom: 30px;">글목록</h2>
   
   <table style="width: 1024px" class="table table-bordered">
      <thead>
       <tr>
          <th style="width: 70px;  text-align: center;">글번호</th>
         <th style="width: 360px; text-align: center;">제목</th>
         <th style="width: 70px;  text-align: center;">성명</th>
         <th style="width: 150px; text-align: center;">날짜</th>
         <th style="width: 70px;  text-align: center;">조회수</th>
       </tr>
      </thead>
      
		<tbody>
			<c:if test="${not empty requestScope.boardList}">
				<c:forEach items="${requestScope.boardList}" var="boardvo">
					<tr align="center">
						<td>${boardvo.seq}</td>
						
						<%-- === 댓글쓰기 게시판 시작 === --%>
						<td align="left">
							<span class="subject" onClick="goView(${boardvo.seq})">${boardvo.subject}
							
							<c:if test="${boardvo.commentCount > 0}">&nbsp;<span style="color: red; vertical-align:super; font-size: 9pt; font-weight:bold; font-style:italic;">[${boardvo.commentCount}]</span></c:if>
							
							</span>
							
						</td>
						<%-- === 댓글쓰기 게시판 끝  === --%>
						<td>${boardvo.name}</td>
						<td>${boardvo.regDate}</td>
						<td>${boardvo.readCount}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty requestScope.boardList}">
				<td colspan="5">게시글이 없습니다.</td>
			</c:if>
		</tbody>
		</table>

	<%-- === #122. 페이지바 보여주기 === --%>  
    <div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto; ">
    	${requestScope.pageBar}
    </div>
    
 
 
	<%-- === #101. 글검색 폼 추가하기 : 글제목, 글쓴이로 검색을 하도록 한다. === --%>
	<form name="searchFrm" style="margin-top: 20px;">
		<select name="searchType" id="searchType" style="height: 26px;">
		   <option value="subject">글제목</option>
		   <option value="name">글쓴이</option>
		</select>
		<input type="text" name="searchWord" id="searchWord" size="40" autocomplete="off" /> 
		<input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
		<button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
	</form>
    
   
	<%-- === #106. 검색어 입력시 자동글 완성하기 1 === --%>
	<div id="displayList" style="border:solid 1px gray; border-top:0px; height:100px; margin-left:75px; margin-top:-1px; overflow:auto;">
   	</div>

</div>
</div>
  