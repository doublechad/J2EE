<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	if(session.getAttribute("member")!=null){
		response.sendRedirect("Page.jsp");
	}
 	String stat = request.getParameter("stat");
	int a=1;
	try{
	a = Integer.parseInt(stat);
	}catch(Exception e){
		
	}
	String lable =(a==0)?"帳號重複":"加入會員";
	String color =(a==0)?"color:red;":"color:black;";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>加入會員</title>
		<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
		<style type="text/css">
		#data{
			margin-left: 5%;
			margin-right: 5%;
			width: 50%;
		}
		</style>
	</head>
	<body>
		<img id ="userAvatar" height="10%" width="10%" src="upload/default.jpg" ></img>
		<div id ="data" class="col-sm-12 col-md-4" style="margin-left: 20%;">
			<h style="font-size:24px; <%=color %>"><%=lable %></h>
			<form role="form" action="sighup" method="post" id="memberForm" enctype="multipart/form-data"
				onsubmit="return dataCheck();">
				<div class="form-group">
					<label for="account">帳號</label>
					<input type="text" class="form-control" name="account" id="account" placeholder="帳號"maxlength="12" />
					<div id="checkArea" style="color:red;"></div>
				</div>
				<div class="form-group">
					<label for="password">密碼</label>
					<input type="password" class="form-control" name="password" id="password" placeholder="密碼 "maxlength="12">
				</div>
				<div class="form-group">
					<label for="confirmPassword">確認密碼</label>
					<input type="password" class="form-control" name="confirmPassword" id="confirmPassword" placeholder="確認密碼"maxlength="12">
					<div id="confirm" style="color:red;"></div>
				</div>
				<div class="form-group">
					<label for="realname">姓名</label>
					<input type="text" class="form-control" name="realname" id="realname" placeholder="姓名"maxlength="10">
				</div>
				<div class="form-group">
					<label for="email">電子郵件</label>
					<input type="text" class="form-control" name="email" id="email" placeholder="電子郵件"maxlength="50">
				</div>
				<div class="radio">
				     性別:
					<label><input type="radio" name="gender" value="male" />男</label>
					<label><input type="radio" name="gender" value="female" />女</label>
				</div>
				<input type="file" id="avatar" name="avatar" accept="image/gif, image/jpeg, image/png" style="float: right;" />
				<button type="submit" class="btn btn-default"id="submit">註冊</button>
			</form>	
		</div>	<!-- end of  data-->
	
	</body>
	<script src="http://code.jquery.com/jquery-3.3.1.js"
			  integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
			  crossorigin="anonymous"></script>
	<script>
	function readURL(input) {
		if (input.files && input.files[0]) {
		    var reader = new FileReader();
			reader.onload = function(e) {
		      $('#userAvatar').attr('src', e.target.result);
		    }
			reader.readAsDataURL(input.files[0]);
		  }
		}

		$("#avatar").change(function() {
		  readURL(this);
		});
	$("#account").on("change",function(){
		accountCheck();
	});
	$("#confirmPassword").on("change",function(){
		confirmPassword();
	})
	function accountCheck(){
		var account = $("#account").val();
		var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() {
		    if (this.readyState == 4 && this.status == 200) {
		       $("#checkArea").text(this.responseText);
		    }
		  };
		  xhttp.open("POST", "checkAccount.jsp", true);
		  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		  xhttp.send("account="+account);
	}
	function confirmPassword(){
		if($("#password").val()!=$("#confirmPassword").val()){
			$("#confirm").html("密碼不同請確認");
		}
	}
	function dataCheck(){
		if($("#password").val()!=$("#confirmPassword").val()){
			alert("請重新確認密碼");
			return false;
		}else{
			if($("#account").val()==""||$("#password").val()==""||$("#realname").val()==""){
				alert("帳號,密碼,姓名未填寫")
				return false;
			}else{
				var x=$("#account").val().match(/[^a-z^A-Z^0-9]/);
				var y =$("#password").val().match(/[^a-z^A-Z^0-9]/);
				if(!y&&!x){
					return true;
				}else{
				alert("請使用英文數字混和")
				return false;
				}
			}
			
		}
	}
	</script>
</html>