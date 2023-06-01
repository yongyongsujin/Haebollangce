<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
%>

<style>
	body {
		font-family: "Lato", sans-serif;
		background-color:#f4f4f4
	}

	a#mypage {
		padding: 36px 8px 73px 16px;
		text-decoration: none;
		font-size: 23px;
		color: white;
		display: block;
		border: none;
		background: none;
		width: 100%;
		text-align: left;
		outline: none;
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
		<a id="mypage" href="<%=ctxPath%>/mypage/mypageHome">마이페이지</a>
		
		<button class="dropdown-btn">챌린지 현황 
			<i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
			<a href="<%=ctxPath%>/mypage/mypageChallenging" style="color:black;">진행중</a>
			<a href="<%=ctxPath%>/mypage/mypageFinish" style="color:black;">완료</a>
			<a href="<%=ctxPath%>/mypage/mypageCreate" style="color:black;">개설한 챌린지</a>
		</div>
		
		<button class="dropdown-btn">결제
			<i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
			<a href="<%=ctxPath%>/mypage/depositPurchase" style="color:black;">예치금 충전</a>
			<a href="<%=ctxPath%>/mypage/change_reward" style="color:black;">상금 전환</a>
		</div>
		
		<a href="<%=ctxPath%>/mypage/mypageDepositUsing">결재 현황</a>
		
		<button class="dropdown-btn">찜현황
			<i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
			<a href="#" style="color:black;">찜한 챌린지</a>
			<a href="#" style="color:black;">찜한 라운지글</a>
		</div>
		
		<button class="dropdown-btn">개인정보 수정 
		    <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
			<a href="<%=ctxPath%>/mypage/mypagePwdIdentify" style="color:black;">회원정보 수정</a>
			<a href="<%=ctxPath%>/mypage/mypagePwdIdentify" style="color:black;">회원탈퇴</a>
		</div>
	</div>
	<!-- 마이페이지 메뉴바 끝 -->
	
