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
	
	td {
		font-size: 15pt;
		height: 84px;
	}
	
	
	div#MFE_row {
		background-color:white; 
		padding: 55px 70px; 
		border-radius:30px;
		max-width: 100%;
	}
	
	div.error_email,
	div.error {
		color: red;
		font-size: 12pt;
	}
	
	.sucess_button_change {
		background-color: #f43630!important;
		color: white!important;
	}
	
	<%-- 이미지 시작 --%>
	img#second_img_button {
		height: 78%;
		width: 100%;
		border: solid 1px gray;
		border-radius: 50%; 
		object-fit: contain;
	}
	
	button#img_button {
		background-color: white;
		padding: 12px;
		border: none;
		margin-left: -13%;
		margin-top: 80%;
		position: absolute;
	}
	<%-- 이미지 끝 --%>
	
	<%-- 비밀번호, 이메일 버튼 시작 --%>
	button#plz_identify {
		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 6px 0;
		text-align: center;
		font-size: 10pt;
		transition: 0.3s;
		border-radius: 10px;
		width: 51%;
	}
	
	button#button_identify {
		background-color: #f43630;
		border: none;
		color: white;
		padding: 6px 0;
		text-align: center;
		font-size: 10pt;
		transition: 0.3s;
		border-radius: 10px;
		width: 23%;
	}
	
	button#email_button {
		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 6px 9px;
		text-align: center;
		font-size: 10pt;
		margin: 4px 27px;
		transition: 0.3s;
		border-radius: 10px;
	}
	<%-- 비밀번호, 이메일 버튼 끝 --%>
	
	button#edit_button {
		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 7px 39px;
		text-align: center;
		font-size: 18pt;
		margin: 4px 27px;
		transition: 0.3s;
		border-radius: 35px;
	}
	
	
</style>

