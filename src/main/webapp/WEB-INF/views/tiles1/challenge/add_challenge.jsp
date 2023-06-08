<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
   String ctxPath = request.getContextPath();
%>   



<!-- JS, Popper.js, and jQuery -->

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" >

<style type="text/css">

	th {width: 20%; background-color: #DDDDDD;}
	
	
	.certify_freq_group, .challenge_during_group {
		display: flex;
	}

	.certify_freq_form, .challenge_during_form {
		width: 40%;
		height : 45px;
    		border: 1px solid #EAE7E7;
    		border-radius: 10px;
    		margin-right: 10px;
	}
	.certify_freq_form input[type=radio], .challenge_during_form input[type=radio] {
		display: none;
	}
	.certify_freq_form label, .challenge_during_form label {
			display: block;
   			border-radius: 10px;
  			margin: 0 auto;
   			text-align: center;
   			height: -webkit-fill-available;
   			line-height: 45px;
	}
	 
	/* Checked */
	.certify_freq_form input[type=radio]:checked + label, .challenge_during_form input[type=radio]:checked + label {
		background: #ff9999;
		color: #fff;
	}
	 
	/* Hover */
	.certify_freq_form label:hover, .challenge_during_form label:hover {
		color: #666;
	}
	 
	/* Disabled */
	.certify_freq_form input[type=radio] + label, .challenge_during_form input[type=radio] + label {
		background: #F9FAFC;
		color: #666;
	}

</style>    

<script type="text/javascript">

	$(document).ready(function(){
		
		$('#startTime').datetimepicker({
			format: 'HH:mm',
			stepping: 15,
			minDate: moment().startOf('day').set({hour: 0, minute: 0}), // 최소 시간을 12:00 AM(자정)로 설정
	        maxDate: moment().endOf('day').set({hour: 23, minute: 59}) // 최대 시간을 11:59 PM로 설정
		});
        $('#endTime').datetimepicker({
        		format: 'HH:mm',
        		stepping: 15,
        		useCurrent: false,
        		minDate: moment().startOf('day').set({hour: 0, minute: 30}), // 최소 시간을 12:00 AM(자정)로 설정
        		maxDate: moment().endOf('day').set({hour: 23, minute: 59}) // 최대 시간을 11:59 PM로 설정
        });
       
        $("#startTime").on("change.datetimepicker", function (e) {
            $('#endTime').datetimepicker('minDate', e.date);
            
            var startTimeValue = $('#startTime').val();
            console.log("StartTime value:", startTimeValue);
            
        });

        $("#endTime").on("change.datetimepicker", function (e) {
            var startTime = $('#startTime').datetimepicker('date');
            var endTime = e.date;

            if (startTime !== null && endTime !== null && endTime.isSameOrBefore(startTime)) {
            		$('#endTime').datetimepicker('date', startTime.add(1, 'hours'));
            }
            
            var endTimeValue = $('#endTime').val();
            console.log("EndTime value:", endTimeValue);
            
        });
        
		
        $('#startdate').datetimepicker({
            format: 'YYYY-MM-DD',
            minDate: new Date()
        });
       
	    //전역변수
	    var obj = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "content",
	        sSkinURI: "/smarteditor/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true,
	        }
	    });
	    
	    $("#btnWrite").click(function(){

	     	<%-- === 스마트 에디터 구현 시작 === --%>
			    // id가 content인 textarea에 에디터에서 대입
	            obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		    <%-- === 스마트 에디터 구현 끝 === --%>
		    
		 	// 챌린지제목 유효성 검사
	         const challenge_name = $("input#challenge_name").val().trim();
	         if(challenge_name == "") {
	            alert("글제목을 입력하세요!!");
	            return;
	         }
	         
	         <%-- 글내용 유효성 검사(스마트 에디터 사용 할 경우) 시작 --%>
	         let content = $("textarea#content").val();
	         
	         content = content.replace(/&nbsp;/gi, "");  // 공백을 "" 으로 변환 
	         
	         content = content.substring(content.indexOf("<p>")+3);
	     	 content = content.substring(0, content.indexOf("</p>"));
	     	 
	     	 if(content.trim().length == 0) {
	     		alert("글내용을 입력하세요!!");
	            return;
	     	 }
	     	<%-- 글내용 유효성 검사(스마트 에디터 사용 할 경우) 끝 --%>  
	     	
	     	/*
	     	 // 경험치 유효성 검사
	         const challenge_exp = $("input#challenge_exp").val().trim();
	         if(challenge_exp == "") {
	            alert("경험치를 입력하세요!!");
	            return;
	         }
	         
	      	 // 카테고리 유효성 검사
	         const category_code = $("select#category_code").val().trim();
	         if(category_code == "") {
	            alert("카테고리를 선택하세요!!");
	            return;
	         }
	         
	      	 // 인증 방법 유효성 검사
	         const example = $("input#example").val().trim();
	         if(example == "") {
	            alert("인증방법을 입력하세요!!");
	            return;
	         }
	         
	      	 // 인증성공 예시첨부 유효성 검사
	         const success_img = $("input#success_img").val().trim();
	         if(success_img == "") {
	            alert("인증성공 예시 사진을 첨부해주세요!!");
	            return;
	         }
	         
	      	 // 인증실패 예시첨부 유효성 검사
	         const fail_img = $("input#fail_img").val().trim();
	         if(fail_img == "") {
	            alert("인증실패 예시 사진을 첨부해주세요!!");
	            return;
	         }
	         
	      	 // 챌린지 기간 유효성 검사
	         const challenge_during = $("input.challenge_during").val().trim();
	         if(challenge_during == "") {
	            alert("챌린지 기간을 선택해주세요!!");
	            return;
	         }
	         
	      	 // 챌린지 시작일 유효성 검사
	         const startdate = $("input#startdate").val().trim();
	         if(startdate == "") {
	            alert("챌린지 시작일을 선택해주세요!!");
	            return;
	         }
	         
	      	 // 인증빈도 유효성 검사
	         const certify_freq = $("input.certify_freq").val().trim();
	         if(certify_freq == null) {
	            alert("인증빈도를 선택해주세요!!");
	            return;
	         }
	         
	      	 // 인증가능 시간 유효성 검사
	         const startTime = $("input#startTime").val().trim();
	         if(startTime == "") {
	            alert("인증가능 시작시간을 설정해주세요!!");
	            return;
	         }
	         
	      	 // 인증가능 종료 시간 유효성 검사
	         const endTime = $("input#endTime").val().trim();
	         if(startTime == "") {
	            alert("인증가능 종료시간을 설정해주세요!!");
	            return;
	         }
	         */
	         
	     	 // 폼(form)을 전송(submit)
	         const frm = document.addFrm;
	         frm.method = "POST";
	         frm.action = "<%= ctxPath%>/challenge/addEnd";
	         frm.submit();
	         
	         
		}); // end of $("#btnWrite").click(function()-----------------------
 	 	
		
});

