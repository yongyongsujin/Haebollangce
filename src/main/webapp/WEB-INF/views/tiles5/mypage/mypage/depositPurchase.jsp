<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%
    String ctxPath = request.getContextPath();
%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">

	div#mainPosition {
		margin: 99px 0;
	}
	
	.main_title {
		margin-left: 6%;
	}
	
	.body_style {
		margin-left: 5%;
		border-radius: 30px;
	}
	
	/* 충전할 예치금 시작 */
	input#deposit_input {
		font-size: 38px;
		font-weight: bold;
		color: #222222;
		width: 700px;
		border: none;
		border-bottom: solid #aaaaaa 1px;
		padding-bottom: 10px;
		text-align: center;
		position: relative;
		background: none;
		z-index: 5;
	}


	input#deposit_input::placeholder { color: #aaaaaa; }
	input#deposit_input:focus { outline: none; }

	label#deposit_label {
		position: absolute;
		color: #aaa;
		font-size: 20px;
		transition: all .2s;
		margin-left: -28%;
		margin-top: 24px;
	}

	input#deposit_input:focus ~ label#deposit_label, input#deposit_input:valid ~ label#deposit_label {
		font-size: 16px;
		margin-left: -27.8%;
		margin-top: -24px;
		color: #666;
		font-weight: bold;
	}

	button.purchase_button {
		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 1% 2%;
		text-align: center;
		font-size: 13pt;
		margin: 0 9px;
		transition: 0.3s;
		border-radius: 35px;
	}
		
	button.purchase_button:hover {
		background-color: #f43630;
		color: white;
	}
	/* 충전할 예치금 끝 */
	
	/* 결제현황 시작 */
	h2.second_title {
		font-weight: bold;
		margin-bottom: 25px;
	}
	
	td#deposit_after {
		font-size: 13pt;
		height: 60px;
		border-bottom: solid 1px #aaa;
		text-align: center;
	}

	td#purchase_deposit {
		font-size: 15pt;
		font-weight: bold;
		color: red;
		height: 60px;
		text-align: center;
	}
	
	td.after_title {
		font-size: 14pt;
		height:60px;
		border-bottom: solid #aaaaaa 1px;
	}
	
	button#go_payment {
		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 22px 0;
		text-align: center;
		font-size: 24pt;
		transition: 0.3s;
		font-weight: bold;
	}
	
	.error {
		color: red;
		padding: 10px 386px 0 481px;
	}
	
	/* 이용약관 시작 */
	a.Underline {
		text-decoration: underline;
		color: black;
		font-weight: bold;
		cursor: pointer;
		margin-left: 10px;
	}
	
	div#law_show {
		border: solid 1px black;
		margin-top: 10px;
		overflow: scroll;
		height: 92px;
		display: none;
	}
	
	div#law_introduce {
		padding: 0 20px;
		font-size: 12pt;
	}
	
	div#law_introduce_title {
		font-size: 13pt; 
		font-weight: bold; 
		padding: 10px;
	}  
	/* 이용약관 끝 */
}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){

		let merchant = Math.random().toString(36).substring(2, 12);
		
		$("input#purchase_code").val(merchant);
		
		let success_flag = false; 
		
		$("td#purchase_deposit").html("0 원");
		
		$("td#final_payment").html("0 원");
		
		$("div.error").hide();
		
		$("button#go_payment").attr("disabled", "disabled");
		
		
		<%-- 코인을 버튼을 눌러 사용하였을 경우 --%>
		$("button.purchase_button").click(function(e){
			
			$("div.error").hide();
			
			<%-- 표에 값 넣기 시작 --%>
			$("input#deposit_input").val($(e.target).val());
				
			$("td#purchase_deposit").html($(this).val() + " 원");
			
			const change_user_deposit = Number($("input#user_deposit").val()) + Number($(this).val());
			
			$("td#deposit_after").html(change_user_deposit + " 원");
			<%-- 표에 값 넣기 끝 --%>
			
			$("input#deposit").val($(this).val());
			
			$("input#deposit_input").css("border-bottom","solid #aaaaaa 1px");
			
			success_flag = true;
			
			if($("input:checkbox[id='law_check']").is(":checked") == true) {
				$("button#go_payment").prop("disabled", true);
				
				$("button#go_payment").css("background-color","#f43630").css("color","white");
			}
			
		});
		
		
		<%-- 상금 직접 입력하였을 경우 --%>
		$("input#deposit_input").change(function(){
			
			$("div.error").hide();
			
			var regExp = /^[0-9]+$/;
			
			const bool = regExp.test($(this).val());
			
			if(bool) {
				
				<%-- 표에 값 넣기 시작 --%>
				$("td#purchase_deposit").html($(this).val() + " 원");
									
				$("input#deposit_input").css("border-bottom","solid #aaaaaa 1px");	
				
				const change_user_deposit = Number($("input#user_deposit").val()) + Number($(this).val());
				
				$("td#deposit_after").html(change_user_deposit + " 원");	
				<%-- 표에 값 넣기 끝 --%>
				
				$("input#deposit").val($(this).val());
				
				$("button#go_payment").removeAttr("disabled");
				
				$("button#go_payment").css("background-color","#f43630").css("color","white");
				
				success_flag = true;
				
				if($("input:checkbox[id='law_check']").is(":checked") == true) {
					$("button#go_payment").prop("disabled", false);
					
					$("button#go_payment").css("background-color","#f43630").css("color","white");
				}
				
			}
			else {
				// 사용자가 문자를 입력한 경우
				$("div#error_only_num").show();
				
				$("td#purchase_deposit").html("0 원");
				
				$(this).val("");
				
				$("td#deposit_after").html($("input#user_deposit").val() + " 원");				
				
				$("input#deposit_input").css("border-bottom","solid red 2px");	
				
				success_flag = false;
				
				$("button#go_payment").prop("disabled", true);
					
				$("button#go_payment").css("background-color","#e6e1e1").css("color","black");
				
				
			}
				
		});		
		
		$("a#law_1").click(function(){
			
			let introduce = "예치금: 챌린지 신청을 위해 카드결제로 충전한 금액으로 달성율에 따라 상금으로 환급 받을 수 있는 금액";
			
			$("div#law_show").show();
			
			$("div#law_introduce_title").html("이용약관");
			
			$("div#law_introduce").html(introduce);
		});
		
		$("a#law_2").click(function(){
			
			let introduce = "예치금 취소: 예치금을 챌린지에 참여할 때 사용하였을 경우 취소가 불가능하며, 챌린지에 참여하지 않은 예치금에 한해서 취소가 가능합니다.";
			
			$("div#law_show").show();
			
			$("div#law_introduce_title").html("환불규정");
			
			$("div#law_introduce").html(introduce);
		});
		
		$("input:checkbox[id='law_check']").click(function(){
			// 체크가 되었고 충전금액도 입력했을때 변경해준다.
			if($("input:checkbox[id='law_check']").is(":checked") == true && success_flag) {
				$("button#go_payment").prop("disabled", false);
				
				$("button#go_payment").css("background-color","#f43630").css("color","white");
			}
			// 체크가 풀어졌을때
			if($("input:checkbox[id='law_check']").is(":checked") == false) {
				$("button#go_payment").prop("disabled", true);
				
				$("button#go_payment").css("background-color","#e6e1e1").css("color","black");
			}
		});

		<%-- 결제하기 시작 --%>
		$("button#go_payment").click(function(){
			payment(); 
		});
		<%-- 결제하기 끝 --%>
	});
	
	<%-- 결제하기 메소드 시작 --%>
	function payment(){
		
	   IMP.init('imp85248152');  // 아임포트에 가입시 부여받은 "가맹점 식별코드". 
		
	   <%-- 결제 요청 시작 --%>
	   IMP.request_pay({
	       pg : 'html5_inicis', // 결제방식 PG사 구분
	       pay_method : 'card',	// 결제 수단
	       merchant_uid : 'merchant_' + new Date().getTime(), // 가맹점에서 생성/관리하는 고유 주문번호
	       name : '결제테스트(코인충전|주문명)',	 // 코인충전 또는 order 테이블에 들어갈 주문명 혹은 주문 번호. (선택항목)원활한 결제정보 확인을 위해 입력 권장(PG사 마다 차이가 있지만) 16자 이내로 작성하기를 권장
	       amount : $("input#deposit").val(),	  // '${coinmoney}'  결제 금액 number 타입. 필수항목. 
	       buyer_email : "${requestScope.udto.email}",  // 구매자 email
	       buyer_name : "${requestScope.udto.name}",	  // 구매자 이름 
	       buyer_tel : "${requestScope.udto.mobile}",    // 구매자 전화번호 (필수항목)
	       buyer_addr : '',  
	       buyer_postcode : ''
	   }, function(rsp) {
	       
			if ( rsp.success ) { 
				
				<%-- 결제 성공시 문자보내기 시작 --%>
			/* 
				$.ajax({
					url:"/mypage/sms_ajax",
					type:"post",
					data:{
						"mobile":"${requestScope.udto.mobile}",
						"smsContent":"[해볼랑스] "
									 +$("input#deposit").val()+"원 예치금 충전\n에 성공했습니다."
					},
					dataType:"json",
					success:function(json){
						// console.log("~~~~ 확인용 : " + JSON.stringify(json));
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			        }
				});
				 */
				<%-- 결제 성공시 문자보내기 끝 --%>
				
				<%-- 결제 성공시 메일보내기 시작 --%>
				
				$.ajax({
					url:"/mypage/email_ajax",
					type:"post",
					data:{
						 "userid" : "${requestScope.udto.userid}",
						 "name" : "${requestScope.udto.name}",
					     "deposit" : $("input#deposit").val(),
					     "email" : "${requestScope.udto.email}",
					     "merchant" : $("input#purchase_code").val()
					},
					dataType:"json",
					success:function(json){
						console.log("~~~~ 확인용 : " + JSON.stringify(json));
						// ~~~~ 확인용 : {"n":1}
						
						
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			        }
				});
				
				<%-- 결제 성공시 메일보내기 끝 --%>
				
				<%-- 예치금 테이블에 데이터 넣어주기 시작 --%>
				const frm = document.purchase_form;
			     
				frm.action = '/mypage/purchase_success';
				frm.method = 'GET';
				frm.submit();
				<%-- 예치금 테이블에 데이터 넣어주기 끝 --%>
			     
			} else {
				alert( "실패 : 코드(" + rsp.error_code + ") / 메세지(" + rsp.error_msg + ")" );
			}
	   

	   });
	};
	<%-- 결제하기 메소드 끝 --%>
	
