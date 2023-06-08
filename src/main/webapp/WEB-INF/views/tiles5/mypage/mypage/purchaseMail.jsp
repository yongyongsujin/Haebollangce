<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
%>
      

<style>

@font-face {
       font-family: 'Pretendard-Regular';
       src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
       font-weight: 400;
       font-style: normal;
   }

   @font-face {
       font-family: 'SDSamliphopangche_Basic';
       src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts-20-12@1.0/SDSamliphopangche_Basic.woff') format('woff');
       font-weight: normal;
       font-style: normal;
   }
   
   @font-face {
    font-family: 'SUITE-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
    font-weight: 400;
    font-style: normal;
}
   
   h1 {
   	 font-family: 'Pretendard-Regular';
   }
   
   div {
   	font-family: 'SUITE-Regular';
   }
   
   div#table {
   	border: 1px solid black;
   }
   
   div.table_h {
   	padding: 20px 30px;
   }
   
   div.table_border {
   	border-top: 1px solid #aaaaaa;
   	border-bottom: 1px solid #aaaaaa;
   }
   
   span {
   	float: right;
   }
   
   div#footer {
   	margin-top: 34px;
   	background-color: #f2f2f2;
   	height: 120px;
   	padding: 38px 30px;
   }
   
   div.container {
   	padding:25px; 
   	width:35%; 
   	border:5px dashed #aaaaaa;
   }
  
</style>
	<div class="container">
		<h1>Haebollangce</h1>
		<div style="margin-top:50px;">
			모두 함께 도전하는 즐거움! 해볼랑스 입니다.
		</div>
		<div style="margin:20px 0;">
			'홍길동' 님의 예치금 결제 내역을 보내드립니다.
		</div>
		<div id="table">
			<div class="table_h">결제 일시<span>~</span></div>
			<div class="table_h table_border">주문번호<span>00000000</span></div>
			<div class="table_h table_border">보유한 예치금<span>1000원</span></div>
			<div class="table_h">결제한 금액 및 충전된 예치금<span style="color:red; font-weight:bold;">1000원</span></div>
		</div>
		
		<div id="footer">
			<div>본 메일은 발신전용 메일 이므로 회신이 불가합니다.</div>
			<div>결제하지 않은 사항이거나 문의사항이 있으실 경우 <a href="">고객센터</a>로 문의바랍니다.</div>
		</div>
	</div>
