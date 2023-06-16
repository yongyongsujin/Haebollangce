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
		height: 103px;
	}
	
	.font_weight {
		font-weight: bold;
	}
	
	div#MFE_row {
		background-color:white; 
		padding: 33px 5%; 
		border-radius: 30px 30px 0 0;
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
	
	/* 이미지 시작 */
	img#second_img_button {
		height: 61%;
		width: 94%;
		border: solid 1px gray;
		border-radius: 50%; 
		object-fit: cover;
		margin-left: 23%;
	}
	
	button#img_button {
		background-color: white;
		padding: 15px;
		border: none;
		margin-left: 97%;
		margin-top: -9%;
		position: absolute;
	}
	/* 이미지 끝 */
	
	div#interset {
		border: solid 1px black;
		height: 88px;
		margin: 11px 0;
		width: 131%;
		padding: 2% 0;
	}
	
	/* 비밀번호, 이메일 버튼 시작 */
	button#plz_identify {
		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 10px 0;
		text-align: center;
		font-size: 12pt;
		transition: 0.3s;
		border-radius: 41px;
		width: 141px;
		margin-left: 6%;
		font-weight: bold;
	}
	button#plz_identify:hover,
	button#button_identify:hover {
		background-color: #f43630;
		color: white;
	}
	
	div#timer {
		font-size: 13pt;
		color: red;
	}
	
	button#button_identify {
		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 10px 0;
		text-align: center;
		font-size: 12pt;
		font-weight: bold;
		transition: 0.3s;
		border-radius: 41px;
		width: 70%;
	}
	
	button#email_button {
		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 6px 9px;
		text-align: center;
		font-size: 12pt;
		margin: 4px 27px;
		transition: 0.3s;
		border-radius: 10px;
	}
	/* 비밀번호, 이메일 버튼 끝 */
	
	button#edit_button {
 		background-color: #e6e1e1;
		border: none;
		color: black;
		padding: 16px 0;
		text-align: center;
		font-size: 24pt;
		transition: 0.3s;
		width: 90%;
		margin-left: 4%;
		height: 79px;
	}
	
	div#interest_margin {
		margin-top: 35px;
		margin-bottom: 12px;
	}
	
	div#all_interest {
		width: 131%;
	}
	
	span#interest_title {
		font-size: 15pt;
		font-weight: bold;
		margin-right: 5%;
	}
	
	div.user_interest {
		display: inline-block;
		margin: 0 1%;
		padding: 1%;
		font-weight: bold;
		border-radius: 25%;
	}
	
	.pink_tag {
		background-color: #ffe6ff;
		border: black;
	}
	
	.blue_tag {
		background-color: #e6f2ff;
		border: #e6f2ff;
	}
	
	.red_tag {
		background-color: #ffe6e6;
		border: #e6f2ff;
	}
	
	.green_tag {
		background-color: #e6fff2;
		border: #e6f2ff;
	}
	
	.orange_tag {
		background-color: #fff2e6;
		border: #e6f2ff;
	}
	 
    .brown_tag {
    	background-color: #f7ffe6;
		border: #f7ffe6;
    }
    
    .yellow_tag {
    	background-color: #ffffe6;
		border: #ffffe6;
    }
    
    .khaki_tag {
    	background-color: #f6f6ee;
		border: #f6f6ee;
    }
    
	.balloon {
        position: relative;
        display: inline-block;
    }
   
    
    span#interest_add {
    	display: none;
    	position: absolute;
    	z-index: 99;
    }
    
    span#interest_del {
    	display: none;
    	position: absolute;
    	z-index: 99;
    }
    
    td#identify_td {
    	height: 68px;
    	font-size: 15pt;
    	width: 40%;
    }
    
    div.identify_div_position {
    	padding: 0 30%;
    }
    
    td.identify_table_style {
    	width: 30%
    }
    
    td.text_align_right {
    	text-align: right;
    }
 
	/* 툴팁 시작 */
    .balloon,
    .balloon_span {
        padding: 5px 9px;
        color: white;
        background: #555;
        border-radius: 20px;
        font-size: 13pt;
    }


    .balloon:after {
        content: '';
        position: absolute;
        width: 0;
        height: 0;
        border-style: solid;
    }
    
   .balloon.left:after {
        border-width: 10px 15px;
        top: 50%;
        margin-top: -10px;
    }
    
    .balloon.left:after {
        border-color: transparent #555 transparent transparent;
        left: -25px;
    }
	/* 툴팁 끝 */
	
	/* The Modal (background) */
	.modal {
	  display: none; /* Hidden by default */
	  position: fixed; /* Stay in place */
	  z-index: 1; /* Sit on top */
	  padding-top: 100px; /* Location of the box */
	  left: 0;
	  top: 0;
	  width: 100%; /* Full width */
	  height: 100%; /* Full height */
	  overflow: auto; /* Enable scroll if needed */
	  background-color: rgb(0,0,0); /* Fallback color */
	  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
	}
	
	/* Modal Content */
	.modal-content {
	  background-color: #fefefe;
	  margin: 14% 38%;
	  padding: 55px;
	  border: 1px solid #888;
	  width: 37%;
	}
	
	/* The Close Button */
	.close {
	  color: #aaaaaa;
	  float: right;
	  font-size: 28px;
	  font-weight: bold;
	}
	
	.close:hover,
	.close:focus {
	  color: #000;
	  text-decoration: none;
	  cursor: pointer;
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
		
		const backURL = sessionStorage.getItem("URL")
	    if ( backURL != null ){
			location.href = backURL;
			sessionStorage.removeItem("URL");
	    }
		
		//$("input#email").val("${requestScope.udto.email}");
		
		$("button#edit_button").prop("disabled", true); // 버튼 비활성화
		
		$("input#pwdcheck").prop("disabled", true); // 비밀번호 체크 숨기기
		
		$("button#email_button").prop("disabled", true); // 이메일 버튼 비활성화
		
		$(".mobile_identify").hide(); // 모바일 인증하기 숨기기
		
		$("button#plz_identify").prop("disabled", true); // 인증하기 비활성화
		
		$("div.error_email").hide(); // 이메일 에러 숨기기
		
		$("div.error").hide();  // 모든 에러 숨기기
		
		
		let randomStr = ""; // 비번 및 모바일 변경시 인증번호
		
		<%-- 관심태그 시작 --%>
		all_interest();
		<%-- 관심태그 끝 --%>
		
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
				
				$("div#pwd_check_error").hide();
				
				b_flag_showidfDuplicate_click = true;
				b_flag_pwdDuplicate_click = true;
				
				$("button#edit_button").prop("disabled", false);
				$("button#edit_button").addClass("sucess_button_change");
				
				$("input#pw").val($(this).val());
			}
			else {
				// 암호가 일치하지 않을 경우
				$("button#plz_identify").prop("disabled", true);
				
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
				
				$("button#edit_button").prop("disabled", true);
				$("button#edit_button").removeClass("sucess_button_change");
			
				$("div#mobile_error").show();
				
				b_flag_showidfDuplicate_click = false;
				b_flag_hp2_click = false;
			}
			else {
				// 국번이 정규표현식에 맞는 경우
				$("button#plz_identify").prop("disabled", false);
				
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
				
				$("button#edit_button").prop("disabled", true);
				$("button#edit_button").removeClass("sucess_button_change");
			
				$("div#mobile_error").show();
				
				b_flag_showidfDuplicate_click = false;
				b_flag_hp3_click = false;
			}
			
			else {
				// 마지막4자리번호가 정규표현식에 맞는 경우
				$("button#plz_identify").prop("disabled", false);
				
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
        		
        		$("table#email_identify_table").show();
        		
				$("button#email_button").prop("disabled", false);
				
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
       <%-- 계좌번호 끝 --%>
       
       
	}); // end of document.ready -----

	<%-- 프로필 사진 변경 시작 --%>
	function img_change(input){
		
		if(input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById("second_img_button").src = e.target.result;
			};
			reader.readAsDataURL(input.files[0]);
			
			var fileName = $("input#profile_pic_file").val().split('/').pop().split('\\').pop();  // fakePath만 지워줌
			
			document.getElementById('second_img_button').src.substring(0, 22)+fileName
			
			$("#profilePic").val(fileName);
			
			$("#test").val($("input#profile_pic_file").val());
			
			$("button#edit_button").prop("disabled", false);
			$("button#edit_button").addClass("sucess_button_change");
		}
		else {
			document.getElementById("second_img_button").src = "";
		}
		
	}
	<%-- 프로필 사진 변경 끝 --%>
	 
	<%-- 모든 관심코드 불러오기 시작 --%>
	function all_interest() {
		 $.ajax ({
			url: "/mypage/all_interest_ajax",
			type: "get",
			data: {
				"userid":"${requestScope.udto.userid}"
			},
			dataType: "json",
			success:function(json){
				// console.log(JSON.stringify(json));
				
				let html = "";
				
				let all_interest_list = json.all_interest_list;
				let interest_list = json.interest_list;
				
				if(all_interest_list.length > 0) {
					
					for(var i=0; i<all_interest_list.length; i++) {
						
						if(all_interest_list[i].category_code == 1) {
							html += "<div class='user_interest pink_tag' onclick='plus_interest(" + all_interest_list[i].category_code + ");'>" + all_interest_list[i].category_name + "</div>";
						}
						
						else if(all_interest_list[i].category_code == 2) {
							html += "<div class='user_interest blue_tag' onclick='plus_interest(" + all_interest_list[i].category_code + ");'>" + all_interest_list[i].category_name + "</div>";
						}
						
						else if(all_interest_list[i].category_code == 3) {
							html += "<div class='user_interest green_tag' onclick='plus_interest(" + all_interest_list[i].category_code + ");'>" + all_interest_list[i].category_name + "</div>";
						}
						
						else if(all_interest_list[i].category_code == 4) {
							html += "<div class='user_interest red_tag' onclick='plus_interest(" + all_interest_list[i].category_code + ");'>" + all_interest_list[i].category_name + "</div>";
						}
						
						else if(all_interest_list[i].category_code == 5) {
							html += "<div class='user_interest orange_tag' onclick='plus_interest(" + all_interest_list[i].category_code + ");'>" + all_interest_list[i].category_name + "</div>";
						}
						
						else if(all_interest_list[i].category_code == 6) {
							html += "<div class='user_interest brown_tag' onclick='plus_interest(" + all_interest_list[i].category_code + ");'>" + all_interest_list[i].category_name + "</div>";
						}
						
						else if(all_interest_list[i].category_code == 7) {
							html += "<div class='user_interest yellow_tag' onclick='plus_interest(" + all_interest_list[i].category_code + ");'>" + all_interest_list[i].category_name + "</div>";
						}
						
						else {
							html += "<div class='user_interest khaki_tag' onclick='plus_interest(" + all_interest_list[i].category_code + ");'>" + all_interest_list[i].category_name + "</div>";
						}
						
					}
					
				} // end of if(json.length > 0) {} -----
				
				else {
					html += "등록된 관심태그가 없습니다."
				}
				
				$("div#all_interest").html(html); 
				
				html = "";
				
				if(interest_list.length > 0) {
					
					for(var i=0; i<interest_list.length; i++) {
						
						if(interest_list[i].fk_category_code == 1) {
							html += "<div class='user_interest pink_tag' onclick='del_interest(" + interest_list[i].fk_category_code + ");'>" + interest_list[i].category_name + "</div>";
						}
						
						else if(interest_list[i].fk_category_code == 2) {
							html += "<div class='user_interest blue_tag' onclick='del_interest(" + interest_list[i].fk_category_code + ");'>" + interest_list[i].category_name + "</div>";
						}
						
						else if(interest_list[i].fk_category_code == 3) {
							html += "<div class='user_interest green_tag' onclick='del_interest(" + interest_list[i].fk_category_code + ");'>" + interest_list[i].category_name + "</div>";
						}
						
						else if(interest_list[i].fk_category_code == 4) {
							html += "<div class='user_interest red_tag' onclick='del_interest(" + interest_list[i].fk_category_code + ");'>" + interest_list[i].category_name + "</div>";
						}
						
						else if(interest_list[i].fk_category_code == 5) {
							html += "<div class='user_interest orange_tag' onclick='del_interest(" + interest_list[i].fk_category_code + ");'>" + interest_list[i].category_name + "</div>";
						}
						
						else if(interest_list[i].fk_category_code == 6) {
							html += "<div class='user_interest brown_tag' onclick='del_interest(" + interest_list[i].fk_category_code + ");'>" + interest_list[i].category_name + "</div>";
						}
						
						else if(interest_list[i].fk_category_code == 7) {
							html += "<div class='user_interest yellow_tag' onclick='del_interest(" + interest_list[i].fk_category_code + ");'>" + interest_list[i].category_name + "</div>";
						}
						
						else {
							html += "<div class='user_interest khaki_tag' onclick='del_interest(" + interest_list[i].fk_category_code + ");'>" + interest_list[i].category_name + "</div>";
						}
						
					}
					
				} // end of if(json.length > 0) {} -----
				
				else {
					html += "등록된 태그가 없습니다.";
				}
				
				$("div#interset").html(html);
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
	}
	<%-- 모든 관심코드 불러오기 끝 --%>
	
	<%-- 관심코드 추가하기 시작 --%>
	function plus_interest(code) {
		
		$.ajax ({
			url:"/mypage/plus_interest_ajax",
			type:"GET",
			dataType:"json",
			data:{
				"userid":$("input#userid").val(),
				"category_code":code
			},
			success:function(json){
				
				// console.log("~~~~ 확인용 : " + JSON.stringify(json));
				
    			$("span#interest_add").show();
    			
    			setTimeout(function(){
    				$("span#interest_add").fadeOut();
    			}, 1000);
				
				all_interest();
						
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }	
		});
		
	}
	<%-- 관심코드 추가하기 끝 --%>
	

	
	<%-- 관심코드 삭제하기 시작 --%>
	function del_interest(code) {
		
		$.ajax ({
			url:"/mypage/del_interest_ajax",
			type:"GET",
			dataType:"json",
			data:{
				"userid":$("input#userid").val(),
				"category_code":code
			},
			success:function(json){
				
				// console.log("~~~~ 확인용 : " + JSON.stringify(json));
				
				$("span#interest_del").show();
    			
    			setTimeout(function(){
    				$("span#interest_del").fadeOut();
    			}, 1000);
				
				all_interest();
				
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }	
		});
		
	}
	<%-- 관심코드 삭제하기 끝 --%> 
	
	<%-- 이메일 중복확인버튼 누르기 시작 --%> 
	function email_check() {
		
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
	
	let timer_flag = true;
	
	<%-- 인증하기 버튼 보이기 및 인증번호 보내기 시작 --%> 
	function show_identify(){
		
		$("div#timer_error").hide();
		
		randomStr = Math.random().toString(36).substring(2, 12);
		console.log(randomStr);
		
		$(".mobile_identify").show(); // 인증하기 버튼 보이기
		
		$("div#go_identify").show();
		
		setTimeout(function(){
			$("div#go_identify").fadeOut();
		}, 1000);
		
		if(timer_flag) {
			
			timer_flag = false;
			
			// 타이머 시작
			var time = 300;
			var min = "";
			var sec = "";
			
			var x = setInterval(function(){
				
				min = parseInt(time/60);
				sec = time%60;
				
				var timer = min + "분" + sec + "초";
				
				$("div#timer").html(timer); 
				time--;
				
				if(time < 0) {
					// 타임아웃 시
					clearInterval(x);
					
					$("div#timer").hide();
					
					$("div#timer_error").show();
					
					$(".mobile_identify").hide(); // 모바일 인증하기 숨기기
					
					timer_flag = true;
				}
					
			}, 1000);
			// 타이머 끝
		}	
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
		
		<%-- 입력한 인증번호가 맞는지 아닌지 확인하기 시작 --%>
		$("button#button_identify").click(function(){
			if( $("input#input_identify").val() != randomStr ) {
				// 인증번호가 틀렸을때
				$("div.error").hide();
				$("div#identify_error").show();
				
				$("button#edit_button").prop("disabled", true);
				$("button#edit_button").removeClass("sucess_button_change");
			}
			else {
				// 인증 번호가 맞을 때
				$("div.error").hide();
				$("div#identify_success").show();
				b_flag_idfDuplicate_click = true;
				
				clearInterval(x);
				$("div#timer").hide();
				
				var modal = document.getElementById("myModal");

				modal.style.display = "none";
				
				edit(); // 수정하기
			}
			<%-- 입력한 인증번호가 맞는지 아닌지 확인하기 끝 --%>
		});
			
	};
	<%-- 인증하기 버튼 보이기 및 인증번호 보내기 끝 --%> 
	
	
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
			// Get the modal
			var modal = document.getElementById("myModal");

	       // Get the button that opens the modal
	       var btn = document.getElementById("myBtn");

	       // Get the <span> element that closes the modal
	       var span = document.getElementsByClassName("close")[0];

	       // When the user clicks the button, open the modal 
	       
	       modal.style.display = "block";
	       

	       // When the user clicks on <span> (x), close the modal
	       span.onclick = function() {
	         modal.style.display = "none";
	       }

	       // When the user clicks anywhere outside of the modal, close it
	       window.onclick = function(event) {
	         if (event.target == modal) {
	           modal.style.display = "none";
	         }
	       }
			
		}
		else {
			
			edit();
		}
		
	};
	<%-- 수정하기 버튼 누르기 끝 --%>
	
	<%-- 정보수정하기 시작 --%>
	function edit() {
	
		// alert($("input#profile_pic_file").val());
		
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
                	alert("정보수정이 완료되었습니다.");
                	
                	const frm = document.editFrm;
             	     
               	    frm.action = '/mypage/mypageHome';
               	    frm.method = 'POST';
               	    frm.submit();
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
	/*
	function image() {
		
		const frm = document.editFrm;
  	     
   	    frm.action = '/mypage/mypageHome';
   	    frm.method = 'POST';
   	    frm.submit();
		
	}
	*/
</script>

	<div id="mainPosition">
		<!-- index 상단 제목 시작 -->
 		<div class="d-sm-flex align-items-center justify-content-between mb-4">
			<h1 class="h3 mb-0 text-gray-800 font_weight">내정보 수정하기</h1>
		</div>
		<!-- index 상단 제목 끝 -->
		
		<!-- index 메인 시작 -->
		
		<div class="row shadow" id="MFE_row">
		
			<div class="col-lg-4" style="padding-top:32px;">
				
				<img id="second_img_button" alt="프로필이미지" onclick="document.all.profile_pic_file.click();"
				src="<%= ctxPath%>/images/${requestScope.udto.profilePic}"  />
				
				<button type="button" id="img_button" onclick="document.all.profile_pic_file.click();">
					<i class="fas fa-camera fa-lg" style="font-size:21pt;"></i>
				</button>
				<div>
					
				    <div id="interest_margin">
				   		<span id="interest_title">관심태그</span>
				   		
				    	<span id="interest_add">
				    		<span class="balloon left">
				    			<span class="balloon_span">관심태그 추가 완료</span>
				    		</span>
				    	</span>
				    	<span id="interest_del">
				    		<span class="balloon left">
				    			<span class="balloon_span">관심태그 삭제 완료</span>
				    		</span>
				    	</span>
				    </div>
				     
				   
				    <div id="all_interest"></div>
				    <div id="interset"></div>
			    </div>
			</div>
		
			<form name="editFrm" id="editFrm" class="offset-lg-2 col-lg-6" method="post" enctype="multipart/form-data" style="max-width:100%;">
				<input type="file" id="profile_pic_file" name="profile_pic_file" accept=".gif, .jpg, .png" onchange="img_change(this);" style="display:none;" />

				<input type="hidden" name="profilePic" id="profilePic" value="${requestScope.udto.profilePic}" />
			    <input type="hidden" name="test" id="test" />
			    
			    <input type="hidden" name="userid" id="userid" value="${requestScope.udto.userid}" />
			    
			    <h6 class="text-danger">! 주의 !</h6>
			    <h6 class="text-danger">관심태그는 태그를 누르는 순간 등록과 삭제가 되므로, 수정하기 버튼을 누를 필요 없습니다.</h6>
			    <h6 class="text-danger">비밀번호와 연락처 변경은 핸드폰 인증번호 확인이 필요합니다.</h6>
			    <h6 class="text-danger">이메일 변경은 이메일 중복확인이 필요합니다.</h6>
			      
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
			            	<input type="hidden" name="pw" id="pw" />
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
			         
				</table>
			</form>
		</div>
	</div>
	<!-- 메인 끝 -->
	<div class="row" style="padding:0 14px;">
		<form name="reward_form" style="width:100%;">
			<button type="button" id="edit_button" class="col-lg-12 font_weight" onclick="go_edit();">수  정</button> 
		</form>
	</div>
	
	  <!-- Modal content -->
	  <div id="myModal" class="modal">

	  <!-- Modal content -->
	  <div class="modal-content">
	    <span class="close">&times;</span>
	    <table>
	    	<tr>
	         	<td class="identify_table_style">
		        	<button type="button" id="plz_identify" onclick="show_identify();">인증번호요청하기</button>
		        </td>
		        <td id="identify_td">
	                <input type="text" id="input_identify" class="mobile_identify" style="margin-right:7%;" />
	            </td>
	            <td class="text_align_right identify_table_style">
	                <button type="button" id="button_identify" class="mobile_identify">인증하기</button>
	            </td>
	        </tr>
	                
	    </table>
	    
		<div id="timer" class="identify_div_position"></div>
        <div id="go_identify" class="error identify_div_position" style="color:blue;">인증번호를 발송했습니다.</div>
        <div id="identify_error" class="error identify_div_position">인증번호가 틀렸습니다.</div>
        <div id="timer_error" class="error identify_div_position">5분이 지났습니다. 다시 인증번호를 받아주세요.</div>
        <div id="plz_identify_error" class="error identify_div_position">인증번호를 입력해주시기 바랍니다.</div>
	   
	    
	  </div>

</div>

	

</body>
</html> 
