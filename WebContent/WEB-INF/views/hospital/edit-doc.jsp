<%@page import="hospital.model.vo.HospFile"%>
<%@page import="hospital.model.vo.HospDoctor"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	Hospital h = (Hospital)request.getAttribute("h");
	List<HospDoctor> list = (List<HospDoctor>)request.getAttribute("list");
	List<HospFile> hfList = (List<HospFile>)request.getAttribute("hospFileList");
	//System.out.println(hfList);
	String pageBar = (String)request.getAttribute("pageBar");
	HospDoctor editHd = (HospDoctor)request.getAttribute("hd"); //수정할 의사정보
%>
<link rel="stylesheet" href="../css/docList-view.css">
<section>
        <div class="bk-logo-wrap">
            <div class="hos-logo">
		        <% for(HospFile hf: hfList) { %>
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
        
        
        <h1 class="title"><span>●</span><%= h.getHospName() %> 의사수정하기</h1>
        <a href="<%=request.getContextPath()%>/hospital/doctorRegister?hospId=<%= h.getHospId() %>" class="add-doc">
        	의사등록
        </a>
	    <%if(list == null || list.isEmpty()) {%>
	    	<h1>조회된 의사가 없습니다.</h1>   
        <% }else {
        		for(HospDoctor hd : list) {
        			if(hd.getDoctorNo().equals(editHd.getDoctorNo())) {
        %>
				    <form action="<%= request.getContextPath() %>/hospital/doctorEdit" method="post" enctype="multipart/form-data">
				        <div class="bk-main-wrap">
				            <div class="doc-wrap">
				            	<p style="color: red; font-size: 12px;">*표시 항목은 필수 항목입니다.</p>
				            	<%if(!hfList.isEmpty()) { 
									for(HospFile hf : hfList) {
										if(hf.getDoctorNo()!=null && hf.getDoctorNo().equals(editHd.getDoctorNo())) {
											if(hf.getBoardOriginalFileName()!=null) {
				            				%>
							            	<div class="doc-img">
							            		<!-- 사진있을때 -->
							                    <img alt="의사이미지" src="<%=request.getContextPath() %>/upload/hospital/<%=hf.getBoardRenamedFileName() %>" width="200px"><br />
												<input type="file" name="upfile" width="100px"/><br />
												<input type="checkbox" name="delFile" id="delFile" value="사진삭제"/>
												<label for="delFile">사진삭제</label>
												<input type="hidden" name="oldOriginalFileName" value = "<%=hf.getBoardOriginalFileName()!= null ? hf.getBoardOriginalFileName():""%>" />
												<input type="hidden" name="oldRenamedFileName" value = "<%=hf.getBoardRenamedFileName()!= null ? hf.getBoardRenamedFileName():""%>" />
							                </div>
							                <% }else { //사진없을때%>
							                <div class="doc-img">
							                	<input type="file" name="upfile"/>
							                </div>
				                <% 			}
				               		 	} else if(hf.getBoardRenamedFileName() == null) { %>
				               		 	<%--
							            	<div class="doc-img">
												<input type="file" name="upfile"/>
												<input type="button" name="delFile" id="delFile" value="사진삭제"/><br />
												<input type="hidden" name="oldOriginalFileName" value = "<%=hf.getBoardOriginalFileName()!= null ? hf.getBoardOriginalFileName():""%>" />
												<input type="hidden" name="oldRenamedFileName" value = "<%=hf.getBoardRenamedFileName()!= null ? hf.getBoardRenamedFileName():""%>" />
							                </div> --%>
				                		
				                <% 		}
									}
				                } else { %>
				            	<div class="doc-img">
									<input type="file" name="upfile"/>
				                </div>
				                <% } %>
				                <div class="doc-info">
				                	<input type="hidden" id="hospId" name="hospId" value="<%= editHd.getHospId() %>" class="user-input"/>
				                	<label for="doctorNo" class="text-label">의사번호</label>
				                	<input type="text" id="doctorNo" name="doctorNo" value="<%= editHd.getDoctorNo() %>" class="user-input" readonly/><br />
				                	<label for="doctorName" class="text-label">의사이름<span style="color:red;">*</span></label>
				                	<input type="text" id="doctorName" name="doctorName" value="<%= editHd.getDoctorName() %>" class="user-input"/><br />
				                	<label class="text-label">진료과<span style="color:red;">*</span></label>
					                    <select name="hospDept" id="hospDept">
					                    	<option value="" <%= editHd.getHospDept()==null ? "selected":""%>>없음</option>
							        		<option value="내과" <%= "내과".equals(editHd.getHospDept()) ? "selected":""%>>내과</option>
							        		<option value="외과" <%= "외과".equals(editHd.getHospDept()) ? "selected":""%>>외과</option>
							        		<option value="안과" <%= "안과".equals(editHd.getHospDept()) ? "selected":""%>>안과</option>
							        		<option value="치과" <%= "치과".equals(editHd.getHospDept()) ? "selected":""%>>치과</option>
							        		<option value="피부과" <%= "피부과".equals(editHd.getHospDept()) ? "selected":""%>>피부과</option>
							        		<option value="정신과" <%= "정신과".equals(editHd.getHospDept()) ? "selected":""%>>정신과</option>
								        </select><br />
				                	<label for="doctorTreat" class="text-label">진료내용</label>
				                	<input type="text" id="doctorTreat" name="doctorTreat" class="user-input" value="<%= editHd.getDoctorTreat()==null ? "":editHd.getDoctorTreat() %>"/><br />
				                	<label for="doctorSpec" class="text-label">학력/전공</label>
				                	<input type="text" id="doctorSpec" name="doctorSpec" class="user-input" value="<%= editHd.getDoctorSpec()==null ? "":editHd.getDoctorSpec() %>"/><br />	
				                	<input type="submit" value="수정하기" class="submit-btn"/><br />
								</div>
							</div>
						</div>
					</form>
					<!-- 수정할 의사가 아닐 때 -->
                	<%} else { %>
				         <div class="bk-main-wrap">
				         	<div class="doc-wrap">
                	 <% if(!hfList.isEmpty()) { 
                		for(HospFile fl : hfList) {
 		            		if(fl.getDoctorNo() != null) {
                				if((fl.getDoctorNo()).equals(hd.getDoctorNo())) { 
                					if(fl.getBoardOriginalFileName()!=null) {//사진있을때%>
					                <div class="doc-img">
										<img alt="의사이미지" src="<%=request.getContextPath() %>/upload/hospital/<%=fl.getBoardRenamedFileName() %>" width="200px">
                					</div>
                					<%} else { //사진없을때 : 기본이미지%>
					                <div class="doc-img">
										<img alt="의사이미지" src="<%=request.getContextPath() %>/img/doctor.png" width="200px">
                					</div>
				<% 					}
								}	
							}
                		}
                	}%>
				            <%-- <div class="doc-wrap">
				                <div class="doc-img">
				                   <img alt="의사이미지" src="<%=request.getContextPath() %>/upload/hospital/<%=hfList.getBoardRenamedFileName() %>">
				                </div> --%>
				                <div class="doc-info">
				                    <h1><%= hd.getDoctorName() %>님</h1>
				                    <p> - 의사번호 : <%= hd.getDoctorNo() %></p>
				                    <p> - 진료과 : <%= hd.getHospDept() %></p>
				                    <p> - 진료내용 : <%= hd.getDoctorTreat()==null ? "":hd.getDoctorTreat()%></p>
				                    <p> - 학력/전공 :<%= hd.getDoctorSpec()==null ? "":hd.getDoctorSpec()%></p>
				                </div>
				            </div>
       					</div>
		<%			}
        		}
        	}%>
<div id='pageBar' style="color:black;">
		<%= pageBar %>
</div>
</section>
<script>
$(document).ready(function(){
	var fileTarget = $('.filebox .upload-hidden'); 
	fileTarget.on('change', function(){
		// 값이 변경되면 
		if(window.FileReader){ // modern browser 
			var filename = $(this)[0].files[0].name; } 
		else { // old IE 
			var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
			} 
		// 추출한 파일명 삽입 
		$(this).siblings('.upload-name1').val(filename);
		});
	});
var imgTarget = $('.up_Image .upload-hidden');
imgTarget.on('change', function(){ 
	var parent = $(this).parent(); 
	parent.children('.upload_display').remove(); 
	if(window.FileReader){ //image 파일만 
		if (!$(this)[0].files[0].type.match(/image\//)) return;
	var reader = new FileReader(); 
	reader.onload = function(e){ 
		var src = e.target.result; 
		parent.prepend('<div class="upload_display"><div class="upload_wrap"><img src="'+src+'"></div></div>'); 
		} 
		reader.readAsDataURL($(this)[0].files[0]); 
	} 
	else { 
		$(this)[0].select(); 
		$(this)[0].blur(); 
		var imgSrc = document.selection.createRange().text; 
		parent.prepend('<div class="upload_display"><div class="upload_wrap"><img ></div></div>'); 
		var img = $(this).siblings('.upload_display').find('img'); 
		img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")"; 
	} 
});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>