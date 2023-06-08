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
	
	 /* 충전할 예치금 시작  */
	input#reward_input {
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
		margin-left:17%;
	}


	input#reward_input::placeholder { color: #aaaaaa; }
	input#reward_input:focus { outline: none; }

	label#reward_label {
		position: absolute;
		color: #aaa;
		font-size: 20px;
		transition: all .2s;
		margin-left: -29%;
		margin-top: 24px;
	}

	input#reward_input:focus ~ label#reward_label, 
	input#reward_input:valid ~ label#reward_label {
		font-size: 16px;
		margin-left: -27.3%;
		margin-top: -24px;
		color: #666;
		font-weight: bold;
	}

	button#all_use {
		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 7px 12px;
		text-align: center;
		font-size: 13pt;
		margin: 0 18%;
		transition: 0.3s;
		border-radius: 35px;
	}
		
	button#all_use:hover {
		background-color: #f43630;
		color: white;
	}
	/* 충전할 예치금 끝 */
	
	/* 결제현황 시작 */
	h2.second_title {
		font-weight: bold;
		margin-bottom: 25px;
	}
	
	td.after_title {
		font-size: 14pt;
		height:60px;
	}
	
	td#change_reward,
	td#td_input_reward {
		font-size: 14pt;
		font-weight: bold;
		margin-bottom: 25px;
		border-bottom: solid 1px #aaa;
		text-align: center;
	}
	
	td#get_reward {
		font-size: 15pt;
		font-weight: bold;
		height: 60px;
		text-align: center;
		color: red;
	}

	button#reward_convert {
		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 22px 0;
		text-align: center;
		font-size: 24pt;
		transition: 0.3s;
		font-weight: bold;
		width: 100%;
	}
	/* 결제현황 끝 */
	
	.error {
		color: red;
		text-align: center;
		margin-top: 20px;
	}

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
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		<%-- 보유 상금 가지고 오기 시작 --%>
		$.ajax ({
			url:"/mypage/user_deposit_ajax",
			type:"GET",
			data:{
				"userid":"jisu"
			},
			dataType:"json",
			success:function(json){
				// 사용자가 관심태그로 설정한 카테고리로 있는 챌린지들 추천
				// console.log(JSON.stringify(json));
				
				if(json.user_all_reward > 3000) {
				
					$("td#change_reward").html(json.user_all_reward + " 원");
					
					$("button#all_use").val(json.user_all_reward);
					
				}
				else {
					alert("상금은 3000원부터 환전이 가능합니다.\n현재 보유중인 상금: " + json.user_all_reward);
					
					location.href = "mypageHome";
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		<%-- 보유 상금 가지고 오기 끝 --%>
		
		
		let all_payment = 0;
		
		let success_flag = false; 
		
		$("td#get_reward").html("0원");
		
		$("td#change_reward").html("0원");
		
		$("td#td_input_reward").html("0원");
		
		$("div.error").hide();
		
		$("button#reward_covert").prop("disabled", true);
		
		<%-- 코인을 버튼을 눌러 사용하였을 경우 --%>
		$("button#all_use").click(function(){
			
			if( Number($(this).val()) > 3000 ) {
				// 환전 가능할 경우
				$("div.error").hide();
				
				$("input#reward_input").val($(this).val());
				
				$("td#td_input_reward").val($(this).val() + "원");
				
				const final_get_reward = $(this).val() - ($(this).val()*0.01);
				
				$("td#get_reward").html( final_get_reward + "원");
				
				const change_user_reward = Number($("input#reward").val()) + Number($(this).val());
				
				$("td#change_reward").html(change_user_reward + "원");
				
				$(this).css("border-bottom","solid #aaaaaa 1px");
				
				success_flag = true; 
				
				$("input#reward").val($(this).val());
				
				$("button#reward_covert").prop("disabled", true);
			}
			else {
				$("div.error").hide();
				
				$("div#error_min").show();

				$("td#get_reward").html("0원");
				
				$("td#td_input_reward").html("0원");
				
				$("td#change_reward").html("0원");
				
				$("input#reward_input").css("border-bottom","solid red 2px");	
				
				success_flag = false; 
				
				$("button#reward_covert").prop("disabled", false);
			}
			
			if($("input:checkbox[id='law_check']").is(":checked") == true && success_flag) {
				$("button#reward_convert").prop("disabled", false);
				
				$("button#reward_convert").css("background-color","#f43630").css("color","white");
			}
			
		});
		
		
		<%-- 상금 직접 입력하였을 경우 --%>
		$("input#reward_input").change(function(){
			
			$("div.error").hide();
			
			var regExp = /^[0-9]+$/;
			
			const bool = regExp.test($(this).val());
			
			if(bool) {
				// 숫자를 입력하였을 경우
				if( Number($(this).val()) < 3000 ) {
					// 사용자가 입력한 상금이 3000원 미만일 경우
					$("div.error").hide();
					
					$("div#error_min").show();
					
					$("td#get_reward").html("0원");
					
					$("td#td_input_reward").html("0원");
					
					$("td#change_reward").html("0원");
					
					$(this).css("border-bottom","solid red 2px");	
					
					success_flag = false; 
					
					$("button#reward_covert").prop("disabled", true);
				}
				else{
				
					if( Number($(this).val()) > Number($("button#all_use").val()) ) {
						// 3000원 이상, 가지고 있는 상금보다 더 큰 금액을 입력할 경우
						$("div.error").hide();
						
						$("div#error_max").show();
						
						$("td#get_reward").html("0원");
						
						$("td#td_input_reward").html("0원");
						
						$("td#change_reward").html("0원");
						
						$(this).css("border-bottom","solid red 2px");	
						
						success_flag = false; 
						
						$("button#reward_covert").prop("disabled", true);
					}
					else {
						// 3000원 이상, 올바르게 입력할 경우
						$("input#reward").val($(this).val());
						
						$("td#td_input_reward").html($(this).val() + "원");
						
						const final_get_reward = $(this).val() - ($(this).val()*0.01);
						
						$("td#get_reward").html( final_get_reward + "원");
						
						const change_user_reward = Number($("button#all_use").val()) - Number($(this).val());
						
						$("td#change_reward").html(change_user_reward + "원");
											
						$(this).css("border-bottom","solid #aaaaaa 1px");
						
						success_flag = true; 
						
						/* $("input#law_check").prop("disabled", false); */
						
						$("button#reward_covert").prop("disabled", false);
					}				
					
				}
			}	
			else {
				// 사용자가 문자를 입력한 경우
				$("div#error_only_num").show();
				
				$("td#td_input_reward").html("0원");
				
				$("td#change_reward").html("0원");
				
				$("td#get_reward").html("0원");
				
				$(this).val("");
				
				$(this).css("border-bottom","solid red 2px");
				
				success_flag = false; 
			}
			
			// 체크가 되었고 충전금액도 입력했을때 변경해준다.
			if($("input:checkbox[id='law_check']").is(":checked") == true && success_flag) {
				$("button#reward_convert").prop("disabled", false);
				
				$("button#reward_convert").css("background-color","#f43630").css("color","white");
			}
			// 체크가 풀어졌을때
			if(success_flag == false) {
				$("button#reward_convert").prop("disabled", true);
				
				$("button#reward_convert").css("background-color","#e6e1e1").css("color","black");
			}
			
		});		
			
		
		$("a#law_1").click(function(){
			
			let introduce = "상금: 챌린지를 100% 달성 시, 해볼랑스가 제공하는 금액으로," 
						  +	"챌린지에 따라 받을 수 있는 상금은 다를 수 있으며, 챌린지 100% 달성자에게만 지급됩니다.";
			
			$("div#law_show").show();
			
			$("div#law_introduce_title").html("이용약관");
			
			$("div#law_introduce").html(introduce);
		});
		
		$("a#law_2").click(function(){
			
			let introduce = "상금 전환: 상금은 3000원 이상부터 출금할 수 있으며,"
						  + "출금시 1%의 수수료가 발생합니다.";
			
			$("div#law_show").show();
			
			$("div#law_introduce_title").html("상금정책");
			
			$("div#law_introduce").html(introduce);
		});
		
		$("input:checkbox[id='law_check']").click(function(){
			// 체크가 되었고 충전금액도 입력했을때 변경해준다.
			if($("input:checkbox[id='law_check']").is(":checked") == true && success_flag) {
				$("button#reward_convert").prop("disabled", false);
				
				$("button#reward_convert").css("background-color","#f43630").css("color","white");
			}
			// 체크가 풀어졌을때
			if($("input:checkbox[id='law_check']").is(":checked") == false) {
				$("button#reward_convert").prop("disabled", true);
				
				$("button#reward_convert").css("background-color","#e6e1e1").css("color","black");
			}
		});
 
  
		$("input:checkbox[id='law_check']").click(function(){
			
			if(success_flag) {
				$("button#reward_convert").prop("disabled", false);
				
				$("button#reward_convert").css("background-color","#f43630").css("color","white");
			}
			else {
				alert("환전받을 상금을 먼저 입력해주세요.");
				
				$("input#law_check").prop("disabled", true);
				
				$("button#reward_convert").prop("disabled", true);
				
				$("button#reward_convert").css("background-color","#e6e1e1").css("color","black");
			}
			
		});		
  
		$("button#reward_convert").click(function(){
			reward_convert();
		});
		
	});
	
	function reward_convert(){
		
		<%-- 상금 테이블에 데이터 변경(상금 보유량 감소) 시작 --%>
		const frm = document.reward_form;
	     
	     frm.action = '/mypage/reward_convert';
	     frm.method = 'POST';
	     frm.submit();
	     <%-- 상금 테이블에 데이터 변경(상금 보유량 감소) 끝 --%>
				
	};
	
</script>

<div id="mainPosition">

	<div class="row mb-4">
		<div class="col-lg-11 mb-4" style="margin-left:5%;">
			<div id="notice" class="card shadow mb-4">
				<%-- 상금 입력 시작 --%>
				<div class="card-header py-3">
					<h4 class="m-0 font-weight-bold text-primary">환전할 상금을 입력해주세요.</h4>
 				</div>
				<div class="card-body" style="padding:7rem 12rem;">
					<input type="text" id="reward_input" class="offset-lg-2 col-lg-8 offset-lg-2" required>
					<label id="reward_label">환전할 상금(원)</label>
					<div id="error_max" class="error">현재 가지고 있는 상금보다 더 큰 금액은 입력하지 못합니다.</div>
					<div id="error_min" class="error">상금은 3,000원부터 환전이 가능합니다.</div>
					<div id="error_only_num" class="error">숫자만 입력해주세요.</div>
					<div style="font-size:14pt; margin:32px 19%;">현재 보유 상금:</div>
					<button type="button" id="all_use">상금 전액 사용</button>  
					
				</div>
				<%-- 상금 입력 끝 --%>
				
				<%-- 상금 입력 후 현황 시작--%>
				<div class="row" style="padding:0 8rem 2rem 8rem;">
					<div class="col-lg-6 mb-4" style="padding-left:85px;">
						<h2 class="second_title">상금 전환</h2>
						<table style="width:100%;">
							<tr>	
								<td class="after_title" style="border-bottom: solid 1px #aaa;">입력한 상금량</td>
								<td id="td_input_reward"></td>
							</tr>
							<tr>	
								<td class="after_title" style="border-bottom: solid 1px #aaa;">상금 보유량</td>
								<td id="change_reward"></td>
							</tr>
							<tr>
								<td class="after_title">최종 환전 상금<a style="font-size:10pt;color:red;">1%의 수수료가 있습니다.</a></td>
								<td id="get_reward"></td>
							</tr>
						</table>
					</div>
					<%-- 상금 입력 후 현황 끝--%>
					
					<%-- 이용 약관 시작 --%>
					<div class="col-lg-6 mb-4" style="padding-left:75px;">
						<h2 class="second_title">약관 동의 및 결제</h2>
						<table style="font-size:14pt;">
							<tr>
								<td>
									<input type="checkbox" id="law_check" />
									<a id="law_1" class="Underline">이용약관</a>과 
									<a id="law_2" class="Underline" style="margin:0;">상금정책</a>에 동의합니다.
								</td>	
							</tr>
						</table>
						<div id="law_show">
								
								<div id="law_introduce_title"></div>
							
								<div id="law_introduce"></div>
								
						</div>
					</div>
				</div>
				<%-- 이용 약관 끝 --%>
				
				<%-- 환전하기 버튼 시작 --%>
				<div class="row" style="padding:0 14px;">
					<form name="reward_form" style="width:100%;">
						<input type="hidden" name="userid" value="admin4" />
						<input type="hidden" name="reward" id="reward" />
						<button type="button" class="reward_convert" id="reward_convert">환 전 하 기</button>
					</form>
				</div>
				<%-- 환전하기 버튼 끝 --%>
			</div>
		</div>
		
	</div>
	<!-- 상금 입력 끝 -->
		
	</div>


</body>
</html> 
