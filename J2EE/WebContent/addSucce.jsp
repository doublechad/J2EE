<%@page import="tw.chad.Sendmail"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String text ="註冊成功，2秒後自動轉向回首頁....";
	String content=2+";URL="+"Page.jsp"; 
	response.setHeader("REFRESH",content); 
%>
<%=text %>
</body>
</html>