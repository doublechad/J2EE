<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="test">123</div>
	<form id="test"action="TestServletContextListener">
		<input type="button" value="click" onclick="AJAXtest()"/>
	</form>
</body>
<script src="http://code.jquery.com/jquery-3.3.1.js"
			  integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
			  crossorigin="anonymous"></script>
<script>
var cunt=0;
	function AJAXtest(){
		$.get("aa",function(data,status){
			if(status=='success'){
				$("#test").text("Data: " + data + "次數"+cunt);
				cunt++;
			//	AJAXtest();
			}
			});
  };
			
		
	
</script>
</html>