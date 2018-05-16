<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
    <%
    	if(request.getParameter("error")!=null){
    		pageContext.setAttribute("error", "密碼錯誤");
    	};
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>修改會員資料</title>
		<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
	</head>
	<body>
	${error }
		<c:if test="${sessionScope.member.account==null }">
			<c:out value="請" /><a href='Page.jsp'>點此</a>登入<br />
		</c:if>	
		<c:if test="${sessionScope.member.account!=null }">
			<sql:setDataSource var="jstlsql" driver="com.mysql.jdbc.Driver" 
								url = "jdbc:mysql://127.0.0.1/stock"
		         					user = "root"  password = "root"/>
		    <sql:query dataSource = "${jstlsql}" var = "result">
		         SELECT * from member WHERE account =?
		         <sql:param>${sessionScope.member.account }</sql:param>
		     </sql:query>
		     <c:forEach var="row" items="${result.rows}">
		      	<c:set var="id" value="${row.id }"></c:set>
		      	<c:set var="account" value="${row.account }"></c:set>
		      	<c:set var="realname" value="${row.realname }"></c:set>
		      	<c:set var="email" value="${row.email }"></c:set>
		      </c:forEach>
		     <div style="margin-top:5%">
	<img id ="userAvatar" height="10%" width="10%" src="/upload/default.jpg"></img>
	<div id ="data" class="col-sm-12 col-md-4" style="margin-left: 33%">
			<form role="form" action="updateMember.jsp" method="POST" id="memberForm" enctype="multipart/form-data" onsubmit="return dataCheck();">
				<div class="form-group">
					<label for="account" style="float:left">帳號 :</label>
					<div id="account"></div>
					<div id="checkArea" style="color:red;"></div>
				</div>
				<div class="form-group">
					<input type="text" class="form-control" name="hideaccount" id="hideaccount" placeholder="" maxlength="10">
				</div>
				<div class="form-group">
					<label for="password" style="float:left">舊密碼 :</label>
					<input type="password" class="form-control" name="password" id="password" placeholder="密碼 "maxlength="12">
				</div>
				<div class="form-group">
					<label for="confirmPassword" style="float:left">新密碼 :</label>
					<input type="password" class="form-control" name="newPassword" id="newPassword" placeholder="確認密碼"maxlength="12">
					<div id="confirm" style="color:red;"></div>
				</div>
				<div class="form-group">
					<label for="confirmPassword" style="float:left">確認密碼 :</label>
					<input type="password" class="form-control" name="confirmPassword" id="confirmPassword" placeholder="確認密碼"maxlength="12">
					<div id="confirm" style="color:red;"></div>
				</div>
				<div class="form-group">
					<label for="realname" style="float:left">姓名 :</label>
					<input type="text" class="form-control" name="realname" id="realname" placeholder="姓名"maxlength="10">
				</div>
				<div class="form-group">
					<label for="email" style="float:left">電子郵件 :</label>
					<div id="email"></div>
				</div>
				<div class="radio">
				     性別:
					<label><input type="radio" name="gender" value="male" />男</label>
					<label><input type="radio" name="gender" value="female" />女</label>
				</div>
				<div >
				<input type="file" id="avatar" name="avatar" accept="image/gif, image/jpeg, image/png" style="float: right;" />
				<button type="submit" class="btn btn-default"id="submit" style="float: left;">確認修改</button>
				
				</div>
			</form>	
		</div>
</div>
	      </c:if>	
	    
	</body>
	<script src="http://code.jquery.com/jquery-3.3.1.js"
			  integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
			  crossorigin="anonymous"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript">
	
	var foo=['${account}','${realname}','${email}','${id}'];
	function data(){
		$("#account").html(foo[0]);
		$("#hideaccount").val(foo[0]);
		$("#realname").val(foo[1]);
		$("#email").html(foo[2]);
	}
	$( document ).ready(data());//WebContent/upload/user5.jpg
	$("#userAvatar").attr('src', 'upload/user${id}.jpg');
	
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
		function dataCheck(){
			if($("#newPassword").val()!=$("#confirmPassword").val()){
				alert("密碼不同請確認");
				return false;
			}else{
				
				if($("#newPassword").val()==""||$("#realname").val()==""){
					alert("密碼,姓名未填寫")
					return false;
				}else{
					var y =$("#newPassword").val().match(/[^a-z^A-Z^0-9]/);
					if(!y){
						return true;
					}else{
					alert("請使用英文或數字")
					return false;
					}
				}
				
			}
		}
	</script>
</html>