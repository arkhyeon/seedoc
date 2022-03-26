<%@page import="member.model.service.MemberService"%>
<%@page import="member.model.vo.User"%>
<%@page import="hospital.model.vo.Hospital"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	User userLoggedIn = (User)session.getAttribute("userLoggedIn");
	Cookie[] cookies2 = request.getCookies();
	boolean saveUserIdChecked = false;
	String saveUserIdValue = "";
	if(cookies2 != null) {
		for(Cookie c : cookies2) {
			String k = c.getName();
			String v = c.getValue();

			if("saveUserId".equals(k)) {
				saveUserIdChecked = true;
				saveUserIdValue = v;
			}
		}
	}
	
	
	
	Hospital hospLoggedIn = (Hospital)session.getAttribute("hospLoggedIn");
	//쿠키관련
	Cookie[] cookies = request.getCookies();
	boolean saveHospIdChecked = false;
	String saveHospIdValue = "";
	if(cookies != null) {
		for(Cookie c : cookies) {
			String k = c.getName();
			String v = c.getValue();

			if("saveHospId".equals(k)) {
				saveHospIdChecked = true;
				saveHospIdValue = v;
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>See Doctor</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/header.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/footer.css" />
<script src="<%= request.getContextPath() %>/js/jquery-3.5.1.js"></script>
</head>
<body>
	<div class="top-bar">
        <header>
            <div class="logo">
                <a href="<%=request.getContextPath() %>"><img src="<%=request.getContextPath() %>/img/logo.png" alt=""></a>
            </div>
            <nav>
				
                <ul>
                <%if(hospLoggedIn == null && userLoggedIn == null) { %>
                    <a href="<%=request.getContextPath() %>">
                        <li style="color:white">홈</li>
                    </a>
                    <a href="<%=request.getContextPath()%>/member/login">
                        <li>로그인</li>
                    </a>
                    <a href="<%=request.getContextPath()%>/member/register">
                        <li>회원가입</li>
                    </a>
                    
                <% } else if(hospLoggedIn != null) { %>
                	<a href="<%=request.getContextPath()%>/hospital/hospital?hospId=<%= hospLoggedIn.getHospId() %>"><span class="login1"><strong><%= hospLoggedIn.getHospName() %></strong></span></a>
                	<a href="<%=request.getContextPath()%>/hospital/logout">
                		<li>로그아웃</li>
                	</a>
                    <a href="<%=request.getContextPath()%>/hospital/edit-info?hospId=<%= hospLoggedIn.getHospId() %>">
                        <li>병원정보수정</li>
                    </a>
                    <a href="<%=request.getContextPath()%>/hospital/doctorList?hospId=<%= hospLoggedIn.getHospId() %>">
                        <li>의사보기</li>
                    </a>
                    </a>
                    <!-- 2/15 -->
                    <a href="<%=request.getContextPath()%>/booking/bookingHopitalList?hospId=<%= hospLoggedIn.getHospId() %>"> <!-- ts -->
                        <li>예약내역(병원)</li>
                    </a>
                 <%}else if(userLoggedIn!=null&&userLoggedIn.getUserRole().equals(MemberService.MEMBER_ROLE_ADMIN)){ %>   
                    <span class="login1"><strong><%= userLoggedIn.getUserName()%></strong></span>
                	<a href="<%=request.getContextPath()%>/member/logout">
                		<li>로그아웃</li>
                	</a>
                    <a href="<%=request.getContextPath()%>/admin/memberList">
                        <li>회원조회</li>
                    </a>
                    <a href="<%=request.getContextPath()%>/admin/hospList">
                        <li>병원조회</li>
                    </a>
                    
                <% } else { %>
                	<span class="login1"><strong><%= userLoggedIn.getUserName()%></strong></span>
                	<a href="<%=request.getContextPath()%>/member/logout">
                		<li>로그아웃</li>
                	</a>
                    <a href="<%=request.getContextPath()%>/member/edit-info?userId=<%= userLoggedIn.getUserId()%>">
                        <li>회원정보수정</li>
                    </a>
                    <!-- 2/15 -->
                    <a href="<%=request.getContextPath()%>/booking/bookinglist?userId=<%= userLoggedIn.getUserId() %>"> <!-- ts -->
                        <li>예약내역</li>
                    </a>
                <% } %>
                </ul>
            </nav>
        </header>
    </div>
    <div class="sub-bar"></div>
