<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%
    String ctxPath = request.getContextPath();
%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	div#mainPosition {
		margin: 99px 5% 0 5%;
	}
	
	div#MPI_title_1 {
		text-align:center;
		font-size:18pt;
	}
	
	div#MPI_title_2 {
		 text-align:center;
		 font-size:15pt;
		 margin: 42px 0 85px 0;
	}
	
	button#go_button {
		margin-left: 2%;
		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 1% 2%;
		text-align: center;
		transition: 0.3s;
		border-radius: 35px;
	}
	
	button#go_button:hover {
		background-color: #f43630;
		color: white;
	}
	
	input {
	  font-size: 15px;
	  color: #222222;
	  width: 300px;
	  border: none;
	  border-bottom: solid #aaaaaa 1px;
	  padding-bottom: 10px;
	  text-align: center;
	  position: relative;
	  background: none;
	  z-index: 5;
	
	}
	
	input::placeholder { color: #aaaaaa; }
	input:focus { outline: none; }
	
	span#MPI_underline {
	  display: block;
	  position: absolute;
	  bottom: 0;
	  left: 50%;  /* right로만 바꿔주면 오 - 왼 */
	  background-color: #666;
	  width: 0;
	  height: 2px;
	  border-radius: 2px;
	  transform: translateX(-50%);
	  transition: 0.5s;
	}
	
	label {
		position: absolute;
		color: #aaa;
		left: 50%;
		transform: translateX(-50%);
		font-size: 20px;
		bottom: 8px;
		transition: all .2s;
	}
	
	input:focus ~ label, input:valid ~ label {
		font-size: 16px;
		bottom: 40px;
		color: #666;
		font-weight: bold;
	}
	
	input:focus ~ span, input:valid ~ span {
		width: 100%;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		/*
		$("input#input_pwd").bind("keydown", function(e){
			if(e.keyCode == 13) {
				go_identify();
			}
		});
		*/
	});
	
	/* 패스워드 확인 메소드 시작 */
	function go_identify() {
		/* 
		const passwd = $("input#input_pwd").val();
		
		if(passwd == $("input#pwd").val()) {
			const frm = document.pwd_identify_form;
			
			frm.action = '/mypage/mypageInfoEdit';
		    frm.method = 'POST';
		    frm.submit();
		}
		 */
		
		 
		$.ajax ({
			url : "/mypage/pw_identify_ajax",
            type : "GET",
            data: {
            	"userid":"${requestScope.udto.userid}",
            	"pw":$("input#input_pwd").val()
            },
            success:function(result){
              
            	console.log(JSON.stringify(result));
            	
            	// 비번 확인하기
            	if(result == "success") {
            		
            		const frm = document.pwd_identify_form;
            		
            		frm.action = '/mypage/mypageInfoEdit';
            	    frm.method = 'POST';
            	    frm.submit();
            		
            	} 
            	else {
            		alert("입력한 비밀번호가 다릅니다.\n다시 입력해주세요.");
            		
            	}
            	
            },
            error: function(request, status, error){
            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); 
	}
	/* 패스워드 확인 메소드 끝 */
	
</script>

	<div id="mainPosition">
		<!-- 새로운 챌린지 추천 시작 -->
		<form name="pwd_identify_form" style="background-color:white; padding: 273px 0;">
			<div class="row">
				<div class="col-lg-12 mb-8">
					<div>
						<div id="MPI_title_1">비밀번호 확인이 필요합니다.</div>
						<div id="MPI_title_2">현재 사용중이신 비밀번호를 입력해주세요.</div>
						<input type="password" name="pwd" id="input_pwd" class="offset-lg-4 col-lg-4 offset-lg-4" required>
						<label>passward</label>
						<span id="MPI_underline"></span>
						<button type="button" id="go_button" onclick="go_identify();">확인</button>
						<input type="hidden" name="userid" id="userid" value="${requestScope.udto.userid}"/>
						<input type="hidden" name="pw" id="pw" value="${requestScope.udto.pw}"/>
						<input type="hidden" name="result" value="${requestScope.result}" />
					</div>
				</div>
			</div>
		</form>
		<!-- 새로운 챌린지 추천 끝 -->		
	</div>
	<!-- 메인 끝 -->


</body>
</html> 
