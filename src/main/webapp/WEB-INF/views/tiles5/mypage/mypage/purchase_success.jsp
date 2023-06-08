<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%
    String ctxPath = request.getContextPath();
%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	div#mainPosition {
		margin: 71px 75px 0 330px;
	}
	
	div#MPI_title_1 {
		text-align:center;
		font-size:18pt;
	}
	
	div#MPI_title_2 {
		 text-align:center;
		 font-size:15pt;
		 margin: 42px 0 100px 0;
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
		
		
		
	});
	
	
</script>

	<div id="mainPosition">
		<!-- 새로운 챌린지 추천 시작 -->
		<form style="background-color:white; padding: 273px 0;">
			<div class="row">
				<div class="col-lg-12 mb-8">
					<div>
						<div id="MPI_title_1">결재성공</div>
						<div id="MPI_title_2">현재 사용중이신 비밀번호를 입력해주세요.</div>
						<input type="password" id="MPI_pwd" class="offset-lg-4 col-lg-4 offset-lg-4" required>
						<label>passward</label>
						<span id="MPI_underline"></span>
					</div>
				</div>
			</div>
		</form>
		<!-- 새로운 챌린지 추천 끝 -->		
	</div>
	<!-- 메인 끝 -->


</body>
</html> 
