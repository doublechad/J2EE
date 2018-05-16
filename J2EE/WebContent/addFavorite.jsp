<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%		
	if(request.getMethod().equals("POST")){
		String user_id =request.getParameter("user_id");
		String total_id =request.getParameter("total_ids");	
		
		if(user_id!=null&&total_id!=null){
			
			try{
				Class.forName("com.mysql.jdbc.Driver");
				Properties prop =new Properties();
				prop.setProperty("user", "root");
				prop.setProperty("password", "root");
				Connection dataBase = DriverManager.getConnection("jdbc:mysql://127.0.0.1/fsit04", prop);//user_favorite
				
				
				String sql = "INSERT INTO user_favorite (user_id,total_id) VALUES (?,?)";
				PreparedStatement prestmt = dataBase.prepareStatement(sql);
				prestmt.setString(1, user_id);
				prestmt.setString(2, total_id);
				prestmt.addBatch();
					
				
				int sss =prestmt.executeUpdate();
				out.print(sss +"rows ok");	
			}catch(Exception e){
				out.print(e.toString());
			}
			
		}else{
			out.print("null");
		}
	}else{
		out.print("not post");
	}	
		

%>