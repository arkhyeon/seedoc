<%@page import="member.model.vo.User"%>
<%@page import="booking.model.vo.BookingCount"%>
<%@page import="booking.model.vo.BookingAdd"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<User> member = (List<User>)request.getAttribute("member");
	List<User> searchId = (List<User>)request.getAttribute("searchId");
%>
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <link rel="stylesheet" href="../css/memberList.css">
<script>
 $(function(){
	$(".btn-delete").click(function () {
		status = $("#hidden").css("display");
		if (status == "none") { 
			$("#hidden").css("display", "");
		} else {
			$("#hidden").css("display", "none");
		}
	});
	
	$("#searchType").change(function(){
		$("#search-memberId, #search-memberName, #search-gender").hide();
		console.log($(this).val());//memberId -> #search-memberId
		$("#search-" + $(this).val()).css("display", "inline-block");
	});

	
});
 function deleteMember(){	
	 if(!confirm("정말 탈퇴하시겠습니까?")) return;
		
		$("[name=deleteUserFrm]").submit();
		
	
}
</script>
<section>
        <div class="res-wrap">
            <h1><span>●</span> 회원조회</h1>
	            <div class="res-card">
	            	<form action="" id="memberSetRows">
						<input type="hidden" name="memberRowPerPage" value="10">
					</form>
	            	<table class="tbl-member">
            			<tr>
            				<th>아이디</th>
            				<th>이름</th>
            				<th>이메일</th>
            				<th>전화번호</th>
            				<th>성별</th>
            				<th>생년월일</th>
            				<th>주소</th>
            				<th>증상</th>
            				<th>가입일</th>
            				<th>비고</th>
            			</tr>
            <% if(member == null || member.isEmpty()) {%>
            	<tr>
            		<td colspan="10"> <h3>조회된 회원이 없습니다.</h3></td>
            	</tr>
            <% } else { 
            	 for(User m : member) { %>
            	<tr class="row">
            		<td><%= m.getUserId() %></td>
            		<td><%= m.getUserName() %></td>
            		<td><%= m.getUserEmail() %></td>
            		<td><%= m.getUserPhone() %></td>
            		<td><%= m.getUserGender().equals("M")? '남':'여' %></td>
            		<td><%= m.getUserBirth() %></td>
            		<td><%= m.getUserAddr() %></td>
            		<td><%= m.getUserSymptom() %></td>
            		<td><%= m.getUserEndrollDate() %></td>
            		<td>
            			<input type="button" value="수정" onclick="location.href='<%= request.getContextPath() %>/member/edit-info?userId=<%= m.getUserId()%>'"/>
            			<form name="deleteUserFrm" action='<%=request.getContextPath() %>/admin/deleteMember' method='POST'>
		                    <input type="button" value="삭제" onclick="deleteMember()" />
							<input type="hidden" name="userId" value="<%= m.getUserId() %>"/>
						</form>
            		</td>
            	</tr>
            	<% } 
	         } %>
	            	</table>
	        </div>
	         <script src="<%=request.getContextPath()%>/js/memberPaging.js"></script>
		    <div id="search-container">
		검색타입 : 
		<select id="searchType">
			<option value="memberId">아이디</option>		
			<option value="memberName">회원명</option>
			<option value="gender">성별</option>
		</select>
		<div id="search-memberId">
			<form action="<%=request.getContextPath()%>/admin/memberFinder">
				<input type="hidden" name="searchType" value="memberId"/>
				<input type="search" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." />
				<button type="submit">검색</button>			
			</form>	
		</div>
		<div id="search-memberName">
			<form action="<%=request.getContextPath()%>/admin/memberFinder">
				<input type="hidden" name="searchType" value="memberName"/>
				<input type="search" name="searchKeyword" size="25" placeholder="검색할 이름을 입력하세요."/>
				<button type="submit">검색</button>			
			</form>	
		</div>
		<div id="search-gender">
			<form action="<%=request.getContextPath()%>/admin/memberFinder">
		    	<input type="hidden" name="searchType" value="gender"/>
				
				<input type="radio" name="searchKeyword" id="gender-M" value="M"> 
				<label for="gender-M">남</label>
		    	<input type="radio" name="searchKeyword" id="gender-F" value="F">
				<label for="gender-F">여</label>
				
		    	<button type="submit">검색</button>
		    </form>
		</div>
	</div>
    </div>
    </section>
    <%@ include file="/WEB-INF/views/common/footer.jsp"%>