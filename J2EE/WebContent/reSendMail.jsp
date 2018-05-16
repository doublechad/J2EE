<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.Properties"%>
<%@page import="tw.chad.Sendmail"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
pageContext.setAttribute("msg", "重新發送驗證信");
if(request.getParameter("account")!=null&&request.getParameter("email")!=null){
	Class.forName("com.mysql.jdbc.Driver");
	Properties prop =new Properties();
	prop.setProperty("user", "root");
	prop.setProperty("password", "root");
	Connection dataBase = DriverManager.getConnection("jdbc:mysql://127.0.0.1/stock", prop);
	String sql="SELECT * FROM member WHERE account=? AND email=?";
	String sql2="UPDATE member SET vcode=? WHERE account=?;";
	PreparedStatement prstat = dataBase.prepareStatement(sql);
	PreparedStatement prstat2 = dataBase.prepareStatement(sql2);
	prstat.setString(1, request.getParameter("account"));
	prstat.setString(2, request.getParameter("email"));
	ResultSet rs = prstat.executeQuery();
	if(rs.next()){
		String vcode = Sendmail.createText();
		prstat2.setString(1, vcode);
		prstat2.setString(2, request.getParameter("account"));
		int foo =prstat2.executeUpdate();
		if(foo==1){
			Sendmail.cofirmMail(request.getParameter("email"), "a="+request.getParameter("account")+"&vcode="+vcode);
			pageContext.setAttribute("msg", "發送成功請至註冊信箱收取驗證信登入，二秒後導回首頁");
			String content=2+";URL="+"Page.jsp"; 
			response.setHeader("REFRESH",content);
		}else{
			pageContext.setAttribute("msg", "發送失敗請重新操作或聯絡客服人員");
		}
		
	}else{
		
		pageContext.setAttribute("msg", "請確認帳號與註冊信箱");
		}
}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>重新發送驗證信</title>
		<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
	</head>
	<body>
			<h style="font-size:24px; color:red;">
			<c:out value="${msg }" />
			</h>
		<div id ="data">
			<form role="form"  method="post" id="memberForm" onsubmit="return dataCheck();">
				<div class="form-group">
					<label for="account">帳號</label>
					<input type="text" class="form-control" name="account" id="account" placeholder="帳號"maxlength="12" />
					<div id="checkArea" style="color:red;"></div>
				</div>
				<div class="form-group">
					<label for="email">電子郵件</label>
					<input type="text" class="form-control" name="email" id="email" placeholder="電子郵件"maxlength="50">
				</div>
				<button type="submit" class="btn btn-default"id="submit">重新發送驗證碼</button>
			</form>	
	</body>
	
	<script src="http://code.jquery.com/jquery-3.3.1.js"
			  integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
			  crossorigin="anonymous"></script>
	<script src="js/bootstrap.min.js"></script>
</html>