<%@page import="tw.chad.m1"%>
<%@page import="com.mysql.fabric.xmlrpc.base.Member"%>
<%@page import="tw.chad.CheckMember"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Properties"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	
	if(request.getParameter("remberUser")!=null){
		Cookie account =new Cookie("account",request.getParameter("account"));
		Cookie remberUser =new Cookie("remberUser","checked");
		response.addCookie(account);
		response.addCookie(remberUser);
	}else{
		  Cookie account=new Cookie("account",null);      //删除Cookie
		  Cookie remberUser =new Cookie("remberUser",null);
		  account.setMaxAge(0);
		  remberUser.setMaxAge(0);
		  response.addCookie(account);     
		  response.addCookie(remberUser);
	}
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Properties prop =new Properties();
		prop.setProperty("user", "root");
		prop.setProperty("password", "root");
		Connection dataBase = DriverManager.getConnection("jdbc:mysql://127.0.0.1/stock", prop);
		String sql = "SELECT * FROM member WHERE account=?";
		PreparedStatement prestmt = dataBase.prepareStatement(sql);
		prestmt.setString(1, request.getParameter("account"));
		ResultSet rs=prestmt.executeQuery();
		if(rs.next()){
			if(rs.getString("verification").equals("ok")){
				if(CheckMember.checkPasswd(request.getParameter("password"), rs.getString("password"))){
					session = request.getSession();
					session.setAttribute("member", new m1(rs.getString("account"),rs.getString("realname"),rs.getString("id")));
					response.sendRedirect("/J2EE/Page.jsp");
					
				}else{
					//out.print("密碼錯誤");
					response.sendRedirect("/J2EE/Page.jsp?erro=0");
				}
			}else{
				out.println("請先驗證信箱，2秒後自動轉向回首頁....");
				String content=2+";URL="+"/J2EE/Page.jsp"; 
				response.setHeader("REFRESH",content); 
			}
		}else{
			//out.print("帳號有誤");
			response.sendRedirect("/J2EE/Page.jsp?erro=1");
			
		}
	}catch(Exception e){
		out.print(e.toString());
	}
%>
