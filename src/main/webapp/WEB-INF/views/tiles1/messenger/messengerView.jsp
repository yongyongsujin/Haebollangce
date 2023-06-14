<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %> 

<style type="text/css">

	body {
	    background-color: #f4f7f6;
	    margin-top:20px;
	}
	.card {
	    background: #fff;
	    transition: .5s;
	    border: solid 1px #eee;
	    margin-bottom: 30px;
	    border-radius: .55rem;
	    position: relative;
	    width: 100%;
	    box-shadow: 0 1px 2px 0 rgb(0 0 0 / 10%);
	}
	.chat-app .people-list {
	    width: 280px;
	    position: absolute;
	    left: 0;
	    top: 0;
	    padding: 20px;
	    /* z-index: 7 */
	}
	
	.chat-app .chat {
	    margin-left: 280px;
	    border-left: 1px solid #eaeaea
	}
	
	.people-list {
	    -moz-transition: .5s;
	    -o-transition: .5s;
	    -webkit-transition: .5s;
	    transition: .5s
	}
	
	.people-list .chat-list li {
	    padding: 10px 15px;
	    list-style: none;
	    border-radius: 3px
	}
	
	.people-list .chat-list li:hover {
	    background: #efefef;
	    cursor: pointer
	}
	
	.people-list .chat-list li.active {
	    background: #efefef
	}
	
	.people-list .chat-list li .name {
	    font-size: 15px
	}
	
	.people-list .chat-list img {
	    width: 45px;
	    border-radius: 50%
	}
	
	.people-list img {
	    float: left;
	    border-radius: 50%
	}
	
	.people-list .about {
	    float: left;
	    padding-left: 8px
	}
	
	.people-list .status {
	    color: #999;
	    font-size: 13px
	}
	
	.chat .chat-header {
	    padding: 15px 20px;
	    border-bottom: 2px solid #f4f7f6
	}
	
	.chat .chat-header img {
	    float: left;
	    border-radius: 40px;
	    width: 40px
	}
	
	.chat .chat-header .chat-about {
	    float: left;
	    padding-left: 10px
	}
	
	.chat .chat-history {
	    padding: 20px;
	    border-bottom: 2px solid #fff
	}
	
	.chat .chat-history ul {
	    padding: 0
	}
	
	.chat .chat-history ul li {
	    list-style: none;
	    margin-bottom: 30px
	}
	
	.chat .chat-history ul li:last-child {
	    margin-bottom: 0px
	}
	
	.chat .chat-history .message-data {
	    margin-bottom: 15px
	}
	
	.chat .chat-history .message-data img {
	    border-radius: 40px;
	    width: 40px
	}
	
	.chat .chat-history .message-data-time {
	    color: #434651;
	    padding-left: 6px
	}
	
	.chat .chat-history .message {
	    color: #444;
	    padding: 18px 20px;
	    line-height: 26px;
	    font-size: 16px;
	    border-radius: 7px;
	    display: inline-block;
	    position: relative
	}
	
	.chat .chat-history .message:after {
	    bottom: 100%;
	    left: 7%;
	    border: solid transparent;
	    content: " ";
	    height: 0;
	    width: 0;
	    position: absolute;
	    pointer-events: none;
	    border-bottom-color: #fff;
	    border-width: 10px;
	    margin-left: -10px
	}
	
	.chat .chat-history .my-message {
	    background: #efefef
	}
	
	.chat .chat-history .my-message:after {
	    bottom: 100%;
	    left: 30px;
	    border: solid transparent;
	    content: " ";
	    height: 0;
	    width: 0;
	    position: absolute;
	    pointer-events: none;
	    border-bottom-color: #efefef;
	    border-width: 10px;
	    margin-left: -10px
	}
	
	.chat .chat-history .other-message {
	    background: #e8f1f3;
	    text-align: right
	}
	
	.chat .chat-history .other-message:after {
	    border-bottom-color: #e8f1f3;
	    left: 93%
	}
	
	.chat .chat-message {
	    padding: 20px
	}
	
	.online,
	.offline,
	.me {
	    margin-right: 2px;
	    font-size: 8px;
	    vertical-align: middle
	}
	
	.online {
	    color: #86c541
	}
	
	.offline {
	    color: #e47297
	}
	
	.me {
	    color: #1d8ecd
	}
	
	.float-right {
	    float: right
	}
	
	.clearfix:after {
	    visibility: hidden;
	    display: block;
	    font-size: 0;
	    content: " ";
	    clear: both;
	    height: 0
	}
	
	@media only screen and (max-width: 767px) {
	    .chat-app .people-list {
	        height: 465px;
	        width: 100%;
	        overflow-x: auto;
	        background: #fff;
	        left: -400px;
	        display: none
	    }
	    .chat-app .people-list.open {
	        left: 0
	    }
	    .chat-app .chat {
	        margin: 0
	    }
	    .chat-app .chat .chat-header {
	        border-radius: 0.55rem 0.55rem 0 0
	    }
	    .chat-app .chat-history {
	        height: 300px;
	        overflow-x: auto
	    }
	}
	
	@media only screen and (min-width: 768px) and (max-width: 992px) {
	    .chat-app .chat-list {
	        height: 650px;
	        overflow-x: auto
	    }
	    .chat-app .chat-history {
	        height: 600px;
	        overflow-x: auto
	    }
	}
	
	@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) and (orientation: landscape) and (-webkit-min-device-pixel-ratio: 1) {
	    .chat-app .chat-list {
	        height: 480px;
	        overflow-x: auto
	    }
	    .chat-app .chat-history {
	        height: calc(100vh - 350px);
	        overflow-x: auto
	    }
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("div#mycontent").css({"background-color":"#ccebff"});
		// div#mycontent 는  /Board/src/main/webapp/WEB-INF/tiles/layout/layout-tiles1.jsp 파일의 내용에 들어 있는 <div id="mycontent"> 이다.
		
		// --- 웹브라우저의 주소창의 포트까지 가져옴 ---
		const url = window.location.host;
		// -> url : 192.168.0.57:7070
		
		// --- 포트이후의 최초 '/' 부터 오른쪽에 있는 모든 경로를 가져옴 ---
		const pathname = window.location.pathname;
		// -> pathname : /messenger/messengerView
		
		// --- "전체 문자열".lastIndexOf("검사할 문자"); ---
		const appCtx = pathname.substring(0, pathname.lastIndexOf("/"));
		// -> appCtx : /messenger
		
		const root = url + appCtx;
		
		// --- 웹소켓통신을 하기위해서는 http:// 을 사용하는 것이 아니라 ws:// 을 사용해야 한다. 
		// --- "/messengerView" 에 대한 것은 /WEB-INF/spring/config/websocketContext.xml 파일에 있는 내용이다. 
		const wsUrl = "ws://" + root + "/messengerView";
		// alert("wsUrl : " + wsUrl);
		// -> wsUrl : ws://192.168.0.57:7070/messenger/messengerView
		
		const websocket = new WebSocket(wsUrl); 
		// const websocket = new WebSocket("ws://192.168.0.57:7070/messenger/messengerView"); 이다
       
		// >> ====== !!중요!! Javascript WebSocket 이벤트 정리 ====== << //
	    /*   -------------------------------------
	         		이벤트 종류                       설명
	         -------------------------------------
	            	onopen        WebSocket 연결
	              	onmessage     메시지 수신
	              	onerror       전송 에러 발생
	              	onclose       WebSocket 연결 해제
	    */
	    
	    let messageObj = {}; // 자바스크립트 객체 생성함.
	    
	 	// === (1) 웹소켓에 최초로 연결이 되었을 경우에 실행되어지는 콜백함수 정의하기 === //
	    websocket.onopen = function(){
	    	alert("웹소켓 연결됨");
	    	$("div#chatStatus").text("[정보] 웹소켓 연결에 성공됨");
	    	
	    	messageObj = { message : "채팅방에 <span style='color: red;'>입장</span> 했습니다" 
	    				 , type : "all"
	    				 , to : "all" }; // => 여기까지가 자바스크립에서 객체의 데이터값 초기화해준것임
	    	websocket.send(JSON.stringify(messageObj));	
	    	// JSON.stringify(자바스크립트객체) 는 자바스크립트객체를 JSON 표기법의 문자열(string)로 변환한다
            // JSON.parse(JSON 표기법의 문자열) 는 JSON 표기법의 문자열(string)을 자바스크립트객체(object)로 변환해준다.
			/*
				JSON.stringify({});                  // '{}'
			  	JSON.stringify(true);                // 'true'
			  	JSON.stringify('foo');               // '"foo"'
			  	JSON.stringify([1, 'false', false]); // '[1,"false",false]'
			  	JSON.stringify({ x: 5 });            // '{"x":5}'
			*/
	    	
	    };//end of onopen----------------------------------------
	 	
	    
	    // === (2) 메시지 수신시 콜백함수 정의하기 === //
	    websocket.onmessage = function(event){
	    	
	    	// event.data 는  수신되어진 메시지이다. 즉, 지금은「용수진 엄정화 이순신 」 이다.
	    	// -> substr(0,1) : 0번째부터 1글자
	    	if(event.data.substr(0,1)=="「" && event.data.substr(event.data.length-1)=="」") {
	    		$("div#connectingUserList").html(event.data);
	    	}
	    	else {
	    		// 수신받은 채팅문자이다.
	    		$("div#chatMessage").append(event.data);
	    		$("div#chatMessage").append("</br>");
	    		$("div#chatMessage").scrollTop(999999999);
	    	}
	    	
	    	// === 웹소켓 연결 해제시 콜백함수 정의하기 === //
	        websocket.onclose = function(){ }
	    	
	    	// --- (2a) 메시지 입력후 엔터하기 --- //
	        $("input#message").keyup(function(key){
	           	if(key.keyCode == 13) {
	              	$("input#btnSendMessage").click();
	           	}
	        });
	    	
	    	// --- (2b) 메시지 보내기 --- //
	        let isOnlyOneDialog = false; // 귀속말 여부. true 이면 귀속말, false 이면 모두에게 공개되는 말  
	        
	        $("input#btnSendMessage").click(function(){
	           
	           if( $("input#message").val().trim() != "" ) {
	             
	           // ==== 자바스크립트에서 replace를 replaceAll 처럼 사용하기 ====
	             // 자바스크립트에서 replaceAll 은 없다.
	             // 정규식을 이용하여 대상 문자열에서 모든 부분을 수정해 줄 수 있다.
	             // 수정할 부분의 앞뒤에 슬래시를 하고 뒤에 gi 를 붙이면 replaceAll 과 같은 결과를 볼 수 있다.
	             
	                let messageVal = $("input#message").val();
	                messageVal = messageVal.replace(/<script/gi, "&lt;script"); 
	                // 스크립트 공격을 막으려고 한 것임.
	                
	                <%-- 
	                 messageObj = {message : messageVal
	                            	,type : "all"
	                            	,to : "all"}; 
	                --%>
	                // 또는
	                messageObj = {}; // 자바스크립트 객체 생성함.
	                messageObj.message = messageVal;
	                messageObj.type = "all";
	                messageObj.to = "all";
	                
	                const to = $("input#to").val();
	                if( to != "" ) {
	                   messageObj.type = "one";
	                    messageObj.to = to;
	                }
	                
	                websocket.send(JSON.stringify(messageObj));
	                // JSON.stringify() 는 값을 그 값을 나타내는 JSON 표기법의 문자열로 변환한다
	             
	             // 위에서 자신이 보낸 메시지를 웹소켓으로 보낸 다음에 자신이 보낸 메시지 내용을 웹페이지에 보여지도록 한다.
	                const now = new Date();
	                let ampm = "오전 ";
	                let hours = now.getHours();
	                
	                if(hours > 12) { hours = hours - 12; ampm = "오후 "; }
	                if(hours == 0) { hours = 12; }
	                if(hours == 12) { ampm = "오후 "; }
	                
	                let minutes = now.getMinutes();
	                if(minutes < 10) { minutes = "0"+minutes; }
	              
	                const currentTime = ampm + hours + ":" + minutes; 
	                
	                if(isOnlyOneDialog == false) {  // 귀속말이 아닌 경우
	                   $("div#chatMessage").append("<div style='background-color: #ffff80; display: inline-block; max-width: 60%; float: right; padding: 7px; border-radius: 15%; word-break: break-all;'>" + messageVal + "</div> <div style='display: inline-block; float: right; padding: 20px 5px 0 0; font-size: 7pt;'>"+currentTime+"</div> <div style='clear: both;'>&nbsp;</div>");
	                }                                                                                                                                                           /* word-break: break-all; 은 공백없이 영어로만 되어질 경우 해당구역을 빠져나가므로 이것을 막기위해서 사용한다. */
	                else { // 귀속말인 경우. 글자색을 빨강색으로 함.
	                   $("div#chatMessage").append("<div style='background-color: #ffff80; display: inline-block; max-width: 60%; float: right; padding: 7px; border-radius: 15%; word-break: break-all; color: red;'>" + messageVal + "</div> <div style='display: inline-block; float: right; padding: 20px 5px 0 0; font-size: 7pt;'>"+currentTime+"</div> <div style='clear: both;'>&nbsp;</div>");
	                }                                                                                                                                                           /* word-break: break-all; 은 공백없이 영어로만 되어질 경우 해당구역을 빠져나가므로 이것을 막기위해서 사용한다. */ 
	                
	                $("div#chatMessage").scrollTop(999999999);
	                $("input#message").val("");
	                $("input#message").focus();
	           }
	           
	        });
	        //////////////////////////////////////////////////////
	    	
	     	// --- (2c) 귀속말대화끊기 버튼은 처음에는 보이지 않도록 한다.
	        $("button#btnAllDialog").hide();
	        
	     	// --- (2d) 아래는 귓속말을 위해서 대화를 나누는 상대방의 이름을 클릭하면 상대방이름의 웹소켓id 를 알아와서 input태그인 귓속말대상웹소켓.getId()에 입력하도록 하는 것. 
	        $(document).on("click", "span.loginuserName", function(){
	           	/* 
	           		span.loginuserName 은 
	               	com.spring.chatting.websockethandler.WebsocketEchoHandler 의 
	               	public void handleTextMessage(WebSocketSession wsession, TextMessage message) 메소드내에
	               	162번 라인에 기재해두었음.
	            */
	            const ws_id = $(this).prev().text();
	        //  alert(ws_id);
	        	// -> 
	            $("input#to").val(ws_id);
	            
	            $("span#privateWho").text($(this).text());
	            $("button#btnAllDialog").show();
	            $("input#message").css({'background-color':'black', 'color':'white'});
	            $("input#message").attr("placeholder","귀속말 메시지 내용");
	        
	            isOnlyOneDialog = true; // 귀속말 대화임을 지정
	            
	        });//end of on("click", "span.loginuserName")---------------------------
	        
	        
	     	// --- (2e) 귀속말대화끊기 버튼을 클릭한 경우에는 전체대상으로 채팅하겠다는 말이다.
	        $("button#btnAllDialog").click(function(){
	           
	           	$("input#to").val("");
	           	$("span#privateWho").text("");
	           	$("input#message").css({'background-color':'', 'color':''});
	           	$("input#message").attr("placeholder","메시지 내용");
	          	$(this).hide();
	           
	           isOnlyOneDialog = false; // 귀속말 대화가 아닌 모두에게 공개되는 대화임을 지정.
	           
	        });//end of btnAllDialog.click-------------------------------------------
	        
	    };//end of onmessage----------------------------------------
	 	
	});//end of ready()--------------------------------------


