<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/search.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
h3 {
	background-color: #4286f4;
	color: white;
	height: 60px;
	line-height: 60px;
	font-size: 24px;
}
</style>
<section> 
	<article>
		
		<div id="div1">
			<h3>비밀번호 찾기</h3>
		<form action="<%= request.getContextPath() %>/member/SearchPwdServlet" 
                		name="checkFrm" method="POST" >
                	<input type="text" name="userId" value=""/>
                	<input type="text" name="userEmail" value=""/>
                	<input id="btn" type="submit" value="확인" />
                </form>
                
			
			
		</div>
	</article>
 </section>



<%@ include file="/WEB-INF/views/common/footer.jsp"%>