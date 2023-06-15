<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String ctxPath = request.getContextPath();
%>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.6/dist/sweetalert2.all.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.6/dist/sweetalert2.min.css" rel="stylesheet">

<style type="text/css">

	div.join_body {
		display: flex; 
		align-items: center;
	}
	div.bold {
		font-size: 19pt;
		font-weight: bold;
		justify-content: space-between;
	}
	div.basic {
		font-size: 14pt;
		font-weight: bold;
		justify-content: space-between;
	}
	div#join_price{
		border-bottom: solid 3px #f43630; 
		width: 100%; 
		height: 100%; 
		display: flex; 
		align-items: center; 
		justify-content: center; 
		font-weight: bold; 
		font-size: 20pt; 
		letter-spacing:2px;
	}
	input[type="number"]::-webkit-inner-spin-button {
	    -webkit-appearance: none;
	    margin: 0;
	}
	p.price_choice{
		box-shadow: 0px 0px 3px 1px gray; 
		display: inline-block;
		width:150px; 
		height: 100%; 
		border-radius: 50px; 
		text-align: center; 
		line-height: 57px;
	}
	div#challenge_info{
		border: solid 2px #CCCCCC;
		border-radius: 10px; 
		display:flex; 
		width: 180px; 
		height: 50px; 
		font-size: 13pt; 
		font-weight: bold; 
		align-items: center; 
		justify-content:center;
		cursor: pointer;
		background-color: white;
	}
	div#point_charge{
		border: solid 1px black;
		border-radius: 10px; 
		display:flex; 
		width: 120px; 
		height: 50px; 
		font-size: 13pt; 
		font-weight: bold; 
		align-items: center; 
		justify-content:center;
		background-color: #EB534C; 
		color: white;
	}
	div#challenge_join{
		border: solid 1px black;
		border-radius: 10px; 
		display:flex; 
		width: 120px; 
		height: 50px; 
		font-size: 13pt; 
		font-weight: bold; 
		align-items: center; 
		justify-content:center;
		background-color: #EB534C; 
		color: white;
	}
	div#explain_price{
		 height: 10%; 
		 font-weight: 10pt; 
		 width: 100%; 
		 display: flex; 
		 justify-content: center; 
		 color: #808080;
	}
	div#modal_content_js{
		font-size: 14pt;
		font-weight: bold;
	}
	div#point_charge{
		cursor: pointer;
		border: solid 2px black;
	}
	p.price_choice{
		cursor: pointer;
		font-size: 15pt;
	}
	input#price {
		border:1px solid white; 
		background-color:transparent; 
		text-align: center; 
		font-size: 25pt; 
		width: 130px;
		font-weight: bold;
	}
	div.challenge_join_btn{
		border: solid 2px #CCCCCC;
		border-radius: 10px; 
		display:flex; 
		width: 120px; 
		height: 50px; 
		font-size: 13pt; 
		font-weight: bold; 
		align-items: center; 
		justify-content:center;
		background-color: #EB534C; 
		color: white;
		cursor: pointer;
	}
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		const str_startDate = "${chaDTO.startDate}";
		const startDate = new Date(str_startDate);
		const today = new Date();
		
		if (startDate <= today) {
			// 챌린지가 이미 시작되었을 경우
			
			Swal.fire({
				icon: "error",
				html : "<div style='font-weight: bold; font-size: 16pt;'>이미 시작된 챌린지로<br>참여가 불가합니다.</div>",
				confirmButtonColor: "#EB534C",
				confirmButtonText: "확인"
			}).then(function(){
				javascript:history.back();
			});
		}
		
		// 챌린지 안내 호버 효과
		$("div#challenge_info").hover(function(e) {
			$(e.target).css({"background-color":"#EB534C","color":"white"});
		}, function(e) {
			$(e.target).css({"background-color":"white","color":"black"});
		}); // end $("div#challenge_info").hover
		
		
		// 금액버튼 클릭시 금액 변동되는 함수
		$("p.price_choice").bind("click", function(e){
				
			$("p.price_choice").css({"background-color":"white", "color":"black"});
			$(this).css({"background-color":"#EB534C", "color":"white"});
			
			$("input#price").val( $(this).children().html() );
			$("span#join_price").html( Number(($(this).children().text())).toLocaleString('en')+"원"); 

			const success_price = "(예상) "+Number(($(this).children().text())).toLocaleString('en')+" ~ "+(Number(($(this).children().text())) * 1.035).toLocaleString('en')+"원"
			$("span#success_price").html(success_price);
			change_deposit();
		}); // end $("p.price_choice").bind("click")
		
		$("p#price_10000").trigger("click"); // 초기화면용
		
		// 금액 키보드로 입력시 함수
		$("input#price").on("keyup", function(e){
			
			let price = $(this).val();
			
			while ( price.indexOf('0') == "0" ) {
				price = price.substring(1);
			}
			
			$(this).val(price);
			price = Number(price);
			
			if ( price < 0) {
				$(this).val("10000");
			}
			else if ( price > 200000) { 
				$(this).val("200000");
				price = Number($(this).val());
			}
			
			const price_list = $("p.price_choice").children();
			
			$(price_list).each(function (index, elem){
				
				if ( Number($(this).text()) == price) {
					$("p.price_choice").css({"background-color":"white", "color":"black"});
					$(this).parent().css({"background-color":"#EB534C", "color":"white"});
					return false;
				}
				else {
					$("p.price_choice").css({"background-color":"white", "color":"black"});
				}
			
				$("span#join_price").html( price.toLocaleString('en')+"원"); 

				const success_price = "(예상) "+price.toLocaleString('en')+" ~ "+(price * 1.035).toLocaleString('en')+"원"
				$("span#success_price").html(success_price);
				
			});
			
			if (price == 10000) {
				$("p#price_10000").trigger("click");
			}
			
			change_deposit();
			
		}); // end $("input#price").on("keyup")
		
		
		// 예치금을 10000 이하로 설정했을시
		$("input#price").bind("change", function() {
			
			const price = Number($(this).val());
			
			if ( 0 < price && price < 10000) {
				Swal.fire({
					icon: "warning",
					title: "최소 예치금액은 1만원입니다.",
					confirmButtonColor: "#EB534C",
					confirmButtonText: "확인"
				});
				$("p#price_10000").trigger("click");
				$(this).focus();
			}
		});
		
		
		// 참가하기 클릭시
		$("div#join_challenge").click(function(){
			
			const check_deposit = $("span#after_deposit").html();
			
			if ( check_deposit == '잔액부족' ) {
				Swal.fire({
					icon: "error",
					title: "예치금 잔액이 부족합니다.<br>예치금 충전 후 이용해주세요.",
					confirmButtonColor: "#EB534C",
					confirmButtonText: "확인"
				});
				return;
			}
			
			// insert 할 form 전송
			
			// 팝업창 띄우기
			const url = "<%= request.getContextPath()%>/challenge/joinEnd";
			
			// 너비 800, 높이 600인 팝업창을 화면 가운데 위치시키기
			const pop_width = 600;
			const pop_height = 400;
			const pop_left = Math.ceil((window.screen.width - pop_width)/2); // 정수로 만듬
			const pop_top = Math.ceil((window.screen.height - pop_height)/2);
			
			window.open(url, "challengejoin", "left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height);
			
			const frm = document.challenge_info;
			frm.action = "<%= request.getContextPath()%>/challenge/joinEnd";
			frm.method = "post";
			frm.target = "challengejoin"; // 팝업창으로 form 데이터 전송
			frm.submit();
			
			location.href="<%= request.getContextPath()%>/challenge/certifyList";
			
		});
		
		// 예치금 충전 클릭시 
		$("div#point_charge").click(function(){
			
			Swal.fire({
				icon: "info",
				title: "결제페이지로 이동합니다",
				confirmButtonColor: "#EB534C",
				confirmButtonText: "확인",
				showCancelButton: true,
				cancelButtonText: '취소',
				cancelButtonColor: '#999999'
			}).then(function(result){
				if(result.isConfirmed){
					const url = window.location.href;
					sessionStorage.setItem("URL", url);
					location.href="<%= ctxPath%>/mypage/depositPurchase";
				}
			})
		})
		
		
	}); // end $(document).ready

	// 보유 예치금에 따른 결제 후 보유예치금 계산하는 함수
	function change_deposit() {
		
		let userDeposit = "${userDeposit}"; 

		let join_price = $("span#join_price").html();
		join_price = join_price.replace("원", "").replace(",", "").trim();
		
		let after_deposit = Number(userDeposit) - Number(join_price);

		$("input#after_deposit").val(after_deposit);
		
		if ( after_deposit < 0 ) {
			after_deposit = '잔액부족';
		}
		else {
			after_deposit = after_deposit.toLocaleString('en')+"원";
		}
		
		$("span#after_deposit").html(after_deposit);
	}
	
