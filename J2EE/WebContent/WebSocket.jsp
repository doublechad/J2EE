<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	if(session.getAttribute("member")==null){
		response.sendRedirect("Page.jsp");
	}
%>
<html>
    <head>
        <title>聊天室</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
        <style type="text/css">
        		#userAvatar{
        		
        		float:right;height:10%; width:10%;
        			}
        		#foo{
        		margin-left: 15%;margin-right:15%;
        		}
      			#input{
		        	width:95%;
		        	margin-right: 0px;
	        	}
	        	#sumbit{
	        		float: right;
	        		margin-left: 0px;
	        		margin-right: 0px;
	        	}
	        	#textArea{
		        	height:800px;
		        	overflow-y:auto;
		        	background-color: #D6D5B7; 
		        	width: 90%;
		        	float: left;
	        	}
	        	#userInput{
					width:90%
				}
        
        	@media screen and (max-width:640px){
	        	#userAvatar{
	        	height:0%; width:0%;
	        	display:none;
	        	}
        		#foo{
        		position:relative;
        		margin-left: 0%;margin-right:0%;
        		height:90vh;
        		}
				#input{width:85%;}
				#submit{
					float: right;
					width:10%;}
				#userInput{
					width:100%
				}
				#textArea{
				background-color: #D6D5B7;
				height: 85vh;overflow-y:auto;
				width: 100%;float: left;
				}
			}
        
        </style>
    </head>
    <body >
    	
    	
    	<div id ="foo" style="">
	    	<div>
				<img  id="userAvatar" src="upload/user${sessionScope.member.id}.jpg" />
			</div>
	    	
	    	
	    	
		    <div id="textArea" > 
		   
			</div><!-- end of textArea -->
			<div id="userInput">
				<input type="text" id="input" />
				<input type="button" id="sumbit" value="發送"  onclick="send()" />
			</div>
	
			
		</div>
		  
    </body>
    <script src="http://code.jquery.com/jquery-3.3.1.js"
			  integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
			  crossorigin="anonymous"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
	
		window.onload=setWebSocket;
		var url='ws://36.234.3.180:8080/J2EE/WebSocketTest';
		var textArea=document.getElementById("textArea");
		var userinput = document.getElementById("input");
		var isConnectSuccess=false;
		
		function send(){
			 if (webSocket && isConnectSuccess) {
		            var messageInfo = {
		                userName: '${sessionScope.member.realname}',
		                message: userinput.value
		            }
		            webSocket.send(JSON.stringify(messageInfo));
		        } else {
		        	textArea.innerHTML = "未登入";
		        }
			 textArea.innerHTML +="<div style='font-size:14px;float:right'>"+userinput.value+"</div></br>"
			 textArea.scrollTop = textArea.scrollHeight; //自動捲向下
			 $("#input").val("");
		}
		
		function setWebSocket() {
			url+=('?name=${sessionScope.member.realname }');
			//開始WebSocket連線   'ws://36.233.1.193:8080/J2EE/WebSocketTest'
		        webSocket = new WebSocket(url);
		        //以下開始偵測WebSocket的各種事件
		       
		        webSocket.onerror = function (event) {  //onerror , 連線錯誤時觸發  
		        	isConnectSuccess=false;
		        	textArea.innerHTML = "登入失敗";
		        };
		 
		        //onopen , 連線成功時觸發
		        webSocket.onopen = function (event) {
		        	isConnectSuccess=true;
		            console.log(webSocket.readyState);
		            //infoWindow.innerHTML = "登入成功";
		        };
		      //onmessage , 接收到來自Server的訊息時觸發
		        webSocket.onmessage = function (event) {
		        	console.log(webSocket.readyState);
		            var messageObject = JSON.parse(event.data);
		            if(messageObject.TEST=='error'){
		            	textArea.innerHTML="重複登入"
		            	document.location.href="Page.jsp"
		             }else{
		            	if(messageObject.TEST=='ok'){
		            		textArea.innerHTML="<div>成功登入</div>"
		            	}else{
		            		if(messageObject.userName=="系統"){
		            			textArea.innerHTML += "<p style='font-size:16px; color:gray;'>"+ messageObject.userName + " 說 : " + messageObject.message+"</p><br />";
		            		}else{
		            			textArea.innerHTML += "<p style='font-size:14px;'>"+ messageObject.userName + " 說 : " + messageObject.message+"</p><br />";
		            		}
		            		textArea.scrollTop = textArea.scrollHeight; //自動捲向下
		            	}
		            }
		        };
		    }
	</script>
 <!--    <script>
    window.onload = function () {
    //獲取DOM元件
    var loginBtn = document.getElementById("loginBtn");
    var userNameInput = document.getElementById("userNameInput");
    var infoWindow = document.getElementById("infoWindow");
    var userinput = document.getElementById("userinput");
    var chatRoomForm = document.getElementById("chatRoomForm");
    var messageDisplay = document.getElementById("messageDisplay");
    var webSocket;
    var isConnectSuccess = false;
    var url ='ws://localhost:8080/J2EE/WebSocketTest';
 
    //設置登入鈕的動作，沒有登出，登入才可發言
    loginBtn.addEventListener("click", function () {
        //檢查有無輸入名稱
        if (userNameInput.value && userNameInput.value !== "") {
        	url+=('?name='+userNameInput.value);
            setWebSocket();  //設置WebSocket連接
        } else {
            infoWindow.innerHTML = "請輸入名稱";
        }
 	
    });
    //Submit Form時送出訊息
    chatRoomForm.addEventListener("submit", function () {
        sendMessage();
        return false;
    });
    //使用webSocket擁有的function, send(), 送出訊息
    function sendMessage() {
        //檢查WebSocket連接狀態
        if (webSocket && isConnectSuccess) {
            var messageInfo = {
                userName: userNameInput.value,
                message: userinput.value
            }
            webSocket.send(JSON.stringify(messageInfo));
        } else {
            infoWindow.innerHTML = "未登入";
        }
    }
 
    //設置WebSocket
    function setWebSocket() {
        //開始WebSocket連線   'ws://localhost:8080/J2EE/WebSocketTest'
        webSocket = new WebSocket(url);
        //以下開始偵測WebSocket的各種事件
         
        //onerror , 連線錯誤時觸發  
        webSocket.onerror = function (event) {
            loginBtn.disabled = false;
            userNameInput.disabled = false;
            infoWindow.innerHTML = "登入失敗";
        };
 
        //onopen , 連線成功時觸發
        webSocket.onopen = function (event) {
            isConnectSuccess = true;
            loginBtn.disabled = true;
            userNameInput.disabled = true;
            console.log(webSocket.readyState);
            //infoWindow.innerHTML = "登入成功";
             
            //送一個登入聊天室的訊息
            var firstLoginInfo = {
                userName : "系統",
                message : userNameInput.value + " 登入了聊天室"+"<br />"
            };
            webSocket.send(JSON.stringify(firstLoginInfo));
        };
 
        //onmessage , 接收到來自Server的訊息時觸發
        webSocket.onmessage = function (event) {
        	console.log(webSocket.readyState);
            var messageObject = JSON.parse(event.data);
            if(messageObject.TEST=='TEST'){
            	messageDisplay.innerHTML="重複登入"
             }else{
           	 	messageDisplay.innerHTML += " "+ messageObject.userName + " 說 : " + messageObject.message+"<br />";
            }
        };
    }
};
</script> -->
</html>