</script>

<div style="display: flex; margin-top: 80px;">
	<div style="margin: auto; padding-left: 3%;">
	
		<h2 style="margin: 20px 0 20px 0; background-color: #ff9999; width: 20%; text-align: center; color: white; border-radius: 5px;">챌린지 만들기</h2>
	
		<form name="addFrm" enctype="multipart/form-data">
			<table style="width: 1200px; table-layout:fixed;" class="table table-bordered" >
		    	<tr>
	        		<th>성명</th>
	         	<td>
	            	<input type="text" name="fk_userid" />
	           <!--  	<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" readonly/> -->
	         	</td>
	      	</tr>
	      	
	      	<tr>
	      	   <th>챌린지 제목</th>
	      	   <td>
	      	      	<input type="text" name="challengeName" id="challenge_name" size="100" maxlength="30" placeholder="예)1만보 걷기"/>    
	      	   </td>
	      	</tr>
	      	
	      	<tr>
	      	   <th>경험치</th>
	      	   <td>
	      	      	<input type="text" pattern="\d*" maxlength="3" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" name="challengeExp" id="challenge_exp" size="10" placeholder="최대 999"/>    
	      	   </td>
	      	</tr>
	      	
	      	<tr>
	      		<th>카테고리</th>
	      		<td>
	      			<select name="fk_categoryCode" id="category_code"> 
			            <option value="">:::선택하세요:::</option> 
			            <c:forEach var="map" items="${requestScope.categoryList}">
			            	<option value="${map.categoryCode}">${map.categoryName}</option>
			            </c:forEach>  
			         </select>
	      		</td>
	      	</tr>
	      	
	      	<tr>
		         <th>대표사진 등록</th>
		         <td>
		             <input type="file" name="attach" id="thumbnail" accept="image/gif, image/jpeg, image/png"/>
		         </td>
	      	</tr>
	      	
			<tr>
	      		<th>챌린지 소개</th>
	      		<td>
	      	    	<textarea style="width: 100%; height: 612px;" name="content" id="content"></textarea>
	      	   	</td>
	      	</tr>
	      	
	      	<tr>
	      	   <th>인증 방법</th>
	      	   <td>
	      	      	<input type="text" name="example" id="example" size="105" maxlength="100" placeholder="예)오늘 날짜와 걸음 수가 적힌 만보기 캡쳐 화면 업로드"/>    
	      	   </td>
	      	</tr>
	      	
	      	<tr>
		         <th>인증성공 예시첨부</th>
		         <td>
		             <input type="file" name="successImgAttach" id="success_img" accept="image/gif, image/jpeg, image/png"/>
		         </td>
	      	</tr>
	      
	      	<tr>
		         <th>인증실패 예시첨부</th>
		         <td>
		             <input type="file" name="failImgAttach" id="fail_img" accept="image/gif, image/jpeg, image/png"/>
		         </td>
	      </tr>
	     
	      <tr>
	 	  	<th>챌린지 기간</th>
	 	  		<td>
	 	  			<div class="challenge_during_group">
		 	  			<c:forEach var="during" items="${requestScope.duringList}">	
		 	  				<div class="challenge_during_form">
		 	  					<input type="radio" class="challenge_during" name="fk_duringType" id="${during.setDate}" value="${during.duringType}" />
		 	  					<label for="${during.setDate}">${during.setDate}</label>
		 	  				</div>
		 	  			</c:forEach>	
	 	  			</div>
	 	  		</td>
	 	  </tr>
	 	 
	 	  <tr>
	 	  	<th>챌린지 시작일</th>
	 	  	<td>	
           		<div class="row">
			        <div class="col-sm-4">
			            <div class="form-group">
			                <div class="input-group date" data-target-input="nearest">
			                    <input type="text" class="form-control datetimepicker-input" name="startDate" id="startdate" data-target="#startdate"/>
			                    <div class="input-group-append" data-target="#startdate" data-toggle="datetimepicker">
			                        <div class="input-group-text"><i class="fa fa-calendar"></i></div>
			                    </div>
		               		</div>
		            		</div>
		            </div>
	            </div>
	 	  	</td>
	 	  </tr>
	 	  
	 	  <tr>
	 	  	<th>인증빈도</th>
	 	  	<td>
	 	  		
	 	  		<div class="certify_freq_group">
	 	  			<c:forEach var="freq" items="${requestScope.freqList}">
			 	  		<div class="certify_freq_form">
				 	  		<input type="radio" class="certify_freq" name="fk_freqType" id="${freq.frequency}" value="${freq.freqType}"/>
				 	  		<label for="${freq.frequency}">${freq.frequency}</label>
			 	  		</div>
		 	  		</c:forEach>
		 	  			
	 	  		</div>
	 	  		
	 	  	</td>
	 	  </tr>
	      
	 	  <tr>
	 	  		<th>인증가능 시간</th>
	 	  		<td>
	 	  			<div class="row">
					  <div class="col-sm-3">
					      <div class="form-group">
					          <div class="input-group date" id="startTimePicker" data-target-input="nearest">
					              <input type="text" name="hourStart" class="form-control datetimepicker-input" id="startTime" data-target="#startTime" placeholder="시작시간" autocomplete='off'/>
					              <div class="input-group-append" data-target="#startTime" data-toggle="datetimepicker">
					                  <div class="input-group-text"><i class="fa fa-clock-o"></i></div>
					              </div>
					          </div>
					      </div>
					  </div>
					  
					  <div class="col-sm-3">
					      <div class="form-group">
					          <div class="input-group date" id="endTimePicker" data-target-input="nearest">
					              <input type="text" name="hourEnd" class="form-control datetimepicker-input" data-target="#endTime" id="endTime" placeholder="종료시간" autocomplete='off'/>
					              <div class="input-group-append" data-target="#endTime" data-toggle="datetimepicker">
					                  <div class="input-group-text"><i class="fa fa-clock-o"></i></div>
					              </div>
					          </div>
					      </div>
					  </div>
					</div>
	 	  		</td>
	 	  </tr>
	 	  
	 	  
	 	  
  	
		   </table>
		   
		   <div style="margin: 20px;">
		      <button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">글쓰기</button>
		      <button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
		   </div>
		   
		</form>   
	</div>
</div> 