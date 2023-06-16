<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
%>

<style>
	body {
		background-color:#f4f4f4
	}

	a#mypage {
		padding: 26% 20% 24% 4%;
		text-decoration: none;
		font-size: 23px;
		color: white;
		display: block;
		width: 100%;
		text-align: left;
		font-weight: bold;
	}

	.sidenav {
		height: 100%;
		/* width: 255px; */
		width: 15%;
		position: fixed;
		z-index: 1;
		top: 0;
		left: 0;
		background-color: #f43630;
		overflow-x: hidden;
		padding-top: 20px;
	}

	.sidenav a, .dropdown-btn {
		padding: 23px 8px 23px 16px;
		text-decoration: none;
		font-size: 18px;
		color: white;
		display: block;
		border: none;
		background: none;
		width: 100%;
		text-align: left;
		cursor: pointer;
		outline: none;
		font-weight: bold;
	}

	.sidenav a:hover, .dropdown-btn:hover {
		color: #f1f1f1;
		font-size: 20px;
	}
	
	.active_sidebar {
		background-color: #ff8080;
		color: white;
	}

	.dropdown-container {
		display: none;
		background-color: white;
		padding-left: 8px;
	}
	
	.fa-caret-down {
		float: right;
		padding-right: 8px;
	}
	
	button.submit_button {
		border: none;
		background-color: white;
		padding: 23px 8px 23px 16px;
		text-decoration: none;
		font-size: 18px;
		display: block;
		width: 100%;
		text-align: left;
		cursor: pointer;
		outline: none;
		font-weight: bold;
	}
	
	button#mypage {
		font-size: 31px;
		color: white;
		display: block;
		width: 100%;
		font-weight: bold;
		background: none;
		margin: 25% 0;
		border: none;
		text-align: left;
	}

</style>

<script>

	$(document).ready(function(){
		var dropdown = document.getElementsByClassName("dropdown-btn");
		var i;
		
		for (i = 0; i < dropdown.length; i++) {
		  dropdown[i].addEventListener("click", function() {
		    this.classList.toggle("active_sidebar");
		    var dropdownContent = this.nextElementSibling;
		    if (dropdownContent.style.display === "block") {
		      dropdownContent.style.display = "none";
		      dropdownContent.slideDown(1000);
		    } else {
		      dropdownContent.style.display = "block";
		      
		    }
		  });
		}
		
	});

</script>

</head>
<body>
<!-- 마이페이지 메뉴바 시작 -->
	<div class="sidenav">
		<form action="mypageHome" method="post">
			<input type="hidden" name="userid" value="${requestScope.udto.userid}" /> 
			<button type="submit" id="mypage">마이페이지</button>
		</form>
		<%-- 
		<a id="mypage" href="<%=ctxPath%>/mypage/mypageHome?userid=${requestScope.udto.userid}">마이페이지</a>
		 --%>
		<a href="<%=ctxPath%>/mypage/mypageChallenging">챌린지 현황</a>
		
		<button class="dropdown-btn">결제·환전
			<i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
			<a href="<%=ctxPath%>/mypage/depositPurchase" style="color:black;">예치금 충전</a>
			<a href="<%=ctxPath%>/mypage/change_reward" style="color:black;">상금 환전</a>
		</div>
		
		<a href="<%=ctxPath%>/mypage/mypageUsing">결재·상금 현황</a>
		
		<button class="dropdown-btn">찜현황
			<i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
			<a href="<%=ctxPath%>/mypage/mypageChallengeLike" style="color:black;">찜한 챌린지</a>
			<a href="<%=ctxPath%>/mypage/mypageLoungeLike" style="color:black;">찜한 라운지글</a>
		</div>
		
		<button class="dropdown-btn">개인정보 수정 
		    <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
			<form action="mypagePwdIdentify" method="post">
				<button type="submit" name="result" value="0"  class="submit_button">회원정보수정</button>
				
				<button type="submit" class="submit_button">회원탈퇴하기</button>
			</form>
		</div>
	</div>
	<!-- 마이페이지 메뉴바 끝 -->
	
