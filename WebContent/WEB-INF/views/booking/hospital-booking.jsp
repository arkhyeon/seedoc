<%@page import="booking.model.vo.BookingCount"%>
<%@page import="booking.model.vo.BookingAdd"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%  
	List<BookingAdd> list = (List<BookingAdd>)request.getAttribute("list"); 
	BookingCount bc = (BookingCount)request.getAttribute("bc");
	String pageBar = (String)request.getAttribute("pageBar");
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
	System.out.println(searchType);
%>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <link rel="stylesheet" href="../css/hospital-booking.css">
<style>
	div#search-container {margin:20px 0 0px 0; padding:10px; background-color: white; width:100%;}
	div#search-doctorName {<%= searchType==null ||"doctorName".equals(searchType) ? "display: inline-block;" : "display:none"%>}
	div#search-userName{<%= "userName".equals(searchType) ? "display: inline-block;" : "display:none"%>}
	div#search-schedule{<%= "schedule".equals(searchType) ? "display: inline-block;" : "display:none"%>}
</style>
<script>
 $(function(){
	$("#btn-total").click(function() {
		let $frm = $("[name=bookingStateFrm]");
		$frm.children("[name=state]").val("_");
		$frm.submit();
	});
	$("#btn-approval").click(function() {
		let $frm = $("[name=bookingStateFrm]");
		$frm.children("[name=state]").val("A");
		$frm.submit();
	});
	$("#btn-finish").click(function() {
		let $frm = $("[name=bookingStateFrm]");
		$frm.children("[name=state]").val("F");
		$frm.submit();
	});
	$("#btn-cancle").click(function() {
		let $frm = $("[name=bookingStateFrm]");
		$frm.children("[name=state]").val("C");
		$frm.submit();
	});
	/* 7/15 변경 */
	$(".btn-delete").click(function () {
		let $tableTr = $(this).parent().parent().next();
		//console.log($tableTr);		
		status = $("#hidden").css("display");
		if (status == "none") { 
			$($tableTr).css("display", "");
		} else {
			$($tableTr).css("display", "none");
		}
	});
	
	$("#searchType").change(function() {
		$("#search-doctorName, #search-userName, #search-schedule").hide();
		$("#search-" + $(this).val()).css("display","inline-block");
	});

	
});
	 <% for(BookingAdd b : list) {%>
	function updateBooking<%=b.getBookingNo() %>(){
		if(confirm("예약을 변경하시겠습니까?")){
			let $deleteFrm = $("[name=updateBookingFrm<%=b.getBookingNo() %>]");
			$deleteFrm.attr("action", "<%= request.getContextPath() %>/booking/updateBookingFrm");
			$deleteFrm.submit();
		}else {
			return;
		}
	}
	/* 7/15 추가 */
	function completeBooking<%=b.getBookingNo() %>(){
		if(confirm("회원이 병원 이용을 완료하셨습니까??")){
			let $deleteFrm = $("[name=completeBookingFrm<%=b.getBookingNo() %>]");
			$deleteFrm.attr("action", "<%= request.getContextPath() %>/booking/completeBooking");
			$deleteFrm.submit();
		}else {
			return;
		}
	}
	<% } %>
