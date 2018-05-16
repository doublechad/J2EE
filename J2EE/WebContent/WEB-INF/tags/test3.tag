<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="x" required="true"%>
<%@ attribute name="y" required="true"%>

<%@ variable name-given="add"  %>					
<%@ variable name-given="sub"%>					
<%@ variable name-given="multiply"%>
<%@ variable name-given="divide"%>

<c:if test="${x>y }">			
<c:set var="add" value="${x+y }"></c:set>			
<c:set var="sub" value="${x-y }"></c:set>
<c:set var="multiply" value="${x*y }"></c:set>
<c:set var="divide" value="${x/y }"></c:set>
</c:if>	
<jsp:doBody />
