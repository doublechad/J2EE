<%@page import="tw.chad.m1"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>

<%@page import="java.sql.DriverManager"%>

<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  try{
	request.getParameter("vcode");
	Class.forName("com.mysql.jdbc.Driver");
	Properties prop =new Properties();
	prop.setProperty("user", "root");
	prop.setProperty("password", "root");
	Connection dataBase = DriverManager.getConnection("jdbc:mysql://127.0.0.1/stock", prop);
	String sql = "SELECT * FROM member WHERE account=?";
	String sql2="UPDATE member SET vcode='0',verification='ok' WHERE account=?;";
	//PreparedStatement prestmt = dataBase.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	PreparedStatement prestmt = dataBase.prepareStatement(sql);
	PreparedStatement prestmt2 = dataBase.prepareStatement(sql2);
	prestmt.setString(1, request.getParameter("a"));
	prestmt2.setString(1, request.getParameter("a"));
	ResultSet rs=prestmt.executeQuery();
	if(rs.next()){
		String foo =rs.getString("vcode");
		if(foo.equals((String)request.getParameter("vcode"))&&!rs.getString("verification").equals("ok")){
			prestmt2.executeUpdate();
			session = request.getSession();
			session.setAttribute("member", new m1(rs.getString("account"),rs.getString("realname"),rs.getString("id")));
			String text ="驗證成功，2秒後自動轉向回首頁....";
			out.println(text);
			String content=2+";URL="+"Page.jsp"; 
			response.setHeader("REFRESH",content);
		}else{
			if(foo.equals((String)request.getParameter("vcode"))&&rs.getString("verification").equals("ok")){
				session = request.getSession();
				session.setAttribute("member", new m1(rs.getString("account"),rs.getString("realname"),rs.getString("id")));
				response.sendRedirect("Page.jsp");
			}else{
			String text ="驗證失敗，請<a href='reSendMail.jsp'>點此<a>重新發送驗證信....";
			out.println(text);
			}
		}
	}else{
		response.sendRedirect("Page.jsp");
	}
}catch(Exception e){
	System.out.println(e.toString());
}
%>