</script>

<%-- <div class="container-fluid">
<div class="row">
<div class="col-md-10 offset-md-1">
   	<div id="chatStatus" style="color:gray;"></div>
   	<div class="my-3">
	   	- 상대방의 대화내용이 검정색으로 보이면 채팅에 참여한 모두에게 보여지는 것입니다.<br>
	   	- 상대방의 대화내용이 <span style="color: red;">붉은색</span>으로 보이면 나에게만 보여지는 1:1 귓속말 입니다.<br>
	   	- 1:1 채팅(귓속말)을 하시려면 예를 들어, 채팅시 보이는 [이순신]대화내용 에서 이순신을 클릭하시면 됩니다.
   	</div>
   	<input type="text" id="to" placeholder="귓속말대상웹소켓.getId()"/>
   	<br/>
   	♡ 귓속말대상 : <span id="privateWho" style="font-weight: bold; color: red;"></span>
   	<br>
   	<button type="button" id="btnAllDialog" class="btn btn-secondary btn-sm">귀속말대화끊기</button>
   	<br><br>
   	현재접속자명단:<br/>
   	<div id="connectingUserList" style=" max-height: 100px; overFlow: auto;"></div>
   
   	<div id="chatMessage" style="max-height: 500px; overFlow: auto; margin: 20px 0;"></div>

   	<input type="text"   id="message" class="form-control" placeholder="메시지 내용"/>
   	<input type="button" id="btnSendMessage" class="btn btn-success btn-sm my-3" value="메시지보내기" />
   	<input type="button" class="btn btn-danger btn-sm my-3 mx-3" onclick="javascript:location.href='<%= ctxPath%>/challenge/main'" value="채팅방나가기" />
