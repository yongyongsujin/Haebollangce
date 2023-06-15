<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.6/dist/sweetalert2.all.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.6/dist/sweetalert2.min.css" rel="stylesheet">

<style type="text/css">

	label#label_file {
		padding: 6px 25px;
		background-color: #EB534C;
		border-radius: 4px;
		color: white;
		cursor: pointer;
	}
	span.examInfo_left {
		display: inline-block; 
		width: 50%; 
		padding-left: 20%;
	}
	span.examInfo_right {
		display: inline-block; 
		width: 50%; 
		padding-left: 10%;
	}
	div.examInfo {
		width:70%; 
		font-size: 15pt; 
		margin: auto; 
		text-align: left;
	}
	div#img_exam {
		width:100%; 
		height: 500px; 
		display: flex; 
		font-size: 18pt; 
		font-weight: bold; 
		color: white;
	}
	p.img_OX {
		line-height: 48px;
		width: 100%; 
		height: 10%;
		border-bottom-left-radius: 20px; 
		border-bottom-right-radius: 20px;
	}
	img.img_insert {
		border: solid 2px black;
		border-top-left-radius: 20px; 
		border-top-right-radius: 20px;
	}
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 파일이름을 변경해야만 이벤트가 일어나도록 해야 하므로 change 이벤트 사용
		$(document).on("change", "input#input_file", function(e){
			const input_file = $(e.target).get(0); 
			// jQuery선택자.get(0) 은 jQuery 선택자인
			// jQuery Object 를 DOM (document object Model) element 로 바꿔주는 것이다. 
	        // DOM element 로 바꿔주어야 순수한 javascript 문법과 명령어를 사용할 수 있게 된다.
	        
	        // console.log(input_file.files);
	        /*
	         FileList {0: File, length: 1}
	            0:    File {name: 'berkelekle심플라운드01.jpg', lastModified: 1605506138000, lastModifiedDate: Mon Nov 16 2020 14:55:38 GMT+0900 (한국 표준시), webkitRelativePath: '', size: 71317, …}
	            length: 1
	            [[Prototype]]: FileList
	         */
	         // 파일이름을 선택한 후, file input 엘리먼트의 files 프로퍼티를 출력해보면, 위와 같이 FileList 라는 객체가 출력되는 것을 볼 수 있다. 
	         // FileList 객체 프로퍼티(키)는 0,1 … 형태의 숫자로, 그리고 값에는 File 객체가 들어있다. 
	         // file input 엘리먼트의 files 프로퍼티의 값이 FileList 로 되어있으므로 File 객체에 접근하려면 input_file.files[i] 이런 식으로 사용하여 i 번째의 File 객체에 접근을 한다.
		 
	         
	        // console.log(input_file.files[0]);
	        /*
            File {name: 'berkelekle심플라운드01.jpg', lastModified: 1605506138000, lastModifiedDate: Mon Nov 16 2020 14:55:38 GMT+0900 (한국 표준시), webkitRelativePath: '', size: 71317, …}
         
             >>설명<<
             name : 단순 파일의 이름 string타입으로 반환 (경로는 포함하지 않는다.)
             lastModified : 마지막 수정 날짜 number타입으로 반환 (없을 경우, 현재 시간)
             lastModifiedDate: 마지막 수정 날짜 Date객체타입으로 반환
             size : 64비트 정수의 바이트 단위 파일의 크기 number타입으로 반환
             type : 문자열인 파일의 MIME 타입 string타입으로 반환 
                    MIME 타입의 형태는 type/subtype 의 구조를 가지며, 다음과 같은 형태로 쓰인다. 
                   text/plain
                   text/html
                   image/jpeg
                   image/png
                   audio/mpeg
                   video/mp4
                   ...
         	*/
	        // console.log(input_file.files[0].name);  
             
             
	     	// File 객체의 실제 데이터(내용물)에 접근하기 위해 FileReader 객체를 생성하여 사용한다.
	        const fileReader = new FileReader();
	         
	        fileReader.readAsDataURL(input_file.files[0]); // FileReader.readAsDataURL() --> 파일을 읽고, result속성에 파일을 나타내는 URL을 저장 시켜준다.
	      
	        fileReader.onload = function() { // FileReader.onload --> 파일 읽기 완료 성공시에만 작동하도록 하는 것임. 
		        // console.log(fileReader.result);
		        /*
				data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAeAB4AAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAg 
				이러한 형태로 출력되며, img.src 의 값으로 넣어서 사용한다.
		        */
				document.getElementById("previewImg").src = fileReader.result;
	        };
	        
		}); // end $(document).on("change", "input.img_file", function(e)
		
				
		$("button#btn_certify").click(function(){
			
			if ( $("input#input_file").val() == "" ) {
				Swal.fire({
					icon: "error",
					title: "인증사진을 선택해주세요",
					confirmButtonColor: "#EB534C",
					confirmButtonText: "확인"
				});
				return;
			}
			
			const frm = document.certifyform;
			frm.method = "post";
			frm.action = "<%= ctxPath%>/challenge/certify";
			frm.submit();
			
		});
		
	}); // end
	
