<%@page import="java.util.HashMap"%>
<%@page import="tw.chad.CheckMember"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	if(request.getMethod().equals("POST")){
		String mail =request.getParameter("mail");
		String password =request.getParameter("password");
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Properties prop =new Properties();
			prop.setProperty("user", "root");
			prop.setProperty("password", "root");
			Connection dataBase = DriverManager.getConnection("jdbc:mysql://127.0.0.1/fsit04", prop);
			String sql = "SELECT * FROM user WHERE mail=?";
			PreparedStatement prestmt = dataBase.prepareStatement(sql);
			prestmt.setString(1, mail);
			ResultSet rs=prestmt.executeQuery();
			if(rs.next()){
				if(CheckMember.checkPasswd(password, rs.getString("password"))){
					 String rs_id = rs.getString("id");
					 String rs_mail = rs.getString("mail");
					 String rs_name = rs.getString("name");
					 HashMap<String,String> m1 =new HashMap();
					 m1.put("id", rs_id);
					 m1.put("mail", rs_mail);
					 m1.put("name", rs_name);
					 out.print(m1.toString());
					
				}else{
					out.print("密碼錯誤");
					
				}
			}else{
				out.print("帳號或密碼有誤");
			
				
			}
		}catch(Exception e){
			out.print(e.toString());
		}
	}else{
		out.print("not post");
	}
	
%>