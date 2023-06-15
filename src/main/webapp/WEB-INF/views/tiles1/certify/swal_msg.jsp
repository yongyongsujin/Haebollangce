<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.6/dist/sweetalert2.all.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.6/dist/sweetalert2.min.css" rel="stylesheet">
<script type="text/javascript" src="/js/jquery-3.6.4.min.js"></script>

<script type="text/javascript">

	// 메시지 출력해주기
	// let message = "${requestScope.message}";
	$(document).ready(function(){
		Swal.fire({
			icon: "${requestScope.icon}",
			title: "${requestScope.message}",
			confirmButtonColor: "#EB534C",
			confirmButtonText: "확인"
		}).then(function(){
			// 페이지 이동
			location.href = "${requestScope.loc}";
		});
	});
	
</script>