</script>

	<div id="mainPosition">
		<!-- index 상단 제목 시작 -->
		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h3 class="mb-0 text-gray-800 font-weight-bold main_title">예치금 충전하기</h3>
		</div>
		<!-- index 상단 제목 끝 -->
			
		<!-- 코인 입력 시작 -->
		<div class="row mb-4">
			<div class="col-lg-11 mb-4 body_style">
				<div id="notice" class="card shadow mb-4">
					<div class="card-body" style="padding:7rem 12rem;">
						
						<input type="text" id="deposit_input" class="offset-lg-2 col-lg-8 offset-lg-2" required />
						<label id="deposit_label">충전할 예치금(원)</label>
						<div id="error_only_num" class="error ">숫자만 입력하세요</div>
						<div id="all_button" class="col-lg-12" style="margin-top: 40px; padding: 0 3rem; margin-left:80px;">
							<button type="button" class="purchase_button" value="100">100원(test용)</button>
							<button type="button" class="purchase_button" value="10000">10,000원</button>
							<button type="button" class="purchase_button" value="30000">30,000원</button>
							<button type="button" class="purchase_button" value="50000">50,000원</button>
							<button type="button" class="purchase_button" value="100000">100,000원</button>
							<button type="button" class="purchase_button" value="200000">200,000원</button>
						</div>   
						
					</div>
					
					<div class="row" style="padding:0 8rem 2rem 8rem;">
						<div class="col-lg-6 mb-4" style="padding-left:85px;">
							<h2 class="second_title">예치금 충전</h2>
							<table style="width:100%;">
								<tr>
									<td class="after_title">충전 후 예치금 보유량</td>
									<td id="deposit_after">${requestScope.depo_dto.allDeposit} 원</td>
									<input type="hidden" name="user_deposit" id="user_deposit" value="${requestScope.depo_dto.allDeposit}" />
								</tr>
								<tr>
									<td class="after_title" style="border:none">충천할 예치금</td>
									<td id="purchase_deposit" style="border:none"></td>
									<input type="hidden" name="purchase_deposit" id="purchase_deposit" />
								</tr>
							</table>
						</div>
						<div class="col-lg-6 mb-4" style="padding-left:75px;">
							<h2 class="second_title">약관 동의 및 결제</h2>
							<table style="font-size:14pt;">
								<tr>
									<td>
										<input type="checkbox" id="law_check" /><a id="law_1" class="Underline">이용약관</a>과 <a id="law_2" class="Underline" style="margin:0;">환불규정</a>에 동의합니다.
									</td>	
								</tr>
							</table>
							<div id="law_show">
								
									<div id="law_introduce_title"></div>
								
									<div id="law_introduce"></div>
									
							</div>
						</div>
					</div>
					<div class="row" style="padding:0 14px;">
						<form name="purchase_form" style="width:100%;">
							<input type="hidden" name="userid" id="userid" value="${requestScope.udto.userid}" />
							<input type="hidden" name="deposit" id="deposit"/>
							<input type="hidden" name="email" id="email" value="${requestScope.udto.email}" />
							<input type="hidden" name="purchase_code" id="purchase_code" />
							<button type="button" class="col-lg-12" id="go_payment">결 제 하 기</button>
						</form>
					</div>
				</div>
			</div>
			
		</div>
		<!-- 코인 입력 끝 -->
		
	</div>


</body>
</html> 
