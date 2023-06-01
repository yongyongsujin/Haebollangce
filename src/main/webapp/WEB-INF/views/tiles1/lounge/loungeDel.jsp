<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>   

<style type="text/css">

</style>

<script type="text/javascript">

  	$(document).ready(function(){
     
    	$("button#btnDelete").click(function(){
    		
    		console.log("$('input#pw').val() : " + $("input#pw").val());
    		console.log("${requestScope.pw} : " + "${requestScope.pw}");
    		console.log("${requestScope.seq} : " + "${requestScope.seq}");
    		
    		if( $("input#pw").val() != "${requestScope.pw}") {
    			alert("글암호가 일치하지 않습니다.");
    			return;
    		}
    		else {
    			
    			if(confirm("정말로 글삭제를 하시겠습니까?")) {
    				// 폼(form)을 전송(submit)
	    			const frm = document.delFrm;
	    			frm.method = "post";
	    			frm.action = "<%= ctxPath%>/lounge/loungeDelEnd.action";
	    			frm.submit();
    			}
    		}
    		
    	});
     
  	});// end of $(document).ready(function(){})-------------------------------

</script>

<div class=" container-fluid mt-5 mb-5 mx-auto bg-white">
	<div class=" col-md-10 mx-auto my-5 justify-content-center" style="width:80%; ">

		<h4 class="d-flex justify-content-center mb-1 pb-1" style="padding-top:50px;"><span style="border-bottom: solid 3px;">라운지에서 글삭제하기</span></h4>
	
		<form name="delFrm">
		
			<div class="p-3 mb-5 mt-3" >
			
		        <table class="table table-bordered" style="margin:auto; width: 400px;">
			      	<tr>
			         	<th style="width: 20%; background-color: #DDDDDD;">글암호</th>
			         	<td>
			         		<input type="hidden" name="seq" value="${requestScope.seq}" /> <!-- ${requestScope.boardvo.seq} 으로 하면 안됨~ 넘어온 seq 로 잡아주자 -->
			            	<input type="password" name="pw" id="pw" /> <!-- 이 pw 는 안넘겨도 돼서 굳이 name 을 안 적어도됨 -->
			         	</td>
			      	</tr>
			   	</table>
		        
		        <div style="margin: 20px; text-align:center; padding-bottom:100px;">
			      	<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnDelete">글삭제완료</button>
			      	<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">글삭제취소</button>
			   	</div>
		        
		    </div>
		    
	    </form>
	    
	</div>
</div>