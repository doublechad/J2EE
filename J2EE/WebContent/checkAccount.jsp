<%@page import="tw.chad.CheckMember"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html; charset=utf-8");
	String account =request.getParameter("account");
	
	if(CheckMember.checkAccount(account)){
		if(!account.equals(""))
		out.print("");
	}else{
		out.print("帳號重複");
	}
%>
