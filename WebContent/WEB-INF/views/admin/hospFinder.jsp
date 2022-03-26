<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<Hospital> list = (List<Hospital>)request.getAttribute("list");
	String searchType = request.getParameter("searchType");
	String searchKeyword = request.getParameter("searchKeyword");
%> 
    <%@ include file="/WEB-INF/views/common/header.jsp"%>
    <link rel="stylesheet" href="../css/memberList.css">
<script>
 $(function(){
	$("#searchType").change(function(){
		$("#search-hospId, #search-hospName, #search-hospAddr").hide();
		console.log($(this).val());//memberId -> #search-memberId
		$("#search-" + $(this).val()).css("display", "inline-block");
	});

	
});
 
 function deleteMember(){	
	 if(!confirm("정말 탈퇴하시겠습니까?")) return;
		
		$("[name=deleteHospFrm]").submit();
		
	
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
            				<th>주소</th>
            				<th>전화번호</th>
            				<th>정보</th>
            				<th>편의시설</th>
            				<th>가입일</th>
            				<th>비고</th>
            			</tr>
            <% if(list == null || list.isEmpty()) {%>
            	<tr>
            		<td colspan="8"> <h3>조회된 회원이 없습니다.</h3></td>
            	</tr>
            <% } else { 
            	for(Hospital l : list) { %>
            	<tr class="row">
            		<td><%= l.getHospId() %></td>
            		<td><%= l.getHospName() %></td>
            		<td><%= l.getHospAddr() %></td>
            		<td><%= l.getHospTel() %></td>
            		<td><%= l.getHospInfo() %></td>
            		<td><%= l.getHospConv() %></td>
            		<td><%= l.getHospEnrollDate() %></td>
            		<td>
            			<input type="button" value="수정" onclick="location.href='<%= request.getContextPath() %>/hospital/edit-info?hospId=<%= l.getHospId()%>'"/>
            			<form name="deleteHospFrm" action='<%=request.getContextPath() %>/admin/deleteHosp' method='POST'>
		                    <input type="button" value="삭제" onclick="deleteMember()" />
							<input type="hidden" name="hospId" value="<%= l.getHospId() %>"/>
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
			<option value="hospId" <%= "memberId".equals(searchType) ? "selected" : "" %>>아이디</option>		
			<option value="hospName" <%= "memberName".equals(searchType) ? "selected" : "" %>>회원명</option>
			<option value="hospAddr" <%= "hospAddr".equals(searchType) ? "selected" : "" %>>주소</option>
		</select>
		<div id="search-hospId">
			<form action="<%=request.getContextPath()%>/admin/hospFinder">
				<input type="hidden" name="searchType" value="hospId"/>
				<input type="search" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요." 
					   value="<%= "hospId".equals(searchType) ? searchKeyword : "" %>"/>
				<button type="submit">검색</button>			
			</form>	
		</div>
		<div id="search-hospName">
			<form action="<%=request.getContextPath()%>/admin/hospFinder">
				<input type="hidden" name="searchType" value="hospName"/>
				<input type="search" name="searchKeyword" size="25" placeholder="검색할 이름을 입력하세요."
					   value="<%= "hospName".equals(searchType) ? searchKeyword : "" %>"/>
				<button type="submit">검색</button>			
			</form>	
		</div>
		<div id="search-hospAddr">
			<form action="<%=request.getContextPath()%>/admin/hospFinder">
				<input type="hidden" name="searchType" value="hospAddr"/>
				<input type="search" name="searchKeyword" size="25" placeholder="검색할 이름을 입력하세요."
					   value="<%= "hospAddr".equals(searchType) ? searchKeyword : "" %>"/>
				<button type="submit">검색</button>			
			</form>	
		</div>
	</div>
    </div>
    </section>
    <%@ include file="/WEB-INF/views/common/footer.jsp"%>