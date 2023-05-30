<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> 

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="/bootstrap-4.6.0-dist/css/bootstrap.min.css" >

<!-- Optional JavaScript -->
<script type="text/javascript" src="/js/jquery-3.6.4.min.js"></script>
<script type="text/javascript" src="/js/bootstrap.bundle.min.js" ></script>


<style type="text/css">

	div.info {
		height: 50%;
		display: flex; 
		justify-content: space-between; 
		padding: 0 40px 0 40px;
		font-size: 16pt;
		font-weight: bold; 
		line-height: 45px; 
	}
	
</style>
    
<script type="text/javascript">

	$(document).ready(function(){
		$("button#btn_close").click(function(){
			close();
		});
	});
	
</script>

<div class="container">
	<h3 style="height: 100px; text-align: center; margin: 0; line-height: 90px; font-weight: bold;">참가 완료되었습니다 &#x1F44F </h3>
	<div style="border: solid 1px black; height: 100px; padding: 0 40px 0 40px;" >챌린지 정보 보여질 예정</div>
	<div style="height: 100px;">
		<div class="info"><span>참가 예치금</span><span>0원</span></div>
		<div class="info"><span>예치금 잔액</span><span>0원</span></div>
	</div>
	<%-- 기능확장시 <button>알람 설정하기</button> --%>
	<div style="display: flex; justify-content: center; align-items: center; height: 75px;">
		<button id="btn_close" type="button" class="btn btn-secondary">확인</button>
	</div>
</div>