<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<link href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>

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
		width: 120px;
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
		
		}); // end $("p.price_choice").bind("click")
		
		$("p#price_10000").trigger("click"); // 초기화면용
		
		
		// 금액 키보드로 입력시 함수
		$("input#price").on("keyup", function(e){
			
			const price = Number($(this).val());
			
			if ( price < 0) {
				$(this).val("10000");
			}
			else if ( price > 200000) { 
				$(this).val("200000");
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
			
			
		}); // end $("input#price").on("keyup")
		
		
		// 예치금을 10000 이하로 설정했을시
		$("input#price").bind("change", function() {
			
			const price = Number($(this).val());
			
			if ( 0 < price && price < 10000) {
				swal.fire("최소 예치금액은 1만원입니다.");
				$("p#price_10000").trigger("click");
				$(this).focus();
			}

		});
		
		
		// 참가하기 클릭시
		$("div#join_challenge").click(function(){
			
			// 팝업창 띄우기
			const url = "<%= request.getContextPath()%>/challenge/joinEnd";
			
			// 너비 800, 높이 600인 팝업창을 화면 가운데 위치시키기
			const pop_width = 600;
			const pop_height = 400;
			const pop_left = Math.ceil((window.screen.width - pop_width)/2); <%-- 정수로 만듬 --%>
			const pop_top = Math.ceil((window.screen.height - pop_height)/2);
			
			window.open(url, "challengejoin", "left="+pop_left+", top="+pop_top+", width="+pop_width+", height="+pop_height);
			
			location.href="<%= request.getContextPath()%>/challenge/testmenu";
			
			/* $("button#btn_close").click(function(){
				alert("join에서 닫기")
				self.close();
				window.close();
			}); */
		});
		
		
		
	}); // end $(document).ready

</script>
<div class="container" style="background-color: white; width: 70% !important; padding: 0;"> 
	
	<div id="challenge_join_header" class="mx-5" style="height: 300px;">
		<div class="join_body" style="display: flex; justify-content: center; align-items:center; width: 100%; height: 100%; border: solid 1px red;">
			챌린지 내용
		</div>
	</div>

	<div id="challenge_join_price" class="mx-5" style="height: 300px;"> 
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
				<p class="price_choice"><span class="price_list">200000</span>원</p>
			</div> 
		</div> 
		<div id="explain_price" class="join_body">최소 1만원 ~ 최대 20만원 (1만원 단위 가능)</div>
	</div> 
	 
	<div id="challenge_join_guide" class="px-5" style="height: 300px; background-color: #F5F5F5;">
		<div class="join_body basic px-5" style="height: 20%;"><span>100% 성공</span><span id="success_price"></span></div>
		<div class="join_body basic px-5" style="height: 20%;"><span>85% 이상 성공</span><span id="join_price"></span></div>
		<div class="join_body basic px-5" style="height: 20%;"><span>85% 미만 성공</span><span>예치금 일부 환급 (성공률 만큼)</span></div>
		<div class="join_body" style="height: 40%; align-items: center; justify-content:center; ">
			<div id="challenge_info" data-toggle="modal" data-target="#challenge_info_Modal">챌린지 환급 안내</div>
			<%-- 모달창 --%>
			<div class="modal fade" id="challenge_info_Modal">
				<div class="modal-dialog"> 
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
			        			<span>85% 이상 성공</span><span>예치금 전액 환급</span>
			        		</div>
			        		<div class="my-2" style="display: flex; justify-content: space-between;">
			        			<span>85% 미만 성공</span><span>예치금 일부 환급 (성공률 만큼)</span>
			        		</div>
			      		</div>
			     		<div class="modal-body">
							<ul style="padding-left: 20px;">
								<li class="my-1">상금은 85% 미만 성공한 참가자들의 벌금으로 마련돼요.</li>
								<li class="my-1">최종 상금은 내가 건 돈에 비례해서 정해져요. 그래서 예치금이 많을수록 상금도 높아져요!</li>
								<li class="my-1">인증을 놓쳤을 때는 인증패스를 사용해서 만회할 수 있어요. 단, 인증패스를 사용해서 100% 성공한 경우 공정성을 위해 상금은 받을 수 없어요.</li>
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
			<div class="join_body basic px-5" style="height: 17%;"><span>현재 보유 예치금</span><span>100,000 원</span></div>
			<div class="join_body basic px-5" style="height: 17%;"><span>참가 예치금</span><span id="join_price"></span></div>
			<div class="join_body basic px-5" style="height: 17%;"><span>결제 후 보유 예치금</span><span>90,000원</span></div> 
			<div class="join_body bold px-5" style="height: 25%;"><span>최종 결제 금액</span><span id="join_price"></span></div>
		</div> 
	</div>
	<div style="display: flex; justify-content: center; align-items:center; width: 100%; height: 150px;">
		<div class="mr-3 challenge_join_btn" onclick="javascript:history.back()" style="display: flex; background-color: white !important; color: black;">뒤로가기</div>
		<div id="join_challenge" class="ml-3 challenge_join_btn" style="display: flex;">참가하기</div>
	</div>
</div>