</script>
<section>
        <div class="profile-wrap">
            <div class="profile">
                <img src="../img/person1.png" alt="">
                <h1><%= hospLoggedIn != null? hospLoggedIn.getHospName():"" %></h1>
                <p><%= hospLoggedIn != null? hospLoggedIn.getHospId():"" %></p>
            </div>
            <ul class="res-result">
                <li id="btn-total">
                    <img src="../img/mypage-1.png" alt="">
                    <p>전체</p>
                    <h1><%= bc.getTotal() %></h1>
                </li>
                <li id="btn-approval">
                    <img src="../img/mypage-2.png" alt="" >
                    <p>이용예정</p>
                    <h1><%= bc.getApproval() %></h1>
                </li>
                <li id="btn-finish">
                    <img src="../img/mypage-3.png" alt="">
                    <p>이용완료</p>
                    <h1><%= bc.getFinish() %></h1>
                </li>
                <li id="btn-cancle">
                    <img src="../img/mypage-4.png" alt="">
                    <p>취소</p>
                    <h1><%= bc.getCancle() %></h1>
                </li>
                <form action="<%= request.getContextPath() %>/booking/bookingHopitalList" 
                		name="bookingStateFrm" method="get" >
                	<input type="hidden" name="state" />
                	<input type="hidden" name="hospId" value="<%= hospLoggedIn != null ? hospLoggedIn.getHospId() : "" %>" />
                </form>
            </ul>
        </div>
        <div class="res-wrap">
            <h1><span>●</span> 병원 예약 List</h1>
	            <div class="res-card">
	            	<table class="tbl-booking">
            			<tr>
            				<th>예약번호</th>
            				<th>의사이름</th>
            				<th>진료과</th>
            				<th>환자이름</th>
            				<th>예약날짜</th>
            				<th>예약시간</th>
            				<th>예약상태</th>
            				<th>비고</th>
            			</tr>
            <% if(list == null || list.isEmpty()) {%>
            	<tr>
            		<td colspan="8"> <h3>조회된 예약이 없습니다.</h3></th>
            	</tr>
            <% } else { %>
            	<% for(BookingAdd b : list) { %>
            	<tr>
            		<td><%= b.getBookingNo() != null ? b.getBookingNo() : "" %></td>
            		<td><%= b.getDocName() != null ? b.getDocName() : "" %></td>
            		<td><%= b.getHospDept() != null ? b.getHospDept() : "" %></td>
            		<td><%= b.getUserName() != null ? b.getUserName() : "" %></td>
            		<td><%= b.getBookingDate() != null ? b.getBookingDate() : "" %></td>
            		<td><%= b.getBookingTime() != null ? b.getBookingTime() : "" %></td>
            		<td><%= b.getBookingState() != null && "A".equals(b.getBookingState())? "이용예정" : 
            			b.getBookingState() != null && "F".equals(b.getBookingState())? "이용완료" :
            			b.getBookingState() != null && "C".equals(b.getBookingState())? "예약취소" : ""%>
            		</td>
            		<td>
            			 <% if(userLoggedIn != null && "A".equals(userLoggedIn.getUserRole())) { %>
            			<input type="button" value="수정" onclick="updateBooking<%=b.getBookingNo() %>();"/>
            			<% } %>
            			<% if(b.getBookingState() != null && "A".equals(b.getBookingState())) { %>
            			<input type="button" value="완료" onclick="completeBooking<%=b.getBookingNo() %>();"/>
	                    <input type="button" value="삭제" class="btn-delete" />
	                    <% } %>
            		</td>
            	</tr>
            	<tr id="hidden" style="display:none;">
            		<td colspan="8" >
		            	<!-- 예약 수정 폼 -->
		                <form name="updateBookingFrm<%=b.getBookingNo() %>" method="post">
		                	<input type="hidden" name="bookingNo" value="<%=b.getBookingNo() %>"/>
		                	<input type="hidden" name="hospId" value="<%=b.getHospId() %>"/>
		                	<input type="hidden" name="userId" value="<%=b.getUserId() %>"/>
		                </form>
		                <!-- 7/15 추가 -->
		            	<!-- 예약 이용완료 폼 -->
		                <form name="completeBookingFrm<%=b.getBookingNo() %>" method="post">
		                	<input type="hidden" name="bookingNo" value="<%=b.getBookingNo() %>"/>
		                	<input type="hidden" name="bookingState" value="F"/>
		                	<input type="hidden" name="hospId" value="<%= b.getHospId() %>"/>
		                </form>
		                <!-- 예약 삭제 폼 -->
		                <form name="deleteBookingFrm<%=b.getBookingNo() %>" action="<%= request.getContextPath() %>/booking/deleteHospBooking" method="post">
		                	<input type="hidden" name="bookingNo" value="<%=b.getBookingNo() %>"/>
		                	<input type="hidden" name="bookingState" value="C"/>
		                	<textarea name='bookingCancle' placeholder='취소사유를 적어주세요' cols=100 rows=2></textarea>
		                	<input type="hidden" name="hospId" value="<%= b.getHospId() %>"/>
		                	<button type='submit' class='btn-insert2'>삭제</button>
		                </form>
            		</td>
            	</tr>
            	<% } %>
	        <% } %>	
	            	</table>
	        </div>

            <div class="paging">
                <%= pageBar %>
            </div>
		    <div id="search-container">
			검색타입 : 
			<select id="searchType">
				<option value="doctorName"<%= "doctorName".equals(searchType) ? "selected" : ""%>>의사이름</option>		
				<option value="userName"<%= "userName".equals(searchType) ? "selected" : ""%>>회원이름</option>
				<option value="schedule"<%= "schedule".equals(searchType) ? "selected" : ""%>>일자</option>
			</select>
			<div id="search-doctorName">
				<form action="<%=request.getContextPath()%>/booking/bookingFinder">
					<input type="hidden" name="searchType" value="doctorName"/>
					<input type="hidden" name="hospId" value="<%= hospLoggedIn!=null?hospLoggedIn.getHospId():"" %>"/>
					<input type="search" name="searchKeyword"  size="25" placeholder="검색할 의사 이름을 입력하세요." 
						value=<%= "doctorName".equals(searchType) ? searchKeyword : ""%>>
					<button type="submit">검색</button>			
				</form>	
			</div>
			<div id="search-userName">
				<form action="<%=request.getContextPath()%>/booking/bookingFinder">
					<input type="hidden" name="searchType" value="userName"/>
					<input type="hidden" name="hospId" value="<%= hospLoggedIn!=null?hospLoggedIn.getHospId():"" %>"/>
					<input type="search" name="searchKeyword" size="25" placeholder="검색할 환자 이름을 입력하세요."
						value=<%= "userName".equals(searchType) ? searchKeyword : ""%>>
					<button type="submit">검색</button>			
				</form>	
			</div>
			<div id="search-schedule">
				<form action="<%=request.getContextPath()%>/booking/bookingFinder">
			    	<input type="hidden" name="searchType" value="schedule"/>
			    	<input type="hidden" name="hospId" value="<%= hospLoggedIn!=null?hospLoggedIn.getHospId():"" %>"/>
					<input type="date" name="searchKeyword" size="25" 
						value=<%= "schedule".equals(searchType) ? searchKeyword : ""%>>
			    	<button type="submit">검색</button>
			    </form>
			</div>
		</div>
    </div>
    </section>
    <%@ include file="/WEB-INF/views/common/footer.jsp"%>