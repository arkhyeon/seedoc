<%@page import="member.model.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/search2.css">
<%
  request.setCharacterEncoding("utf-8");
  User user = (User)request.getAttribute("user");
%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" Contenet="text/html; charset="UTF-8">

</head>

<body>
<section>
        <article>
		<div class="wrap">
		<h1><div id="userName">[<%=user.getUserName() %>] 님의 아이디</div></h1>
		<h1><div id="userId">[<%=user.getUserId() %>] 입니다</div></h1>
		<button id="button" class="btn" onclick="location.href='<%= request.getContextPath() %>/member/login'">로그인 하러가기</button>		
		</div>	
</article>
</section>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>
</body>
</html>