</div>
</div>
</div>
 --%>

<div class=" container-fluid my-5 mx-auto bg-white">
	<div class="row col-lg-10 col-md-10 col-sm-10 mx-auto my-5 py-5 justify-content-center">

			<div class="row clearfix">
			    <div class="col-lg-12">
			        <div class="card chat-app">
			            <div id="plist" class="people-list">
			                <!-- <div class="input-group">
			                    <div class="input-group-prepend">
			                        <span class="input-group-text"><i class="fa fa-search"></i></span>
			                    </div>
			                    <input type="text" class="form-control" placeholder="Search...">
			                </div> -->
			                <h3 class="mt-3">[Follow]</h3>
			                <ul class="list-unstyled chat-list mt-2 mb-0">
			                    <li class="clearfix">
			                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="avatar">
			                        <div class="about">
			                            <div class="name">Vincent Porter</div>
			                            <div class="status"> <i class="fa fa-circle offline"></i> left 7 mins ago </div>                                            
			                        </div>
			                    </li>
			                    <li class="clearfix active">
			                        <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="avatar">
			                        <div class="about">
			                            <div class="name">Aiden Chavez</div>
			                            <div class="status"> <i class="fa fa-circle online"></i> online </div>
			                        </div>
			                    </li>
			                    
			                    <li class="clearfix">
			                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png" alt="avatar">
			                        <div class="about">
			                            <div class="name">Dean Henry</div>
			                            <div class="status"> <i class="fa fa-circle offline"></i> offline since Oct 28 </div>
			                        </div>
			                    </li>
			                </ul>
			            </div>
			            <div class="chat">
			                <div class="chat-header clearfix">
			                    <div class="row">
			                        <div class="col-lg-6">
			                            <a href="javascript:void(0);" data-toggle="modal" data-target="#view_info">
			                                <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="avatar">
			                            </a>
			                            <div class="chat-about">
			                                <h6 class="m-b-0">Aiden Chavez</h6>
			                                <small>Last seen: 2 hours ago</small>
			                            </div>
			                        </div>
			                        <div class="col-lg-6 hidden-sm text-right">
			                            <a href="javascript:void(0);" class="btn btn-outline-secondary"><i class="fa fa-camera"></i></a>
			                            <a href="javascript:void(0);" class="btn btn-outline-primary"><i class="fa fa-image"></i></a>
			                            <a href="javascript:void(0);" class="btn btn-outline-info"><i class="fa fa-cogs"></i></a>
			                            <a href="javascript:void(0);" class="btn btn-outline-warning"><i class="fa fa-question"></i></a>
			                        </div>
			                    </div>
			                </div>
			                <div class="chat-history">
			                    <ul class="m-b-0">
			                        <li class="clearfix">
			                            <div class="message-data text-right">
			                                <span class="message-data-time">10:10 AM, Today</span>
			                                <img src="<%= ctxPath%>/images/기본프로필.png" /><!-- *여기는 지금 로그인 한 사람의 profile_pic 정보가 와야함!* -->
			                            </div>
			                            <div class="message other-message float-right"> Hi Aiden, how are you? How is the project coming along? </div>
			                        </li>
			                        <li class="clearfix">
			                            <div class="message-data">
			                                <span class="message-data-time">10:12 AM, Today</span>
			                            </div>
			                            <div class="message my-message">Are we meeting today?</div>                                    
			                        </li>                               
			                        <li class="clearfix">
			                            <div class="message-data">
			                                <span class="message-data-time">10:15 AM, Today</span>
			                            </div>
			                            <div class="message my-message">Project has been already finished and I have results to show you.</div>
			                        </li>
			                    </ul>
			                </div>
			                <div class="chat-message clearfix">
			                    <div class="input-group mb-0">
			                        <div class="input-group-prepend">
			                            <span class="input-group-text"><i class="fa fa-send"></i></span>
			                        </div>
			                        <input type="text" class="form-control" placeholder="Enter text here...">                                    
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>

	</div>
</div>


  
