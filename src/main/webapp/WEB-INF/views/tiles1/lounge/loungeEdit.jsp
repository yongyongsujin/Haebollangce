<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<% String ctxPath = request.getContextPath(); %>   

<style type="text/css">

</style>

<script type="text/javascript">

  	$(document).ready(function(){
	  
	  	<%-- #5. 스마트 에디터 구현  --%>
	  	//전역변수
	    var obj = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "content",
	        sSkinURI: "/smarteditor/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true,
	        }
	    });
		<%-- === end of 스마트 에디터 구현  === --%>
	  
     
	  	$("button#btnEdit").click(function(){
		
	  		<%-- #5-1. 스마트 에디터 구현 (id 가 content 인 textarea 에 에디터 대입) --%>
  			obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	  		
			// 글제목 유효성 검사
  	        const subject = $("input#subject").val().trim();
  	        if(subject == "") {
  	            alert("글제목을 입력하세요!!");
  	            return;
  	        }
  	        

			<%-- === #166-2. 글내용 유효성 검사(스마트 에디터 사용 할 경우) === --%>
	  		<%-- --- 스마트에디터는 내부적으로 <p> 태그를 포함하므로 걷어내줘야 한다 --- --%>
	        let content = $("textarea#content").val();
	        content = content.replace(/&nbsp;/gi, "");
	        content = content.substring(content.indexOf("<p>")+3);
 	  	 	content = content.substring(0, content.indexOf("</p>"));
 	  	 	
 	  	 	let Listcontent = $("textarea#content").val();
 	  	 	Listcontent = Listcontent.replace(/&nbsp;/gi, "");
 	  	 		
 	  	 	
 	  	 	if(content.trim().length == 0) {
 	  	 		alert("글내용을 입력하세요!!");
	            return;
 	  	 	}
	        
			// 글암호 유효성 검사
			const pw = $("input#pw").val();
			if(pw == "") {
			    alert("글암호를 입력하세요!!");
			    return;
			}
			
		//	console.log("subject : " + subject);
		//	console.log("content : " + content);
		//	console.log("pw : " + pw);
		//	return;
			
			// 폼(form)을 전송(submit)
			const frm = document.editFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/lounge/loungeEditEnd";
			frm.submit();
        
	  	});
     
  	});// end of $(document).ready(function(){})-------------------------------
  
  	<%-- function deletelgOrgFilename() {
	  
	  	if(confirm("정말로 첨부파일을 삭제 하시겠습니까?")) {
	  
		    // Ajax를 사용하여 서버로 요청을 보내고, orgFilename 정보를 삭제하는 로직을 구현합니다.
		    // 예를 들어, 서버의 특정 URL로 DELETE 요청을 보내거나, 필요한 처리를 수행합니다.
		    // 이 예시에서는 AJAX 요청을 보내는 방법을 보여주기 위해 jQuery의 $.ajax() 함수를 사용합니다.
		    $.ajax({
		        url: '<%= ctxPath%>/lounge/deletelgOrgFilename', 
		        type: "DELETE", // HTTP 요청 메서드 설정
		        success: function(response) {
		            alert("첨부파일이 삭제되었습니다.");
		        },
		        error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
		    });
	  
	  	}//end of if()------------------------------------------------------
	  
	}//end of function deletelgOrgFilename()------------------------- 첨부파일 편집 기능 만들다 보류 --%>

</script>

<div class=" container-fluid mt-5 mb-5 mx-auto bg-white">
	<div class=" col-md-10 mx-auto my-5 justify-content-center" style="width:80%; ">

		<h4 class="d-flex justify-content-center mb-1 pb-1" style="padding-top:50px;"><span style="border-bottom: solid 3px;">라운지 글작성하기</span></h4>
	
		<form name="editFrm" enctype="multipart/form-data">
		
			<div class="card p-3 mb-5 mt-3" >
			
		        <div class="d-flex justify-content-between">
		            <div class="d-flex flex-row align-items-center ">
		                <div><img style="border-radius:60%; width:60px; height: 60px;" src="<%= ctxPath%>/images/${requestScope.lgboarddto.lgbprofile}" /> </div>
		                <div class="c-details">
		                	<!-- 글 수정을 위해 글번호 seq 가 필요해 hidden 으로 넣어둔다. -->
            				<input type="hidden" name="seq" value="${requestScope.lgboarddto.seq}" readonly />
		                    <input type="hidden" name="fk_userid" id="fk_userid" value="${requestScope.lgboarddto.fk_userid}" readonly />
	                    	<input type="text" name="name" style="border:none; font-size:16pt; margin-left:10px;" value="${requestScope.lgboarddto.name}" readonly />
            			</div>
		            </div>
		        </div>
		        
		        <div class="mt-3">
		        	<input type="text" name="subject" id="subject" style="width:100%; border:none; font-size:20pt;" placeholder="제목" value="${requestScope.lgboarddto.subject}" /><hr>
		           	<textarea style="width:100%; height: 500px;" name="content" id="content" placeholder="글내용" >${requestScope.lgboarddto.content}</textarea>
		            
		            <div class="mt-2">
		            	<c:if test="${requestScope.lgboarddto.orgFilename == null}">
			            	<div class="mt-2">
			                	<span class="mr-4 align-center" style="width: 15%;">파일첨부</span>
			                  	<input type="file" name="attach" />
			                </div>
		                </c:if>
		                <c:if test="${requestScope.lgboarddto.orgFilename != null}">
		                	<div class="mt-2">
		                		<span class="mr-4 align-center" style="width: 15%;">파일첨부</span>
		                		<span>${requestScope.lgboarddto.orgFilename}&nbsp;&nbsp;
		                			<!-- <i class="fas fa-trash" style="cursor:pointer" onclick="deletelgOrgFilename()"></i> 첨부파일 편집 기능 만들다 보류 -->
		                		</span>
		                	</div>
		                </c:if>
		                <div class="mt-2 mb-2">
		                	<span class="mr-4" style="width: 15%;">작성암호</span>
		                  	<input type="password" name="pw" id="pw" />
		                </div>
		            </div>
		        </div>
		        
		        <div style="margin: 20px; text-align:center; padding-bottom:100px;">
			      	<button type="button" class="btn btn-secondary rounded btn-sm mr-3" id="btnEdit">글수정하기</button>
			      	<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
			   	</div>
		        
		    </div>
		    
	    </form>
	    
	</div>
</div>



