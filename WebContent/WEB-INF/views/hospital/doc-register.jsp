<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	String hospId = request.getParameter("hospId");
	//System.out.println(hospId);
%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/doc-register.css" >
<script>	
</script>
<section>
        <article>
            <div class="register">
                <h1 id="title">의사등록</h1>
				<p style="color: red; font-size: 12px;">*표시 항목은 필수 항목입니다.</p>
                <form action="<%=request.getContextPath() %>/hospital/doctorRegister" name="docEnrollFrm" method="post" enctype="multipart/form-data">
                	<div class="member">
	                    <input type="hidden" class="user-input check-input" name="hospId" id="hospId" value="<%= hospId %>">
	                    <fieldset>
	                    <legend class="text-label">의사사진</legend>
	                    <input type="file" name="upFile">
	                    </fieldset>
	                    <label class="text-label">의사번호<span>*</span></label>
	                    <input type="text" class="user-input" name="doctorNo" id="doctorNo">
	                    
	                    <label class="text-label">의사이름<span>*</span></label>
	                    <input type="text" class="user-input" name="doctorName" id="doctorName">
	
	                    <label class="text-label">진료과<span>*</span></label>
	                    <select name="hospDept" id="hospDept">
	                    	<option value="">없음</option>
			        		<option value="내과">내과</option>
			        		<option value="외과">외과</option>
			        		<option value="안과">안과</option>
			        		<option value="치과">치과</option>
			        		<option value="피부과">피부과</option>
			        		<option value="정신과">정신과</option>
				        </select>
	
	                    <label class="text-label">진료내용</label>
	                    <input type="text" class="user-input" name="doctorTreat" id="doctorTreat">
	                    
	                    <label class="text-label">학력/전공</label>
	                    <input type="text" class="user-input" name="doctorSpec" id="doctorSpec">
	                    <input type="submit" value="등록" class="submit-btn" />
	                    <input type="button" value="취소" class="submit-btn" onclick="javascript:history.go(-1);" />
                    </div>
                </form>
                <form action=""></form>
                </div>
            </div>
        </article>
    </section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>