</script>

<div class="container-fluid" style="background-color: #f4f4f4;">
<div class="container" style="border-radius: 20px; background-color: white; text-align: center;">
	<br>
	<h3 style="font-weight: bold;">인증하기</h3>
	<br>
	<div style="height: 783px; justify-content: center;">
		<div id="img_exam" class="mb-5">
			<div style="width: 50%; border-radius: 20px;">
				<img class="img_insert" src="<%= ctxPath%>/images/${oneExample.success_img}" width="100%" height="90%" style="object-fit: cover;"/>
				<p class="img_OX" style="background-color:#57B585;">○</p>
			</div>
			<div style="width: 50%; border-radius: 20px;">
				<img class="img_insert" src="<%= ctxPath%>/images/${oneExample.fail_img}" width="100%" height="90%" style="object-fit: cover;"/>
				<p class="img_OX" style="background-color:#AF2317;">✕</p>
			</div>
		</div>
		<div class="my-3" style="font-size: 18pt; font-weight: bold;">인증 예시) - ${oneExample.example}</div>
		<div class="my-3" style="font-size: 18pt; font-weight: bold;">꼭 알아주세요 !</div>
		<div>
			<div class="examInfo my-2">
				<span class="examInfo_left">인증 빈도</span><span class="examInfo_right">${oneExample.frequency}</span>
			</div>
			<div class="examInfo my-2">
				<span class="examInfo_left">인증 가능 시간</span><span class="examInfo_right">${oneExample.hour_start} ~ ${oneExample.hour_end}</span>
			</div>
			<div class="examInfo my-2">
				<span class="examInfo_left">하루 인증 횟수</span><span class="examInfo_right">1회</span>
			</div>
			
		</div>
	</div>
	<div class="mt-5" style="width: 60%; height: 60%; margin: auto;">
		<img id="previewImg"  width="100%" height="100%" />
	</div>
	<div style="display: flex; justify-content: center;">
		<br>
		<form name="certifyform" enctype="multipart/form-data">
			<label id="label_file" for="input_file" class="mx-3 my-3 btn-lg">사진 선택</label>
			<input id="input_file" name="certify_img" type="file" accept="image/*" capture="camera" readonly="readonly" style="display: none;">
			<input name="fk_userid" type="hidden" value="${paraMap.fk_userid}" readonly="readonly">
			<input name="fk_challenge_code" type="hidden" value="${paraMap.challenge_code}" readonly="readonly">
		</form>
		<br>
	</div>
	<div class="pb-5" style="display: flex; justify-content: center;">
	    <button type="button" class="btn btn-secondary btn-md mb-3 btn-lg" id="btn_certify">인증하기</button>
	</div>
        
</div>
</div>
