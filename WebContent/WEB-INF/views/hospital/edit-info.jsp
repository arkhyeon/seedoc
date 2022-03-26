<%@page import="hospital.model.vo.HospFile"%>
<%@page import="hospital.model.vo.HospTime"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%
	Hospital h = (Hospital)request.getAttribute("h");
	HospTime ht = (HospTime)request.getAttribute("ht");
	List<HospFile> hospFileList = (List<HospFile>)request.getAttribute("hospFileList");
	String hospInfo = h.getHospInfo() != null ? h.getHospInfo() : "";
	//System.out.println(hospFileList.isEmpty());
	//String hospConv = hospLoggedIn.getHospConv();
	//List<String> convList = null;
	//if(hospConv != null) {
	//	String[] convArr = hospConv.split(",");
	//	convList = Arrays.asList(convArr);
	//}
//	System.out.println("convList = "+convList);
%>
<link rel="stylesheet" href="../css/edit-info.css">
<script>
$(function() {
	$("#hospPwdCheck").keyup(function () {
		//console.log("실행");
		let $pwd1 = $("#hospPwd");
		let $pwd2 = $("#hospPwdCheck");
	    
	    if($pwd1.val() == $pwd2.val()){
	        $('#p-pwdCheck').css('opacity', '0');
	        return true;
	    }
	    else{
	        $('#p-pwdCheck').css('opacity', '1');
	        return false;
	    }
	});
	$("[name=hospitalUpdateFrm]").submit(function() {
		//비밀번호검사
		let $pwd1 = $("#hospPwd");
		let $pwd2 = $("#hospPwdCheck");
		if($pwd1.val() !== $pwd2.val()) {
			$('#p-pwdCheck').css('opacity', '1');
			$pwd1.focus();
			return false;
		}
		
		return true;
	});
});
function deleteHospital() {
	if(!confirm("정말 탈퇴하시겠습니까?")) return;
	
	$("[name=deleteHospitalFrm]").submit();
}
function openPopup() {
	//팝업생성
	let url = "<%= request.getContextPath() %>/jusoPopup";
	let title = "jusoPopup";
	let spec = "left=300px, top=300px, width=600px, height=500px";
	open(url, title, spec);

}
function jusoCallBack(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,detBdNmList,bdNm,bdKdcd,siNm,sggNm,emdNm,liNm,rn,udrtYn,buldMnnm,buldSlno,mtYn,lnbrMnnm,lnbrSlno,emdNo){

    // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	//console.log(roadFullAddr);
	$("#hospAddr").val(roadFullAddr); // 도로명주소

	//document.form.addrDetail.value = addrDetail; // 상세주소

	//document.form.zipNo.value = zipNo; // 우편번호

	self.close();

}
</script>
<section>
        <article>
            <div class="register">
                <h1 id="title">병원정보수정</h1>
                <form action="<%=request.getContextPath() %>/hospital/deleteHospital" name="deleteHospitalFrm" method="POST">
				<input type="hidden" name="hospId" value="<%=h.getHospId() %>" />
				</form>
                	<form action="<%=request.getContextPath() %>/hospital/edit-info" name="hospitalUpdateFrm" method="post" enctype="multipart/form-data">
                			<p style="color: red; font-size: 12px;">*표시 항목은 필수 항목입니다.</p>
		                    <input type="hidden" class="user-input check-input" name="hospId" id="hospId" value="<%= h.getHospId()%>" readonly>
		                    <label class="text-label">비밀번호<span>*</span></label>
		                    <input type="password" class="user-input" name="hospPwd" id="hospPwd" required>
		                    <input type="password" placeholder="비밀번호 확인" class="user-input" name="hospPwdCheck" id="hospPwdCheck" required>
		                    <p id="p-pwdCheck" style="color:red; font-size:12px; opacity:0;">비밀번호가 일치하지 않습니다.</p>
		
		                    <label class="text-label">병원이름<span>*</span></label>
		                    <input type="text" class="user-input" name="hospName" id="hospName" value="<%= h.getHospName() %>" required>
		
		                    <label class="text-label">병원전화번호 ('-'포함)<span>*</span></label>
		                    <input type="text" class="user-input" name="hospTel" id="hospTel" value="<%= h.getHospTel() %>" required>
		
		                    <label class="text-label">주소<span>*</span></label>
		                    <input type="text" class="user-input check-input" name="hospAddr" id="hospAddr" value="<%= h.getHospAddr() %>" required>
		                    <div class="check-btn" onclick="openPopup();">우편번호 검색</div>
			                    <input type="text" class="user-input" placeholder="우편번호 주소">
			                    <input type="text" class="user-input" placeholder="상세주소">
		                    <label class="text-label" >병원소개글</label>
		                    <textarea name="hospInfo" id="hospInfo" class="user-input" cols="30" rows="30" style="padding:9px 9px; resize: none; height: 100px;"><%= hospInfo %></textarea>
		                    
		                    <fieldset>
		                    <legend class="text-label">병원사진</legend>
		                    <% if(!hospFileList.isEmpty()) {
		                    		int a=1;
		                    		for(HospFile fl : hospFileList) {
		                    			if("logo".equals(fl.getUse())) {
		                    %>
										<label for="">로고사진</label>
										<%=fl.getBoardOriginalFileName()==null ? "":fl.getBoardOriginalFileName() %> <br />
	                    				<input type="file" name="upFile<%=a++%>" style="width:200px;">
	                    				<input type="checkbox" name="delFile1" id="delFile1" value="사진삭제"/>
	                    				<label for="delFile1">사진삭제</label><br />
	                    				<input type="hidden" name="oldOriginalFileName1" value = "<%= fl.getBoardOriginalFileName()==null ? "":fl.getBoardOriginalFileName()%>" />
										<input type="hidden" name="oldRenamedFileName1" value = "<%=fl.getBoardRenamedFileName()==null ? "":fl.getBoardRenamedFileName() %>" />
							<%   		} else if("thumbnail".equals(fl.getUse())) {%>
										<label for="">대표이미지</label>
										<%=fl.getBoardOriginalFileName()==null ? "":fl.getBoardOriginalFileName() %><br />
	                    				<input type="file" name="upFile<%=a++%>" style="width:200px;">
	                    				<input type="checkbox" name="delFile2" id="delFile2" value="사진삭제"/>
	                    				<label for="delFile2">사진삭제</label><br />
	                    				<input type="hidden" name="oldOriginalFileName2" value = "<%=fl.getBoardOriginalFileName()==null ? "":fl.getBoardOriginalFileName()%>" />
										<input type="hidden" name="oldRenamedFileName2" value = "<%=fl.getBoardRenamedFileName()==null ? "":fl.getBoardRenamedFileName() %>" />
		                    <%			} else { %>
		                    			<div class="filebox">
											<label for="">로고사진</label><br />
						                    <input type="file" name="upFile1" id="up_file" class="upload-hidden" style="width:200px;">
											<label for="">대표이미지</label><br />
					                    	<input type="file" name="upFile2" id="up_file2" class="upload-hidden" style="width:200px;">
										</div>
		                    		
		                    <% 			}
		                    		}	
		                    	}else if(hospFileList.isEmpty()) {
		                    	//oldOriginalFileName없을때는 insert
		                    	%>
	                    			<div class="filebox">
	                    				<label for="up_file">로고이미지</label>
					                    <input type="file" name="upFile1" id="up_file" class="upload-hidden">
	                    				<label for="up_file2">대표이미지</label>
				                    	<input type="file" name="upFile2" id="up_file2" class="upload-hidden">
									</div>
		                    	<% } %>
		                    </fieldset>
		                    <fieldset>
		                    <legend class="text-label">편의시설</legend>
		                    <input type="checkbox" name="HospConv" id="wifi" value="무선인터넷" <%= h.getHospConv() != null && h.getHospConv().contains("인터넷")? "checked":""%>/>
		                    <label for="wifi">무선인터넷</label>
		                    <input type="checkbox" name="HospConv" id="conv" value="장애인 편의시설" <%= h.getHospConv() != null && h.getHospConv().contains("장애인")? "checked":""%>/>
		                    <label for="conv">장애인 편의시설</label><br />
		                    <input type="checkbox" name="HospConv" id="toilet" value="남/녀 화장실 구분" <%= h.getHospConv() != null && h.getHospConv().contains("화장실")? "checked":""%>/>
		                    <label for="toilet">남/녀 화장실 구분</label>
		                    <input type="checkbox" name="HospConv" id="parking" value="주차" <%= h.getHospConv() != null && h.getHospConv().contains("주차")? "checked":""%>/>
		                    <label for="parking">주차</label><br />
		                    <input type="checkbox" name="HospConv" id="valet" value="발렛파킹" <%= h.getHospConv() != null && h.getHospConv().contains("발렛")? "checked":""%>/>
		                    <label for="valet">발렛파킹</label>
		                    </fieldset>
		                    
		                    <fieldset>
		                    <legend class="text-label">진료시간</legend>
		                    <% String[] weekDay = {"mon", "tue", "wed", "thu", "fri", "sat", "sun" };
					         String[] openTime = {"9:00","9:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00"}; 
					         String[] closeTime = {"14:00","14:30","15:00","15:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00"}; 
					         String[] week = {"월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"};
					         String[] open = {ht.getMonOpen(), ht.getTueOpen(), ht.getWedOpen(), ht.getThuOpen(), ht.getFriOpen(), ht.getSatOpen(), ht.getSunOpen()};
					         String[] close = {ht.getMonEnd(), ht.getTueEnd(), ht.getWedEnd(), ht.getThuEnd(), ht.getFriEnd(), ht.getSatEnd(), ht.getSunEnd()}; %>
					        
					        <% for(int i=0; i<7; i++) {%>
					        	<label for="<%= weekDay[i] %>"><%= week[i] %></label>
					        	<select name="<%= weekDay[i] %>-open" id="">
					        		<option value="" <%="".equals(open[i])? "selected": "" %>>오픈시간</option>
					        	<% for(int j=0; j<openTime.length; j++) {%>
					        		<option value="<%=openTime[j]%>"<%=openTime[j].equals(open[i])? "selected": "" %>><%=openTime[j]%></option>
					           	<% } %>
					           	</select>~
					        	<select name="<%= weekDay[i] %>-close" id="">
					        		<option value="" <%="".equals(close[i])? "selected": "" %>>마감시간</option>
					           	<% for(int k=0; k<closeTime.length; k++) {%>
					        		<option value="<%=closeTime[k]%>"<%=closeTime[k].equals(close[i])? "selected": "" %>><%=closeTime[k]%></option>
					           	<% } %>
					           	</select><br />
					        <% } %>

	                   	<label for="">점심시간</label>
					        <select name="lunch-open" id="lunch-open">
					            <option value="" <%= ht.getLunOpen() == null ? "selected":"" %>>시작</option>
					            <option value="11:00" <%= "11:00".equals(ht.getLunOpen()) ? "selected":"" %>>11:00</option>
					            <option value="11:30" <%= "11:30".equals(ht.getLunOpen()) ? "selected":"" %>>11:30</option>
					            <option value="12:00" <%= "12:00".equals(ht.getLunOpen()) ? "selected":"" %>>12:00</option>
					            <option value="12:30" <%= "12:30".equals(ht.getLunOpen()) ? "selected":"" %>>12:30</option>
					            <option value="13:00" <%= "13:00".equals(ht.getLunOpen()) ? "selected":"" %>>13:00</option>
					        </select>~
					        <select name="lunch-close" id="lunch-close">
					            <option value="" <%= ht.getLunEnd() == null ? "selected":"" %>>끝</option>
					            <option value="12:00" <%= "12:00".equals(ht.getLunEnd()) ? "selected":"" %>>12:00</option>
					            <option value="12:30" <%= "12:30".equals(ht.getLunEnd()) ? "selected":"" %>>12:30</option>
					            <option value="13:00" <%= "13:00".equals(ht.getLunEnd()) ? "selected":"" %>>13:00</option>
					            <option value="13:30" <%= "13:30".equals(ht.getLunEnd()) ? "selected":"" %>>13:30</option>
					            <option value="14:00" <%= "14:00".equals(ht.getLunEnd()) ? "selected":"" %>>14:00</option>
					        </select>
					        </fieldset>
		                    <!-- <input type="button" value="취소" class="submit-btn" onclick='javascript:history.go(-1);'> -->
	                    	<input type="submit" value="수정" class="submit-btn" />
	                    	<input type="button" value="탈퇴" class="submit-btn" onclick="deleteHospital();"/>
	            		</form>
        	</div>
        </article>
    </section>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>