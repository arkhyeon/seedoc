<%@page import="member.model.vo.User"%>
<%@page import="booking.model.vo.BookingCount"%>
<%@page import="booking.model.vo.BookingAdd"%>
<%@page import="booking.model.vo.Booking"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% List<BookingAdd> list = (List<BookingAdd>)request.getAttribute("list"); 
	BookingCount bc = (BookingCount)request.getAttribute("bc");
	User user = (User)request.getAttribute("user");
//	System.out.print("jsp"+user);
%>
<%--     <%@ include file="/WEB-INF/views/common/header.jsp"%> --%>
    <link rel="stylesheet" href="../css/myBooking.css">
<script>


</script>
<section>
	<div class="profile-wrap">
         <div class="profile">
             <img src="img/person1.png" alt="">
             <h1><%= user.getUserName() %>님</h1>
             <p><%= user.getUserId() %></p>
         </div>
         <ul class="res-result">
             <li>
                 <img src="<%= request.getContextPath() %>/img/mypage-1.png" alt="">
                 <p>전체</p>
                 <h1><%= bc.getTotal() %></h1>
             </li>
             <li>
                 <img src="<%= request.getContextPath() %>/img/mypage-2.png" alt="">
                 <p>이용예정</p>
                 <h1><%= bc.getApproval() %></h1>
             </li>
             <li>
                 <img src="<%= request.getContextPath() %>/img/mypage-3.png" alt="">
                 <p>이용완료</p>
                 <h1><%= bc.getFinish() %></h1>
             </li>
             <li>
                 <img src="<%= request.getContextPath() %>/img/mypage-4.png" alt="">
                 <p>취소</p>
                 <h1><%= bc.getCancle() %></h1>
             </li>
         </ul>
     </div>
     <div class="res-wrap">
         <h1><span>●</span> 내 예약 <a href="<%= request.getContextPath() %>/booking/bookinglist?userId=<%= user.getUserId() %>"><span class="plus">더보기→</span></a></h1>
         <% if(list == null || list.isEmpty()) {%>
            	<div class="res-card" style="text-align:center">
            		<h3>조회된 예약이 없습니다.</h3>
            	</div>
            <% } else { %>
            	<% for(BookingAdd b : list) { %>
	            <div class="res-card">
	                <div class="res-type">
	                    <img src="../img/mypage-3.png" alt="">
	                    <p><%= "A".equals(b.getBookingState())?"이용예정":"F".equals(b.getBookingState())?"이용완료":"취소" %></p>
	                    </div>
	                <div class="res-main">
	                    <p class="res-no">No.<%=b.getBookingNo() %></p>
	                    <h1><%= b.getHospName() %> - <%= b.getDocName() %> 의사</h1>
	                    <p>일정 : <%= b.getBookingDate() %> <%= b.getBookingTime() %></p>
	                    <p>진료 : <%= b.getHospDept() %></p>
	                    <% if((b.getBookingState() != null && "C".equals(b.getBookingState()))
	                    		&& b.getBookingCancel() != null) {%>
	                    <p>취소사유: <%=b.getBookingCancel() %></p>
	                    <% } %>
	                </div>
	            </div>
	            
	            <% } %>
            <% } %>
     </div>
    </section>
    <%-- <%@ include file="/WEB-INF/views/common/footer.jsp"%> --%>