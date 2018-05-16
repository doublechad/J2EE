<%@page import="tw.chad.RegistrationTest"%>
<%@page import="tw.chad.WebAPI"%>
<%@page import="tw.chad.m1"%>
<%@page import="tw.chad.CheckMember"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%  request.setCharacterEncoding("UTF-8");
	String account =request.getParameter("hideaccount");
	String password =request.getParameter("password");
	String newPassword =request.getParameter("newPassword");
	String realname =request.getParameter("realname");
	Class.forName("com.mysql.jdbc.Driver");
	Properties prop =new Properties();
	prop.setProperty("user", "root");
	prop.setProperty("password", "root");
	Connection dataBase = DriverManager.getConnection("jdbc:mysql://127.0.0.1/stock", prop);
	String sql1 ="SELECT * FROM member WHERE account=?";
	PreparedStatement ps =dataBase.prepareStatement(sql1);
	ps.setString(1,account);
	ResultSet rs =ps.executeQuery();
	rs.next();
	if(rs.getString("verification").equals("ok")){
		if(CheckMember.checkPasswd(request.getParameter("password"), rs.getString("password"))){
			WebAPI.uppdateMember(newPassword, realname, account);
			session = request.getSession();
			session.setAttribute("member", new m1(account,realname,rs.getString("id")));
			response.sendRedirect("http://localhost:8080/J2EE/Page.jsp");
		}else{
			//out.print("密碼錯誤");
			response.sendRedirect("http://localhost:8080/J2EE/Modifymember.jsp?error=0");
		}
	}else{
		out.println("請先驗證信箱，2秒後自動轉向回首頁....");
		String content=2+";URL="+"http://localhost:8080/J2EE/Page.jsp"; 
		response.setHeader("REFRESH",content); 
	}
	Part part=request.getPart("avatar");
	String upload_path =request.getServletContext().getInitParameter("upload-path");
	File uploadFile =new File(upload_path,"user"+rs.getString("id")+".jpg");
	InputStream in =part.getInputStream();
	byte[] temp =in.readAllBytes();
	in.close();
	if(temp.length>0){
		FileOutputStream ot = new FileOutputStream(uploadFile);
		ot.write(temp);
		ot.flush();
		ot.close();
	}


%>
