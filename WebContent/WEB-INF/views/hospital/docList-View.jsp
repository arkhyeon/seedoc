<%@page import="hospital.model.vo.HospFile"%>
<%@page import="hospital.model.vo.HospDoctor"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	Hospital h = (Hospital)request.getAttribute("h");
	List<HospFile> fileList = (List<HospFile>)request.getAttribute("hospFileList");
	List<HospDoctor> list = (List<HospDoctor>)request.getAttribute("list");
	String pageBar = (String)request.getAttribute("pageBar");
%>
<script>
function fileDownload(oname, rname) {
	let url = "<%=request.getContextPath()%>/board/fileDownload";
	//한글을 %문자(유니코드)로 변경
	oname = encodeURIComponent(oname); //한글이 주소에 들어가면 IE에서 오류남 --> 인코딩처리
	console.log(oname);
	location.href = url+"?oname="+oname+"&rname="+rname;
}

</script>
<link rel="stylesheet" href="../css/docList-view.css">
<section>
        <div class="bk-logo-wrap">
        	<div class="hos-logo">
            <% for(HospFile hf: fileList) { %>
        		<% if("logo".equals(hf.getUse()) && hf.getBoardOriginalFileName()!=null){ %>
        			<img src="<%=request.getContextPath() %>/upload/hospital/<%=hf.getBoardRenamedFileName() %>" alt="">
	        	<% } else if("logo".equals(hf.getUse()) && hf.getBoardOriginalFileName()==null){ %>
	        		<p style="font-size: 39px; margin-top: 100px; font-weight: 800; color: white;position: relative; z-index: 1;"><%=h.getHospName() %></p>
        		<% } %>
        		<% if("thumbnail".equals(hf.getUse()) && hf.getBoardOriginalFileName()!=null){ %>
        			<img src="<%=request.getContextPath() %>/upload/hospital/<%=hf.getBoardRenamedFileName() %>" alt="">
	        	<% } else if("thumbnail".equals(hf.getUse()) && hf.getBoardOriginalFileName()==null){ %>
	        		<p style="font-size: 26px; margin-top: 100px; font-weight: 800; color: white;position: relative; z-index: 1;">메인 이미지를 등록해주세요.</p>
        		<% } %>
        	<% } %>
       		</div>
            <div class="opa-back"></div>
        </div>
        <h1 class="title"><span>●</span><%= h.getHospName() %> 의사리스트보기</h1>
        <a href="<%=request.getContextPath()%>/hospital/doctorRegister?hospId=<%= h.getHospId() %>" class="add-doc">
        	의사추가
        </a>
        <div class="clear"></div>
	    <%if(list == null || list.isEmpty()) {%>
	    	<h1>조회된 의사가 없습니다.</h1>   
        <% }else { 
        		for(HospDoctor hd : list) {
        %>
        <div class="bk-main-wrap">
            <div class="doc-wrap">
                <% if(!fileList.isEmpty()) { 
                		for(HospFile fl : fileList) {
 		            		if(fl.getDoctorNo() != null) {
                				if((fl.getDoctorNo()).equals(hd.getDoctorNo())) { 
                					if(fl.getBoardOriginalFileName() != null) { 
                				%>
					                <div class="doc-img">
										<img alt="의사이미지" src="<%=request.getContextPath() %>/upload/hospital/<%=fl.getBoardRenamedFileName() %>">
                					</div>
                					<%}else { %>
					                <div class="doc-img">
										<img alt="의사이미지" src="<%=request.getContextPath() %>/img/doctor.png">
                					</div>
                	<%				}
				 				}	
							} 
 		            	}
                	} %>
                	
                <div class="doc-info">
                    <h1><%=hd.getDoctorName() %>님</h1>
                    <p> - 의사번호 : <%= hd.getDoctorNo() %></p>
                    <p> - 진료과 : <%= hd.getHospDept() %></p>
                    <p> - 진료내용 : <%= hd.getDoctorTreat()==null ? "":hd.getDoctorTreat()%></p>
                    <p> - 학력/전공 : <%= hd.getDoctorSpec()==null ? "":hd.getDoctorSpec()%></p>
                    <button onclick="location.href='<%=request.getContextPath()%>/hospital/doctorEdit?hospId=<%=hd.getHospId() %>&doctorNo=<%= hd.getDoctorNo() %>'">
                    	수정하기</button>
                    <button onclick="deleteDoc<%=hd.getDoctorNo()%>();">삭제하기</button>
                  	<script>
	                  	function deleteDoc<%=hd.getDoctorNo()%>() {
	                  		if(!confirm('이 의사정보를 삭제하시겠습니까?')) return;
	                  		else
	                  			location.href='<%=request.getContextPath()%>/hospital/doctorDelete?hospId=<%=hd.getHospId() %>&doctorNo=<%= hd.getDoctorNo() %>';
	                  	}
                  	</script>
                </div>
            </div>
       </div>
       <% 		}
        	}%>
<div id='pageBar' style="color:black;">
	<%= pageBar %>
</div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>