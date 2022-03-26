<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	User u = (User)request.getAttribute("u");
%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/search.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/emailjs-com@2.4.1/dist/email.min.js"></script>
<script type="text/javascript">
	(function() {
		emailjs.init('user_AceOdjgLGQvTWBiKJhhxr');
	})();
</script>
<script type="text/javascript">
	window.onload = function() {
		document.getElementById('contact-form').addEventListener(
				'submit',
				function(event) {
					event.preventDefault();
					// generate the contact number value
					this.contact_number.value = Math.random() * 100000 | 0;
					emailjs.sendForm('qkdwn47@gmail.com', 'template_GZWDvp9x',
							this);
				});
	}
</script>
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
			
			<form id="contact-form">
				<input type="hidden" name="contact_number"> <label>아이디</label>
				<input type="text" name="to_name" value="<%= u.getUserEmail() %>"> <label>이메일</label> <input
					type="email" name="from_name"> <label>Message</label>
				<textarea name="message_html"></textarea>
				<input type="submit" value="Send">
			</form>
			<button type="button" id="searchBtn"
				class="btn btn-outline-info btn sm" onclick="searchId()">비밀번호 찾기</button>
		</div>
	</article>
 </section>



<%@ include file="/WEB-INF/views/common/footer.jsp"%>