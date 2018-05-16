<%@tag import="java.util.HashMap"%>
<%@ tag dynamic-attributes="product"%>
<%@ attribute name="user"  required="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	
	HashMap<String,String> ps =(HashMap<String,String>)jspContext.getAttribute("product");
	//if(ps.containsKey("name")){
	out.print("<table>");
	out.print("<tr>");
	out.println("<td>"+ps.get("name")+"</td>");
	//}
	out.println("<td>"+ps.get("price")+"</td>");
	
	jspContext.setAttribute("xxx", ps.get("xxx"));
//	jspContext.setAttribute("price", ps.get("price"));
	request.setAttribute("price", ps.get("price"));
	out.print("</table>");
%>
<%@ variable name-given="xxx"  %>	
<c:set var="xxx" value="${xxx+price }"></c:set>
<jsp:doBody />
<!-- 給一個變數名稱 -->



