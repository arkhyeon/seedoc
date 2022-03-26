<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String msg = (String)request.getAttribute("msg");
	String loc = (String)request.getAttribute("loc");
	String script = (String)request.getAttribute("script");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>사용자 메세지</title>
</head>
<body>
<script>
	<%if(msg!=null) { %>
		alert('<%= msg %>');
	<% } %>
	<%=script !=null?script:""%>
	location.href = "<%= request.getContextPath()+loc%>";
	<%-- location.href = "<%= loc %>mvc"; --%>
	/* location.href = "/";==http://localhost:9090/ */
</script>
</body>
</html>