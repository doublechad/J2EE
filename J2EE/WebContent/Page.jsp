<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	
	 HttpSession ss = request.getSession(false);
     ss.getAttribute("member"); 
     String test =request.getHeader("test");
 	 String erro ="$(document).ready(function(){$('#loginModal').modal('show');});";
 	
 	
%>
	<!DOCTYPE html>	
<html>
	<head>
	<meta charset="UTF-8">
	<title>首頁</title>
	<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
	<style>
			.jumbotron{
				 margin-left: 5%;
				 margin-right: 5%;
				 background-size:cover;
				 background-image: url(picture/cover.jpg);
				 height: 250px;
			}
			.row{
				 margin-left: 5%;
				 margin-right: 5%;
			}
			#addMember{
				  }
		</style>	  
	</head>
	<body>
	
		<nav class="navbar navbar-default">
		  <div class="container-fluid">
		        <img alt="Brand" src="picture/Banner.jpg" height="30" width="30"style=" margin-top:5px;">
		  <c:if test="${sessionScope.member==null}">
			<div style=" padding-top:5px; float:right;">
		     	<button type="button" class="btn btn-default " data-toggle="modal" data-target="#loginModal">登入</button>
		    </div>
		    <div style=" padding-top:5px; float:right;">
		     	<button type="submit" class="btn btn-default" id ="addMember">加入會員</button>
		    </div>
		   </c:if>
		   <c:if test="${sessionScope.member!=null}">
		   	
		    <div style=" padding-top:5px; float:right;">
		     	<ul class="nav navbar-nav navbar-right" style=" float:right;">
		        <li class="dropdown">
		          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">選單<span class="caret"></span></a>
		          <ul class="dropdown-menu">
		            <li><a href="download.jsp">資料下載</a></li>
		            <li><a href="Modifymember.jsp">修改會員資料</a></li>
		            <li><a href="WebSocket.jsp">一起看盤吧</a></li>
		            <li role="separator" class="divider"></li>
		            <li><a href="logOut.jsp">登出</a></li>
		          </ul>
		        </li>
		      </ul>
		    </div>
		     
		    <div class=" nav navbar-nav" style=" padding-top:20px; float:right;">
		     	<c:out value="帳號:${sessionScope.member.account} 名稱:${sessionScope.member.realname}"></c:out>
		    </div>
		      
		   </c:if>
		  </div><!-- end of container-fluid -->
		</nav>
		
		<div class="jumbotron"> 
		</div><!-- end of jumbotron -->
		<div class="row">
  			<div class="col-sm-12 col-md-4" id="p1">
			    <div class="thumbnail">
			      <div class="caption">
			        <h3>123</h3>
			        <p>...</p>
			        <p><a href="#" class="btn btn-danger" role="button">立即購買</a> <a href="#" class="btn btn-default" role="button">詳細說明</a></p>
			      </div><!-- end of "caption"-->
			    </div><!-- end of "thumbnail"-->
 			 </div><!-- end of p1-->
 			 
 			 <div class="col-sm-12 col-md-4" id="p2">
			    <div class="thumbnail">
			      <div class="caption">
			        <h3>456</h3>
			        <p>...</p>
			        <p><a href="#" class="btn btn-success" role="button">立即購買</a> <a href="#" class="btn btn-default" role="button">詳細說明</a></p>
			      </div><!-- end of "caption"-->
			    </div><!-- end of "thumbnail"-->
 			 </div><!-- end of p2-->
 			 
 			 <div class="col-sm-12 col-md-4" id="p3">
			    <div class="thumbnail">
			      <div class="caption">
			        <h3>789</h3>
			        <p>...</p>
			        <p><a href="#" class="btn btn-primary" role="button">立即購買</a> <a href="#" class="btn btn-default" role="button">詳細說明</a></p>
			      </div><!-- end of "caption"-->
			    </div><!-- end of "thumbnail"-->
 			 </div><!-- end of p3-->
		</div>	<!-- end of row -->
		<div id="loginModal" class="modal" role="dialog"><!--Modal2-->
       	 	<div class="modal-dialog">   <!-- Modal content-->
           	 <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">close</button>
                <h4 class="modal-title" style="color:red;">
               <c:choose>
               		<c:when test='${param.erro=="0"}'>
               			<c:out value="密碼錯誤"></c:out> 
               		</c:when>
               		<c:when test='${param.erro=="1"}'>
               			<c:out value="帳號錯誤"></c:out> 
               		</c:when>
               		<c:otherwise></c:otherwise>
               </c:choose>
                
                </h4>
              </div>
              <div class="modal-body">
                <form id="loginMember" action="login.jsp" method="post" ><!--  onsubmit="return checkInput()"-->
                      <div class="form-group">
                          <label for="account">帳號</label>
                          <input type="text" name="account" id="account" class="form-control" value="${cookie.account.value}"  />
                      </div>
                      <div class="form-group">
                          <label for="password">密碼</label> <input type="password" name="password" id="password" class="form-control" />
                      </div>
                      <div style="float:left;">
              			<label for="remberUser">記住帳號</label>
              			<input type="checkbox" name="remberUser" id="remberUser" ${cookie.remberUser.value } />
              		 </div>
              		  <div style="float:right;">
              			<a href="reSendMail.jsp"  id="forgotPassword">忘記密碼?</a>
              		 </div>
                   </form>
              </div>
              <div class="modal-footer">
              	
                <button type="button" class="btn btn-default" data-dismiss="modal" id="login">登入</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
              </div>
            </div>
            </div>
            </div> <!-- end of Model2-->
	</body>
	<script src="http://code.jquery.com/jquery-3.3.1.js"
			  integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
			  crossorigin="anonymous"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
	
	 $("#addMember").click(function(){
		 javascript:location.href='addMember.jsp';
	  });
	 $("#login").click(function(){
		 $("#loginMember").submit();
	 });
	 $( "#loginMember" ).submit(function( event ) {
		 if($("#account").val()==""){
			 alert("帳號不可為空白");
				return false;
		 }else{
			 if($("#password").val()==""){
				 alert("密碼不可為空白");
				 return false;
			 }
			 $('#loginMember').on('hidden.bs.modal', function() {
				  return false;
				});
		 }
		});
	
	 
	 
	 <% if(request.getParameter("erro")!=null){
		 	out.println(erro);
	 }
	 %>
	
	
	 
/*	$("#login").click(function(){
		 var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() {
		    if (this.readyState == 4 && this.status == 200) {
		       $("#p1").append(this.responseText);
		    }
		  };
		  xhttp.open("POST", "login.jsp", true);
		  xhttp.send();
		    	
		})*/
	</script>
</html>