<script type="text/javascript">

	let b_flag_hp2_click = false;  // 전화번호 1
	
	let b_flag_hp3_click = false;  // 전화번호 2

	let b_flag_pwdDuplicate_click = false;  // 패스워드 변경확인 여부
	
	let b_flag_showemailDuplicate_click = false;  // 이메일 중복확인 필요한지 여부
	
	let b_flag_emailDuplicate_click = false;  // 이메일 중복확인 여부
	
	let b_flag_showidfDuplicate_click = false; // 인증하기가 필요한지 여부
	
	let b_flag_idfDuplicate_click = false; // 인증하기 성공 여부
	
	
	$(document).ready(function(){
		
		//$("input#email").val("${requestScope.udto.email}");
		
		$("button#edit_button").prop("disabled", true); // 버튼 비활성화
		
		$("input#pwdcheck").prop("disabled", true); // 비밀번호 체크 숨기기
		
		$("button#email_button").prop("disabled", true); // 이메일 버튼 비활성화
		
		$(".mobile_identify").hide(); // 모바일 인증하기 숨기기
		
		$("button#plz_identify").prop("disabled", true); // 인증하기 비활성화
		
		$("div.error_email").hide(); // 이메일 에러 숨기기
		
		$("div.error").hide();  // 모든 에러 숨기기
		
		let randomStr = ""; // 비번 및 모바일 변경시 인증번호
		
		<%-- 프로필사진 변경 시작 --%>
		$("input#profile_pic_file").change(function(event){
			
			let tmpPath = URL.createObjectURL(event.target.files[0]);  // 실제 경로를 가지고 옴
			$("#profile_pic").val(tmpPath);

			document.getElementById("second_img_button").src = $("#profile_pic").val();
			
			var fileName = $("#profile_pic_file").val().split('/').pop().split('\\').pop();  // fakePath만 지워줌
			
			$("input#profile_pic").val(fileName);
			
			$("button#edit_button").prop("disabled", false);
			$("button#edit_button").addClass("sucess_button_change");
		});
		<%-- 프로필사진 변경 끝 --%>
		
		<%-- 비밀번호 입력 시작 --%>
		$("input#input_pwd").change(function() {
	          
			const regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
	    	  
			const bool = regExp.test($(this).val());
			
			if(!bool) {
	    		// 암호가 정규표현식에 위배 된 경우
	    		$("input#pwdcheck").prop("disabled", true);  // 비밀번호 확인을 끝낸 후 다시 비밀번호를 변경했을때 위배되었다면 비밀번호체크를 막아준다.
	    		
				$("button#edit_button").prop("disabled", true);
				$("button#edit_button").removeClass("sucess_button_change");
				
				b_flag_showidfDuplicate_click = false;
				b_flag_pwdDuplicate_click = false;
				
				$("div#pwd_error").show();
			}
			else {
				// 암호가 정규표현식에 맞는 경우
				$("input#pwdcheck").prop("disabled", false);
				
				// 인증을 한 후 다시 암호를 입력한 경우 인증이 필요하므로 수정하기 버튼을 비활성화 시작
				$("button#edit_button").prop("disabled", true);
				$("button#edit_button").removeClass("sucess_button_change");
				$("input#pwdcheck").val("");
				
				b_flag_showidfDuplicate_click = false;
				b_flag_pwdDuplicate_click = false;
				// 인증을 한 후 다시 암호를 입력한 경우 인증이 필요하므로 수정하기 버튼을 비활성화 끝
				
				$("div#pwd_error").hide();
			} 
			
		});
		<%-- 비밀번호 입력 끝 --%>
		
		<%-- 비밀번호 확인 시작 --%>
		$("input#pwdcheck").change(function() {
			
			if( $("input#input_pwd").val() == $(this).val() ) {
				// 암호가 일치하였을 경우
				$("button#plz_identify").prop("disabled", false);
				$("button#plz_identify").addClass("sucess_button_change");
				
				$("div#pwd_check_error").hide();
				
				b_flag_showidfDuplicate_click = true;
				b_flag_pwdDuplicate_click = true;
				
				$("input#pwd").val($(this).val());
			}
			else {
				// 암호가 일치하지 않을 경우
				$("button#plz_identify").prop("disabled", true);
				$("button#plz_identify").removeClass("sucess_button_change");
				
				$("div#pwd_check_error").show();
				
				$("button#edit_button").prop("disabled", true);
				$("button#edit_button").removeClass("sucess_button_change");
				
				b_flag_showidfDuplicate_click = false;
				b_flag_pwdDuplicate_click = false;
				
			}
			
		});
		<%-- 비밀번호 확인 끝 --%>    
		
		<%-- 전화번호 2번째 시작 --%>
		$("input#hp2").change(function() {
	            
			const regExp = /^[1-9][0-9]{2,4}$/g;
       	  
			const bool = regExp.test($(this).val());
       	  
			// 인증 후 다시 전화번호를 바꿀 경우 시작
			b_flag_showidfDuplicate_click = false;
			b_flag_hp2_click = false;
			
			$(".mobile_identify").hide(); // 인증하기 버튼 다시 숨기기
			
			$("button#edit_button").prop("disabled", true);
			$("button#edit_button").removeClass("sucess_button_change");
			// 인증 후 다시 전화번호를 바꿀 경우 끝
			
			if(!bool) {
				// 국번이 정규표현식에 위배 된 경우
				$("div#error").hide();
				
				$("button#plz_identify").prop("disabled", true);
				$("button#plz_identify").removeClass("sucess_button_change");
				
				$("button#edit_button").prop("disabled", true);
				$("button#edit_button").removeClass("sucess_button_change");
			
				$("div#mobile_error").show();
				
				b_flag_showidfDuplicate_click = false;
				b_flag_hp2_click = false;
			}
			else {
				// 국번이 정규표현식에 맞는 경우
				$("button#plz_identify").prop("disabled", false);
				
				$("button#plz_identify").prop("disabled", false);
				$("button#plz_identify").addClass("sucess_button_change");
				
				b_flag_showidfDuplicate_click = true;
				b_flag_hp2_click = true;
				
				$("input#mobile").val("010"+$("input#hp2").val()+$("input#hp3").val());
			
				$("div#mobile_error").hide();
				
			} 
		});
		<%-- 전화번호 2번째 끝 --%> 
          
		
		<%-- 전화번호 3번째 시작 --%>
		$("input#hp3").change(function() {
            
			const regExp = /^[1-9][0-9]{2,3}$/g;
       	  
			const bool = regExp.test($(this).val());
       	  
			// 인증 후 다시 전화번호를 바꿀 경우 시작
			b_flag_showidfDuplicate_click = false;
			b_flag_hp3_click = false;
			
			$(".mobile_identify").hide(); // 인증하기 버튼 다시 숨기기
			
			$("button#edit_button").prop("disabled", true);
			$("button#edit_button").removeClass("sucess_button_change");
			// 인증 후 다시 전화번호를 바꿀 경우 끝
			
			if(!bool) {
				// 마지막4자리번호가 정규표현식에 위배된 경우
				$("div#error").hide();
				$("button#plz_identify").prop("disabled", true);
				$("button#plz_identify").removeClass("sucess_button_change");
				
				$("button#edit_button").prop("disabled", true);
				$("button#edit_button").removeClass("sucess_button_change");
			
				$("div#mobile_error").show();
				
				b_flag_showidfDuplicate_click = false;
				b_flag_hp3_click = false;
			}
			
			else {
				// 마지막4자리번호가 정규표현식에 맞는 경우
				$("button#plz_identify").prop("disabled", false);
				$("button#plz_identify").addClass("sucess_button_change");
				
				b_flag_showidfDuplicate_click = true;
				b_flag_hp3_click = true;
				
				$("input#mobile").val("010"+$("input#hp2").val()+$("input#hp3").val());
			
				$("div#mobile_error").hide();
			
			}
		});
       <%-- 전화번호 3번째 끝 --%>
		
       
		<%-- 이메일 입력 시작 --%> 
		$("input#email").change(function() {
        	 
			const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
        	 
			const bool = regExp.test($(this).val());
			
        	// 인증 후 다시 이메일을 바꿀 경우 시작
			b_flag_emailDuplicate_click = false;
			
			$("button#edit_button").prop("disabled", true);
			$("button#edit_button").removeClass("sucess_button_change");
			
			$("button#email_button").prop("disabled", true);
			$("button#email_button").removeClass("sucess_button_change");
			// 인증 후 다시 이메일을 바꿀 경우 끝
			
			if(!bool) {
				// 이메일이 정규표현식에 위배 된 경우
				$("div.error_email").hide();
				
				$("div#email_error").show();
				
 				$("button#edit_button").prop("disabled", true);
 				$("button#edit_button").removeClass("sucess_button_change");
 				
 				$("button#email_button").prop("disabled", true);
 				$("button#email_button").removeClass("sucess_button_change");
 				
 				b_flag_emailDuplicate_click = false;
			}
			
			else if ($(this).val() == "${requestScope.udto.email}") {
				// 다른 이메일을 적은 후 다시 똑같은 이메일을 적었을 경우
				$("div.email_error").hide();
				
				$("div#email_nochange_error").show();
				
				b_flag_emailDuplicate_click = false;
			}
			
			else {
        		// 정규표현식에 위배되지 않았을 경우 이메일 버튼과 수정 버튼을 활성화시켜준다.
				$("div.email_error").hide();
        		
				//$("button#edit_button").prop("disabled", false);
				$("button#email_button").prop("disabled", false);
				
				//$("button#edit_button").addClass("sucess_button_change");
				$("button#email_button").addClass("sucess_button_change");
				
				
				
			}
		});
		<%-- 이메일 입력 끝 --%>
		 
       
       <%-- 계좌번호 시작 --%>
       $("input#acct").change(function(){
    	  
    	   const regExp = /^[0-9]+$/;
    	   
    	   const bool = regExp.test($(this).val());
    	   
    	   if(!bool) {
				$("button#edit_button").prop("disabled", true);
				$("button#edit_button").removeClass("sucess_button_change");
			
				$("div#account_number_error").show();
    	   }
    	   else {
				$("div#account_number_error").hide();
    		   
				$("button#edit_button").prop("disabled", false);
				$("button#edit_button").addClass("sucess_button_change");
    	   }
    	    
       });
       
	}); // end of document.ready -----
	
	
	<%-- 이메일 중복확인버튼 누르기 시작 --%> 
	function email_check(){
		
		b_flag_emailDuplicate_click = true;
		
		$("button#edit_button").prop("disabled", false);
		$("button#edit_button").addClass("sucess_button_change");
		
		$.ajax ({
			url:"/mypage/email_change_ajax",
			type:"GET",
			dataType:"json",
			data:{
				"change_email":$("input#email").val()
			},
			success:function(json){
				
				// console.log("~~~~ 확인용 : " + JSON.stringify(json));
				
				if ( json.n == 0) {
					$("div.email_error").hide();
					$("div#email_success").show();
				}
				else {
					$("div.email_error").hide();
					$("div#email_fail").show();
					
					b_flag_emailDuplicate_click = false;
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }	
		});
		
	};
	<%-- 이메일 중복확인버튼 누르기 끝 --%> 
	
	<%-- 인증하기 버튼 보이기 및 인증번호 보내기 시작 --%> 
	function show_identify(){
		
		if(b_flag_pwdDuplicate_click || b_flag_hp2_click || b_flag_hp3_click) {
			// 비밀번호 변경, 휴대폰 번호 변경을 할 경우 인증번호를 입력하도록 한다.
			
			randomStr = Math.random().toString(36).substring(2, 12);
			console.log(randomStr);
			
			$(".mobile_identify").show(); // 인증하기 버튼 보이기
			
			// 인증번호 보내기 메소드
			/*
			$.ajax({
				url:"/mypage/sms_ajax",
				type:"post",
				data:{
					"mobile":"${requestScope.udto.mobile}",
					"smsContent":"[해볼랑스] 인증번호는 " + randomStr + "입니다."
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
		} 
		
	};
	<%-- 인증하기 버튼 보이기 및 인증번호 보내기 끝 --%> 
	
	<%-- 입력한 인증번호가 맞는지 아닌지 확인하기 시작 --%>
	function go_identify() {
		
		if( $("input#input_identify").val() != randomStr ) {
			$("div.error").hide();
			$("div#identify_error").show();
			
			$("button#edit_button").prop("disabled", true);
			$("button#edit_button").removeClass("sucess_button_change");
		}
		else {
			$("div.error").hide();
			$("div#identify_success").show();
			b_flag_idfDuplicate_click = true;
			
			$("button#edit_button").prop("disabled", false);
			$("button#edit_button").addClass("sucess_button_change");
		}
		
	}
	<%-- 입력한 인증번호가 맞는지 아닌지 확인하기 끝 --%>
	
	<%-- 수정하기 버튼 누르기 시작 --%>
	function go_edit() {
		// 수정하기 버튼을 눌렀을 경우
		if(b_flag_showemailDuplicate_click && !b_flag_emailDuplicate_click) {
			// 이메일 중복 버튼을 눌러야하나 누르지 않았을 경우
			$("div.email_error").hide();
			
			$("div#email_check_error").show();
			
			$("button#edit_button").prop("disabled", true);
			$("button#edit_button").removeClass("sucess_button_change");
			
		}
		else if(b_flag_showidfDuplicate_click && !b_flag_idfDuplicate_click) {
			// 인증하기가 필요하나 인증을 하지 않은 경우
			$("div.error").hide();
			
			$("div#plz_identify_error").show();
			
			$("button#edit_button").prop("disabled", true);
			$("button#edit_button").removeClass("sucess_button_change");
			
		}
		else {
			
			edit();
		}
		
	};
	<%-- 수정하기 버튼 누르기 끝 --%>
	
	<%-- 정보수정하기 시작 --%>
	function edit() {
	
		let formData = new FormData(document.getElementById("editFrm"));
		
		$.ajax ({
			url : "/mypage/mypage_info_edit_ajax",
            type : "post",
            data : formData,
            processData:false,  // 파일 전송시 설정 
            contentType:false,  // 파일 전송시 설정 
            dataType:"json",
            success:function(json){
               // console.log("~~~ 확인용 : " + JSON.stringify(json));
                
                if(json.n == 1) {
                	alert("정보수정에 성공했습니다.");
                	location.href = "mypageHome";
                }
                else {
                   alert("정보수정에 실패했습니다.\n고객센터에 문의바랍니다.");
                }
            },
            error: function(request, status, error){
            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); 
		
	}
	<%-- 정보수정하기 끝 --%>
	
</script>

	<div id="mainPosition">
		<!-- index 상단 제목 시작 -->
 		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h3 mb-0 text-gray-800">내정보 수정하기</h1>
		</div>
		<!-- index 상단 제목 끝 -->
		
		<!-- index 메인 시작 -->
		
		<div class="row" id="MFE_row">
		
			<div class="col-lg-4 offset-lg-1" style="padding-top:82px;">
				
				<img id="second_img_button" alt="프로필이미지" onclick="document.all.profile_pic_file.click();" src="<%= ctxPath%>/images/${requestScope.udto.profile_pic}" />
				
				<button type="button" id="img_button" onclick="document.all.profile_pic_file.click();">
					<i class="fas fa-camera fa-lg" style="font-size:21pt;"></i>
				</button>
			</div>
		
			<form name="editFrm" id="editFrm" class="offset-lg-1 col-lg-6" method="post" enctype="multipart/form-data" style="max-width:100%;">
				<input type="file" id="profile_pic_file" name="profile_pic_file" accept=".gif, .jpg, .png" style="display:none;" />
				<input type="hidden" name="profile_pic" id="profile_pic" value="${requestScope.udto.profile_pic}" />
			      
			      <input type="hidden" name="userid" id="userid" value="${requestScope.udto.userid}" />
			      
			      <table id="tblMemberUpdate">
			         
			         <tr>
			            <td style="width: 26%; font-weight: bold;">비밀번호&nbsp;</td>
			            <td style="width: 74%; text-align: left;">
			            	<input type="password" id="input_pwd" class="requiredInfo" />
			               <div id="pwd_error" class="error">암호는 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.</div>
			            </td>
			         </tr>
			         
			         <tr>
			            <td style="width: 26%; font-weight: bold;">비밀번호확인&nbsp;</td>
			            <td style="width: 74%; text-align: left;">
			            	<input type="password" id="pwdcheck" class="requiredInfo" /> 
			            	<input type="hidden" name="pw" id="pw" value="${requestScope.udto.pw}" />
			               <div id="pwd_check_error" class="error">암호가 일치하지 않습니다.</div>
			            </td>
			         </tr>
			         
			         <tr>
			            <td style="width: 26%; font-weight: bold;">연락처</td>
			            <td style="width: 74%; text-align: left;">
			                <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly="readonly" />&nbsp;-&nbsp;
			                <input type="text" id="hp2" name="hp2" size="6" maxlength="4" value="${requestScope.hp1}" />&nbsp;-&nbsp;
			                <input type="text" id="hp3" name="hp3" size="6" maxlength="4" value="${requestScope.hp2}" />
			                <input type="hidden" id="mobile" name="mobile" value="010${requestScope.hp1}${requestScope.hp2}" />
			                
			                <div id="mobile_error" class="error">휴대폰 형식이 아닙니다.</div>
			                <div id="mobile_nochange_error" class="error">동일한 휴대폰 번호를 적었습니다.</div>
			            </td>
			         </tr>
			         
			         <tr>
			         	<td style="height: 0;">
				        	<button type="button" id="plz_identify" onclick="show_identify();">인증번호요청하기</button>
				        </td>
				        <td>
			                <input type="text" id="input_identify" class="mobile_identify" style="margin-right:7%;" />
			                <button type="button" id="button_identify" class="mobile_identify" onclick="go_identify();">인증하기</button>
			                <div id="identify_success" class="error" style="color:blue;">인증을 성공하였습니다.</div>
			                <div id="identify_error" class="error">인증번호가 틀렸습니다.</div>
			                <div id="plz_identify_error" class="error">인증번호를 입력해주시기 바랍니다.</div>
			        	</td>
			         </tr>
			         
			         <tr>
			            <td style="width: 26%; font-weight: bold;">이메일&nbsp;</td>
			            <td style="width: 74%; text-align: left;">
			            	<input type="text" name="email" id="email" value="${requestScope.udto.email}" class="requiredInfo" /> 
			                <button type="button" id="email_button" onClick="email_check();">이메일 중복 확인</button> 
			                <div id="email_success" class="error_email" style="color:blue;">사용이 가능한 이메일입니다.</div>
			                <div id="email_fail" class="error_email">중복된 이메일입니다.</div>
			                <div id="email_error" class="error_email">이메일 형식에 맞지 않습니다.</div>
			                <div id="email_check_error" class="error_email">이메일 중복 확인을 해주세요.</div>
			                <div id="email_nochange_error" class="error_email">동일한 이메일을 작성하였습니다.</div>
			            </td>
			         </tr>
			         
			         
			         
			          <tr>
			            <td style="width: 26%; font-weight: bold;">계좌번호&nbsp;</td>
			            <td style="width: 74%; text-align: left;">
			            	<input type="text" name="acct" id="acct" value="${requestScope.udto.acct}" class="requiredInfo" /> 
			               <div id="account_number_error" class="error">올바른 계좌번호를 입력해주세요</div>
			            </td>
			         </tr>
			         
			         <tr>
			            <td colspan="2" class="text-center">
			                      
			              <button type="button" id="edit_button" onclick="go_edit();">수  정</button> 
			            </td>
			         </tr>
			         
			      </table>
				</form>
           </div>
           

		</div>
		<!-- 메인 끝 -->


</body>
</html> 
