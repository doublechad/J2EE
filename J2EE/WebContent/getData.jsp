<%@page import="org.json.JSONArray"%>
<%@page import="com.mysql.fabric.xmlrpc.base.Array"%>
<%@page import="tw.chad.Img"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String start =request.getParameter("start");
	String rows =request.getParameter("rows");
	start =(start==null)?"0":start;
	rows = (rows==null)?"500":rows;
	Class.forName("com.mysql.jdbc.Driver");
	Properties prop =new Properties();
	prop.setProperty("user", "root");
	prop.setProperty("password", "root");
	Connection dataBase = DriverManager.getConnection("jdbc:mysql://127.0.0.1/fsit04", prop);
	String sql ="SELECT * FROM imgs ";
	PreparedStatement ps2 =dataBase.prepareStatement(sql);
	ResultSet rs2 =ps2.executeQuery();
	ArrayList<ArrayList<Img>> imgArray =new ArrayList();
	int cunt =0;
	while(rs2.next()){
		if(cunt !=rs2.getInt(2)){
			ArrayList a1 =new ArrayList();
			imgArray.add(a1);
			cunt=rs2.getInt(2);
			
		}
		Img img =new Img(rs2.getString("url"),rs2.getString("description"));
		imgArray.get(imgArray.size()-1).add(img);
	}
	
	/*HashMap<String,ArrayList<Img>> m1 =new HashMap();
	m1.put("imgs", imgArray.get(0));
	JSONObject obj1 = new JSONObject(m1);
	out.print(obj1);*/
	
	
	String sql1 ="SELECT * FROM attractions LIMIT "+start+","+rows;
	PreparedStatement ps =dataBase.prepareStatement(sql1);
	
	ResultSet rs =ps.executeQuery();
	JSONObject ob1 =new JSONObject();
	ArrayList<HashMap<String,Object>> list =new ArrayList<>();
	while(rs.next()){
		HashMap<String,Object> theRow =new HashMap();
		theRow.put("total_id", rs.getString("total_id"));
		theRow.put("CAT2",rs.getString("CAT2"));
		theRow.put("MEMO_TIME",rs.getString("MEMO_TIME"));
		theRow.put("stitle",rs.getString("stitle"));
		theRow.put("xbody",rs.getString("xbody"));
		theRow.put("address",rs.getString("address"));
		theRow.put("lat",rs.getString("lat"));
		theRow.put("lng",rs.getString("lng"));
		theRow.put("imgs",imgArray.get(rs.getInt(1)-1));
		list.add(theRow);
	}
	JSONArray answer =new JSONArray(list);
	out.print(answer);
%>