</script>

<div class="container-fluid" style="background-color: #f4f4f4;">
<div class="container pb-5" style="border-radius: 20px; background-color: white; padding: 0; text-align: center;"> 
	<br>
	<h3 style="font-weight: bold;">챌린지 참가하기</h3>
	<br>
	<div id="challenge_join_header" class="mx-5" style="height: 250px;">
		<div class="join_body" style="box-shadow: 0px 0px 10px 1px gray; display: flex; justify-content: center; align-items:center; width: 100%; height: 100%; border-radius: 20px; font-size: 16pt;">
			<div style="height: 100%; width: 30%;">
	  			<img src="<%= ctxPath%>/images/${chaDTO.thumbnail}" style="object-fit: cover; height:90%; width: 90%; margin-top:12px; border-radius: 20px;"/>
  			</div>
  			<div style="text-align: left; width: 70%;">
  				<div style="display: flex; justify-content: space-between;">
	  				<div class="mt-1" style="width: 180px; height: 35px; line-height: 34px; background-color: rgb(244, 244, 244); text-align: center; border-radius: 20px;">
	  					<div>${chaDTO.categoryName}</div>
	  				</div>
	  				<div class="mt-1 pr-3" style="font-weight: bold;">
	  					<span class="mr-2">${chaDTO.memberCount}명 참가 중</span>
	  				</div>
  				</div>
  				<div style="display: flex; justify-content: space-between;">
	  				<h4 class="my-3" style="font-weight: bold; display:inline-block;">${chaDTO.challengeName}</h4>
	  				<span class="pr-3" style="display:flex; align-items: center;">개설자 : ${chaDTO.fkUserid}</span>
  				</div>
  				<div class="mt-4 pr-3" style="display: flex; justify-content: space-between;">
  					<div><span>인증빈도 - </span><span>${chaDTO.frequency }</span></div>
  					<div><span>인증시간 - </span><span>${chaDTO.hourStart} ~ ${chaDTO.hourEnd}</span></div>
  				</div>
  				<div class="mr-3" style="display: flex; justify-content: space-between; margin-top: 30px;">
	  				<div></div>
	  				<div>
		  				<span>기간 : </span>
		  				<h5 class="pt-3" style="display: inline-block;">${chaDTO.startDate} ~ ${chaDTO.enddate}</h5>
	  				</div>
  				</div>
  			</div>
		</div>
	</div>

	<div id="challenge_join_price" class="mx-5 mb-3 mt-5" style="height: 300px;"> 
		<div class="join_body bold pl-5" style="height: 25%;">예치금</div>
		<div class="join_body basic pl-5" style="height: 15%;">시작 전에 돈을 걸면 종료 후 환급해드려요 !</div>
		<div class="join_body px-5 pb-3" style="height: 25%; width: 100%;">
			<div id="join_price">
				<input id="price" type="number" value="">원 
			</div>
		</div>
		<div class="join_body px-5 " style="height: 20%;">
			<div style="display: flex; width: 100%; height: 100%; justify-content: space-between;">
				<p class="price_choice" id="price_10000"><span class="price_list">10000</span>원</p>
				<p class="price_choice"><span class="price_list">30000</span>원</p>
				<p class="price_choice"><span class="price_list">50000</span>원</p>
				<p class="price_choice"><span class="price_list">100000</span>원</p>
				<p class="price_choice" id="price_200000"><span class="price_list">200000</span>원</p>
			</div> 
		</div> 
		<div id="explain_price" class="join_body">최소 1만원 ~ 최대 20만원 (1만원 단위 가능)</div>
	</div> 
	 
	<div id="challenge_join_guide" class="px-5" style="height: 300px; background-color: #FBECEA;">
		<div class="join_body basic px-5" style="height: 20%;"><span>100% 성공</span><span id="success_price"></span></div>
		<div class="join_body basic px-5" style="height: 20%;"><span>80% 이상 성공</span><span id="join_price"></span></div>
		<div class="join_body basic px-5" style="height: 20%;"><span>80% 미만 성공</span><span>예치금 일부 환급 (성공률 만큼)</span></div>
		<div class="join_body" style="height: 40%; align-items: center; justify-content:center; ">
			<div id="challenge_info" data-toggle="modal" data-target="#challenge_info_Modal">챌린지 환급 안내</div>
			<%-- 모달창 --%>
			<div class="modal fade" id="challenge_info_Modal">
				<div class="modal-dialog modal-dialog-centered"> 
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" style="font-weight: bold;">챌린지 환급 안내</h5>
				        	<button type="button" class="close" data-dismiss="modal">&times;</button>
			     		</div>
			     		<div id="modal_content_js"class="modal-header" style="display: block;">
			        		<div class="my-2" style="display: flex; justify-content: space-between;">
				        		<span>100% 성공</span><span>예치금 전액 환급 + 상금</span>
			        		</div>
			        		<div class="my-2" style="display: flex; justify-content: space-between;">
			        			<span>80% 이상 성공</span><span>예치금 전액 환급</span>
			        		</div>
			        		<div class="my-2" style="display: flex; justify-content: space-between;">
			        			<span>80% 미만 성공</span><span>예치금 일부 환급 (성공률 만큼)</span>
			        		</div>
			      		</div>
			     		<div class="modal-body">
							<ul style="padding-left: 20px; text-align: left;">
								<li class="my-1">상금은 80% 미만 성공한 참가자들의 벌금으로 마련돼요.</li>
								<li class="my-1">최종 상금은 내가 건 돈에 비례해서 정해져요. 그래서 예치금이 많을수록 상금도 높아져요!</li>
							</ul>
			      		</div>
			      		<div class="modal-footer">
					        <button type="button" class="btn" style="background-color: #EB534C; color: white;" data-dismiss="modal">닫기</button>
			      		</div>
			  	  </div>
			 	</div>
			</div>
			<%-- 모달창 --%>
		</div> 
	</div>  
	
	<div id="challenge_join_body" class="mx-5" style="height: 300px;">
		<div style="width: 100%; height: 100%;">
			<div class="join_body bold px-5" style="height: 25%;"><span>예치금 충전 및 결제</span><div id="point_charge">예치금 충전</div></div>
			<div class="join_body basic px-5" style="height: 17%;"><span>현재 보유 예치금</span><span id="current_deposit"><fmt:formatNumber value="${userDeposit}" pattern="#,###" ></fmt:formatNumber>원</span></div>
			<div class="join_body basic px-5" style="height: 17%;"><span>참가 예치금</span><span id="join_price"></span></div>
			<div class="join_body basic px-5" style="height: 17%;"><span>결제 후 보유 예치금</span><span id="after_deposit"></span></div> 
			<div class="join_body bold px-5" style="height: 25%;"><span>최종 결제 금액</span><span id="join_price"></span></div>
		</div> 
	</div>
	<div style="display: flex; justify-content: center; align-items:center; width: 100%; height: 150px;">
		<div class="mr-3 challenge_join_btn" onclick="javascript:history.back()" style="display: flex; background-color: white !important; color: black;">뒤로가기</div>
		<div id="join_challenge" class="ml-3 challenge_join_btn" style="display: flex;">참가하기</div>
	</div>
</div>
</div>

<form name="challenge_info">
	<input type="hidden" id="userid" name="fk_userid" value="${userid}" readonly="readonly">
	<input type="hidden" id="price" name="entry_fee" value="" readonly="readonly">
	<input type="hidden" id="challenge_code" name="fk_challenge_code" value="${chaDTO.challengeCode}" readonly="readonly">
	<input type="hidden" id="after_deposit" name="after_deposit" value="" readonly="readonly">
</form>